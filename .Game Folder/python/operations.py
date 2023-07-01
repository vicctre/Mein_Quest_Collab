
from copy import deepcopy

class Base:
    def __init__(self, *args, **kwargs):
        pass
    
    def run(self, room):
        raise Exception('You have to override this!')
    
    def has_to_edit(self, room):
        return True
    def run_validation(self, room):
        pass


class Insert(Base):
    def __init__(self, before, layer):
        '''
        before - name of the layer before which to insert layer
        layer - Layer object
        '''
        self.before = before
        self.layer = deepcopy(layer)
    def run_validation(self, room):
        for lr in room.layers:
            if lr.name == self.layer.name:
                raise Exception(
                    f'Room "{room.name}" already has layer "{self.layer.name}"'
                )
    def run(self, room):
        self.run_validation(room)
        for i in range(len(room.layers)):
            lr = room.layers[i]
            if lr.name == self.before:
                room.layers.insert(i, self.layer)
                return
        raise Exception(
            f'Insert of layer "{self.layer.name}"'
            f'before "{self.before}" failed for room "{room.name}"')


class LayerFixDepth(Base):
    def __init__(self, name):
        '''
        layer - layer name
        '''
        self.name = name
    def run(self, room):
        for i in range(len(room.layers)):
            lr = room.layers[i]
            if lr.name == self.name:
                if i != 0:
                    lr.depth = room.layers[i-1].depth + 1
                    print(f'Fixed depth for {room.name}.{self.name} layer')
                return
        print(f'Warning: no layer {room.name}.{self.name} to fix')
