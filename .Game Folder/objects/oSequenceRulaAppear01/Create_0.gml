/*
The Rula fight intro cutscene is implemented using 3 objects:
- this one
- oSequenceRulaAppear2
- a separate oSequence instance for mein, created in this event
*/
event_inherited()

function triggerSecondPart() {
	oSequenceRulaAppear02.unpause()
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

// create a separate cutscene for Mein
mein_sequence = instance_create_layer(global.player.x, global.player.y, layer, oSequence)
with mein_sequence {
	global.player.visible = false
	sequence = seqMeinGemBossIntro
	sequence_inst = layer_sequence_create(layer, x, y, sequence)
	on_destroy = function() {
		global.player.visible = true	
	}
}
