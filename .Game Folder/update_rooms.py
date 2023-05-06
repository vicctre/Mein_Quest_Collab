import json
import os
import re
from copy import deepcopy
from argparse import ArgumentParser

BASE_ROOM_FNAME = 'RoomBase.yy'
DEPTH_STEP = 100
ROOT_PATH = 'rooms'
ADDED_CHILD_ROOMS = {
  'W1_1_part1',
  'W1_1_part2',
  'W1_1_part3',
  'W1_1_part4',
}

kType = 'resourceType'
kTypeRoom = 'GMRoom'
kParentRoom = 'parentRoom'
kName = 'name'
kTypeBackground = 'GMRBackgroundLayer'
kColor = 'colour'

class Layer:
  def __init__(self, raw_json):
    self.source_json = raw_json
    self.name = raw_json['name']
    self.type = raw_json[kType]
    self.depth = raw_json['depth']
    self.layer_type = raw_json[kType]
    self.color = raw_json[kColor] if self.type == kTypeBackground else None

  def serialize(self):
    result = deepcopy(self.source_json)
    result['name'] = self.name
    result[kType] = self.type
    result['depth'] = self.depth
    if self.type == kTypeBackground:
      result[kColor] = self.color
    return result


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
  def is_hand_added(raw_json):
    return raw_json[kName] in ADDED_CHILD_ROOMS
  paths = find_files('.+\.yy')
  result = []
  for pth in paths:
    raw = load_json(pth)
    parent_info = raw[kParentRoom]
    if (parent_info != None and parent_info[kName] == base_room.name
        or is_hand_added(raw)):
      result.append(Room(raw, pth))
  return result
    

def update_child_rooms(child_rooms, base_room:Room):
  base_layers = base_room.layers
  result = []
  for chld in child_rooms:
    if len(chld.layers) != len(base_layers):
      print(f'WARNING: {chld.name} child room skipped bc of different layers structure')
      continue
    for i in range(len(base_layers)):
      ch_lr = chld.layers[i]
      bs_lr = base_layers[i]
      if (ch_lr.name, ch_lr.type) != (bs_lr.name, bs_lr.type):
        print(f'WARNING: {chld.name} child room skipped bc of different layers structure')
        break
      if ch_lr.type == kTypeBackground:
        ch_lr.color = bs_lr.color
        print('Updated color')
    else:
      result.append(chld)
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
  pass


if __name__ == '__main__':
  main()
