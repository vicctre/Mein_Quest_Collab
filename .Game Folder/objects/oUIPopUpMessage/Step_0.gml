
// start showing messages if just added
if !current_message and array_length(messages) {
    current_message = array_shift(messages)
	audio_play_sound(SFX_Notifi, 3, false)
}

// assign next_message from array if there are any
if current_message and !next_message and array_length(messages) {
	next_message = array_shift(messages)
}

if current_message {
    // start animating next message if current is easing out
	if current_message.ease_out and next_message {
        next_message.step()
        if !next_message.sound_played {
            audio_play_sound(SFX_Notifi, 3, false)
            next_message.sound_played = true
        }
    }
    /// if the last message is easing out turn on menu
	if current_message.ease_out and !next_message {
        with oMenu {
            has_control = true
        }
    }
	current_message.step()
    // move messages queue forward if current message is done
	if current_message.is_done {
        current_message = next_message
        next_message = undefined
        array_shift(messages)
	}
}
