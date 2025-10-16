/// @description Insert description here
// You can write your code in this editor
	var cam_adj_x = cam_x - calc_cam_width/2;
	var cam_adj_y = cam_y - calc_cam_height/2;
	/*
	switch (cam_mode) {
		case -1: 
			cam_mode = 0;
		case 0: 
			camera_set_view_pos(view_camera[0], cam_adj_x, cam_adj_y);
			break;
		case 1:
			//var mouse_dist_x = mouse_x - obj_bill.x;
			//var mouse_dist_y = mouse_y - obj_bill.center_y;
			//camera_set_view_pos(view_camera[0], cam_base_x + mouse_dist_x/2, cam_base_y + mouse_dist_y/2);
			break;
			//janky as hell idgaf
		case 2:
			cam_mode = 1;
			break;
	}
	*/
	
	mouse_prev_x = window_mouse_get_x();
	mouse_prev_y = window_mouse_get_y();
	
	if((mouse_wheel_down() || mouse_wheel_up()) && cam_mult < cam_max && cam_mult > cam_min) {
		cam_x -= (mouse_x - scroll_mouse_x);
		cam_y -= (mouse_y - scroll_mouse_y);
		update_cam_view_pos();
	}
	
//Overengineered debug feature
	if (keyboard_check(ord("C"))){
		cam_mode += 1;
	} else if(keyboard_check(ord("B"))){
		cam_mode -= 1;
	}