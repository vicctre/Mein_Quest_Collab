
function IsStageRoom(index) {
	var room_name = room_get_name(index)
	return string_starts_with(room_name, "W1_")
		   or string_starts_with(room_name, "W2_")
		   or string_starts_with(room_name, "W3_")
}
