from copy import deepcopy

kDepth = 'depth'
kType = 'resourceType'
kTypeRoom = 'GMRoom'
kParentRoom = 'parentRoom'
kName = 'name'
kTypeBackground = 'GMRBackgroundLayer'
kTypeInstancesLayer = 'GMRInstanceLayer'
kColor = 'colour'

class Layer:
  def __init__(self, raw_json):
    self.source_json = raw_json
    self.name = raw_json[kName]
    self.type = raw_json[kType]
    self.depth = raw_json.get(kDepth, None)
    self.color = raw_json.get(kColor, None) if self.type == kTypeBackground else None

  def serialize(self):
    result = deepcopy(self.source_json)
    result[kName] = self.name
    result[kType] = self.type
    if self.depth != None:
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

