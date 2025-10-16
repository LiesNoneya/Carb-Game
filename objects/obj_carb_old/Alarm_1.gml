/// @description tripping alarm
if((state == 0 || state == 5) && do_tripping) {
	if(irandom_range(1,3) == 1) {
		//trip
		swap_state(4);
		state_start();
	} else {
	
		alarm_set(1,48);	
	}
}
