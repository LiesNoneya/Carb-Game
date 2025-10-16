/// @description Insert description here
// You can write your code in this editor
cam_mult = 1;
//calc_cam_width = cam_width * cam_mult;
//calc_cam_height = cam_height * cam_mult;
cam_mode = 0;

mouse_prev_x = window_mouse_get_x();
mouse_prev_y = window_mouse_get_y();

scroll_mouse_x = mouse_x;
scroll_mouse_y = mouse_y;

cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);
camera_set_view_size(view_camera[0], cam_width, cam_height);
function update_cam_view_size() {
	calc_cam_width = cam_width * cam_mult;
	calc_cam_height = cam_height * cam_mult;
	camera_set_view_size(view_camera[0], calc_cam_width, calc_cam_height);
}
function update_cam_view_pos() {
	camera_set_view_pos(view_camera[0], cam_x, cam_y);
}


update_cam_view_size();

