for (var i = array_length(alarms_collected) - 1; i >= 0; i--) {
	alarms = alarms_collected[i];
		
	for (var j = 0; j < array_length(alarms); j++) {
		if (alarms[j] == null) {
			continue;
		}
			
		alarm_destroy(j);
	}
		
	array_delete(alarms_collected, i, 1);
}