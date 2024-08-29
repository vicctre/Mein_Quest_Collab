
if !current_message and array_length(messages) {
    current_message = array_shift(messages)
}

if current_message and !next_message and array_length(messages) {
	next_message = array_shift(messages)
}

if current_message {
	current_message.step()
	if current_message.ease_out and next_message {
        next_message.step()
    }
	if current_message.is_done {
        current_message = next_message
        next_message = undefined
	}
}
