if(hp <= 0 and boss_state != "Defeated") {
	changeState("Defeated");
	oMusic.switch_music(global.sfx_post_battle, false, 0)
}
