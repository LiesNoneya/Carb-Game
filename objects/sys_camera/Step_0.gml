/// @description Insert description here
// You can write your code in this editor
	if (mouse_wheel_up() && cam_mult > cam_min) {
		cam_mult -= 0.04;
		scroll_mouse_x = mouse_x;
		scroll_mouse_y = mouse_y;
		update_cam_view_size();
		
		//use the change in distance between the room position and the window position?
		//(old - room) - (new - room)
		// old - new - 2room
		
	}
	
	if (mouse_wheel_down() && cam_mult < cam_max) {
		cam_mult += 0.04;
		scroll_mouse_x = mouse_x;
		scroll_mouse_y = mouse_y;
		update_cam_view_size();
		
	}
	
	
if (keyboard_check(ord("V"))){
		cam_mult = 1;
		update_cam_view_size();
	}