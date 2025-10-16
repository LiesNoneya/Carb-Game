/// @description Insert description here
// You can write your code in this editor

if(sys_mouse.grabbing == false) {
	//image_speed = 1;
	swap_state(2);
	//state_start();	
	grabbed = true;
	var _self = self;
	play_anim(spr_carb_white_grab, spr_carb_white_held);
	with(sys_mouse) {
	grabbing = true;
	grabbed_instance = _self;
	grabbed_obj = _self.object_index;
	}
	
}