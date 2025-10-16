/// @description Insert description here
// You can write your code in this editor

//window mouse get delta???
if(sys_mouse.grabbing = Grabbing_States.None) {
	cam_x += cam_mult * (mouse_prev_x - window_mouse_get_x());
	cam_y += cam_mult * (mouse_prev_y - window_mouse_get_y());
	update_cam_view_pos();
}