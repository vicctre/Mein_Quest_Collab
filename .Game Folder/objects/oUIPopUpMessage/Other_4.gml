switch room {
    case rmMainMenu:
        if global.player_pogo_just_unlocked {
            oUIPopUpMessage.Add("You've unlocked stage two!")
            oUIPopUpMessage.Add("You've unlocked pogo attack!")
            global.player_pogo_just_unlocked = false
        }
    break
}