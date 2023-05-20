import json
import os
import re
from copy import deepcopy
from argparse import ArgumentParser

BASE_ROOM_FNAME = 'RoomBase.yy'
DEPTH_STEP = 100
ROOT_PATH = 'rooms'
ADDED_CHILD_ROOMS = {
  # 'W1_1_part1',
  # 'W1_1_part2',
  # 'W1_1_part3',
  # 'W1_1_part4',
  # 'W1_2_.+',
  '^W1_1_part2$'
}

kDepth = 'depth'
kType = 'resourceType'
kTypeRoom = 'GMRoom'
kParentRoom = 'parentRoom'
kName = 'name'
kTypeBackground = 'GMRBackgroundLayer'
kColor = 'colour'

class Layer:
  def __init__(self, raw_json):
    self.source_json = raw_json
    self.name = raw_json[kName]
    self.type = raw_json[kType]
    self.depth = raw_json[kDepth]
    self.color = raw_json[kColor] if self.type == kTypeBackground else None

  def serialize(self):
    result = deepcopy(self.source_json)
    result[kName] = self.name
    result[kType] = self.type
    result[kDepth] = self.depth
    if self.type == kTypeBackground:
      result[kColor] = self.color
    return result
  
  def __repr__(self):
    return f'Layer({self.type}, {self.name})'


class Room:
  def __init__(self, raw_json, file_path):
    self.source_json = raw_json
    self.layers = make_layers(raw_json)
    self.name = raw_json[kName]
    self.file_path = file_path
    assert_gmtype(self.source_json, 'Room')

  def serialize(self):
    result = deepcopy(self.source_json)
    result['layers'] = serialize_layers(self.layers)
    return result


def assert_gmtype(raw_json, expected):
  raw_json[kType] == kTypeRoom, f'Wrong gm resource type for {expected}: {raw_json[kType]}'


def serialize_layers(layers):
  return [layer.serialize() for layer in layers]


def make_layers(raw_json):  
  return [Layer(lr) for lr in raw_json['layers']]


def find_files(regexp):
  def matches(fname, regexp):
    return re.search(regexp, fname) != None
  result = []
  for root, dirs, files in os.walk(ROOT_PATH):
    for fname in files:
      if matches(fname, regexp):
        result.append(os.path.join(root, fname))
  return result


def get_args():
  args = ArgumentParser()
  args.add_argument('--prioritize-custom', action='store_true')
  return args.parse_args()


def yy2json(s):
  '''removes trailing commas'''
  return re.sub(',(?=\s*[}\]])', '', s)


def load_json(path):
  with open(path, 'r') as f:
    return json.loads(yy2json(f.read()))


def get_base_room():
  paths = find_files(BASE_ROOM_FNAME)
  if len(paths) != 1:
    raise Exception(f'Failed to get base room, found paths: {paths}')
  path = paths[0]
  print(f'Base room loading from: {path}')
  return Room(load_json(path), path)


def get_child_rooms(base_room:Room):
  def is_child(dest, src):
    parent_info = dest[kParentRoom]
    return parent_info != None and parent_info[kName] == src.name
  def is_hand_added(raw_json):
    name = raw_json[kName]
    print(f'Checking {name}')
    for pattern in ADDED_CHILD_ROOMS:
      if re.search(pattern, name) != None:
        return True
    return False

  paths = find_files('.+\.yy')
  result = []
  for pth in paths:
    raw = load_json(pth)
    if (is_hand_added(raw)):
      result.append(Room(raw, pth))
  return result


class RoomUpdater:
  def __init__(self, src, dest):
    self.source_room = src
    self.dest_room = dest
    self.dest_layer_names = self.get_layer_names_set(dest)

  def get_layer_names_set(self, dest):
    return {layer.name for layer in dest.layers}

  def layer_is_absent(self, src_layer):
    return src_layer.name not in self.dest_layer_names

  def run(self):
    print(f'Updating room {self.dest_room.name}')
    source_layers = self.source_room.layers
    dest_layers = self.dest_room.layers
    j = 0
    for i in range(len(source_layers)):
      ch_lr = dest_layers[j]
      bs_lr = source_layers[i]
      if bs_lr.name == 'ui':
        test = True
      if ch_lr.name != bs_lr.name and self.layer_is_absent(bs_lr):
        print(f'Inserting {bs_lr.name} layer')
        dest_layers.insert(j, bs_lr)
        j += 1
        continue
      if ch_lr.type == kTypeBackground:
        ch_lr.color = bs_lr.color
        print('Update color')


def update_child_rooms(child_rooms, base_room:Room):
  base_layers = base_room.layers
  result = []
  for chld in child_rooms:
    try:
      RoomUpdater(base_room, chld).run()
      result.append(chld)
    except Exception as e:
      print(f'Failed to update room {chld.name}: {str(e)}')
  return result


def save_child_rooms(rooms):
  for rm in rooms:
    with open(rm.file_path, 'w') as f:
      json.dump(rm.serialize(), f, indent=2)


def main():
  '''
  0. Собрать все комнаты с parentRoom = RoomBase
  1. Скопировать слои из RoomBase.yy во все наследуемые комнаты
    - сохранить порядок слоев
    - сохранить инстансы
    - при наличии ненаследуемых слоев
      - смещать все последующие слои с увеличением глубины
      - использовать флаг --prioritize-inherited:bool. Если true - вставлять наследуемые слои перед кастомными
      - при конфликте имя+тип_слоя падать с ошибкой
  
  Кейсы:
  base [l1_assets, l2_bg, l3_inst, l4_inst]
  ch1 [l1_assets, l2_bg, l3_inst, l4_inst]
  ch2 [l1_assets, l2_bg, l4_inst]
  ch2 [l1_assets, l4_inst]
  ch3 [l1_assets, l2_bg, custom, l4_inst]
  ch3 [l1_assets, l2_bg, l3_inst, custom, l4_inst]
  '''

  args = get_args()
  print(args.prioritize_custom)
  base_room = get_base_room()
  child_rooms = get_child_rooms(base_room)
  print(f'Child rooms found: {len(child_rooms)}')  
  child_rooms = update_child_rooms(child_rooms, base_room)
  print(f'Child rooms updated: {len(child_rooms)}')  
  save_child_rooms(child_rooms)
  print('Done')


if __name__ == '__main__':
  main()
