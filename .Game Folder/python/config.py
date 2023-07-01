
import operations as ops
from common import *

ROOM_PATTERNS = {
  '^W1_2.+',
}

_layer_to_insert = {
  kType: kTypeInstancesLayer,
}
OPERATIONS = [
  ops.Insert('BG1', Layer({**_layer_to_insert, kName: 'Fog1'})),
  ops.Insert('BG2', Layer({**_layer_to_insert, kName: 'Fog2'})),
  ops.Insert('BG3', Layer({**_layer_to_insert, kName: 'Fog3'})),
]