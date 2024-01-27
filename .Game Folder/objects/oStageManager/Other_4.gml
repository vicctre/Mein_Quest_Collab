
if IsStageRoom(room) and (real(room) > last_unlocked_stage) {
	last_unlocked_stage = real(room)
	save.set("last_unlocked_stage", last_unlocked_stage)
	save.save()
}
