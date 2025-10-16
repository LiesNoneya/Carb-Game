/// @description work & eating alarm

switch(alarm_2_mode) {
	//work mode
	case 0:
		if(state == 7) {
			with(touching_inst) {
				work_hit();
			}
			alarm_set(2,image_number * 6);
		}
		break;
	case 1: 
		if(state == 8) {
			with(touching_inst) {
				eaten();
			}
			//since the object just got deleted I am changing these so any attempted references wont crash.
			target = self;
			touching_inst = self;
		}
		break
}