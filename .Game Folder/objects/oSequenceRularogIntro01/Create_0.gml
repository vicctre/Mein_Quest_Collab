/*
The Rula fight intro cutscene is implemented using 3 objects:
- this one
- oSequenceRularogIntro02
- a separate oSequence instance for mein, created in this event
*/
event_inherited()

function triggerSecondPart() {
	instance_create_layer(oRularog.x, oRularog.y, layer, oSequenceRularogIntro02)
}

function on_destroy() {
	triggerSecondPart()
}

oRularog.state = oRularog.inactiveState
oRularog.visible = false

if global.rula_intro_cutscene_played {
	alarm[0] = 1
	exit
}

visible = false

sequence = seqRularog_Intro01
//frame_roar = 179
destroy_delay = -1
sequence_inst = layer_sequence_create(
			layer, x, y, sequence)

notify_started()

with global.player {
    visible = false
    has_control = false
    hsp = 0
    hsp_to = 0
}


// create a separate cutscene for Mein
mein_sequence = instance_create_layer(global.player.x, global.player.y, layer, oSequence)
with mein_sequence {
	sequence = seqMeinGemBossIntro
	sequence_inst = layer_sequence_create(layer, x, y, sequence)
	on_destroy = function() {
		global.player.visible = true	
	}
}
