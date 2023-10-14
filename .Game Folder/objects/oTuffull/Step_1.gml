if(hp <= 0 and boss_state != "Defeated") {
	changeState("Defeated")
	oMusic.switch_music(noone, false, 0)
}
