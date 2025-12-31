// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function set_mouse_to_room_pos(_x, _y)
{
	//I think I can simplify these calculations remind me to check up on that later
	var _cam_x = camera_get_view_x(view_camera[0]);
	var _cam_y = camera_get_view_y(view_camera[0]);
	var _a = [0, 0];
	var _b = [_cam_x, _cam_y];
	var _cam_off_len = point_distance(_a[0], _a[1], _b[0], _b[1]);
	var _cam_off_dir = point_direction(_a[0], _a[1], _b[0], _b[1]);
	var _x_off_b = lengthdir_x(_cam_off_len, _cam_off_dir);
	var _y_off_b = lengthdir_y(_cam_off_len, _cam_off_dir);
	draw_line(_x_off_b, _y_off_b, _a[0], _a[1]);
		
	var _c = [window_get_x(), window_get_y()];
	var _win_off_len = point_distance(_a[0], _a[1], _c[0], _c[1]);
	var _win_off_dir = point_direction(_a[0], _a[1], _c[0], _c[1]);
	var _x_off_c = lengthdir_x(_win_off_len, _win_off_dir);
	var _y_off_c = lengthdir_y(_win_off_len, _win_off_dir);
		
	var _window_mult_w = (window_get_width()/display_get_width())/sys_camera.cam_mult;
	var _window_mult_h = (window_get_height()/display_get_height())/sys_camera.cam_mult;
	display_mouse_set((_x - _x_off_b) * _window_mult_w  + _x_off_c, (_y - _y_off_b) * _window_mult_h + _y_off_c);
}