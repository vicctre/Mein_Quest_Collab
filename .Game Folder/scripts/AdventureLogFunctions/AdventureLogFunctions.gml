function current_log_count() {
	var sum = 0;
	for(var i = 0; i < array_length(global.current_logs); i++) {
		sum += global.current_logs[i];
	}
	return sum;
}