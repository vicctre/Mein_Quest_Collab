
from copy import deepcopy

class Base:
    def __init__(self, *args, **kwargs):
        pass
    
    def run(self, room):
        raise Exception('You have to override this!')
    
    def has_to_edit(self, room):
        return True
    
    def run_validation(self, room):
        for lr in room.layers:
            if lr.name == self.layer.name:
                raise Exception(
                    f'Room "{room.name}" already has layer "{self.layer.name}"'
                )

class Insert(Base):
    def __init__(self, before, layer):
        '''
        before - name of the layer before which to insert layer
        layer - Layer object
        '''
        self.before = before
        self.layer = deepcopy(layer)
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
