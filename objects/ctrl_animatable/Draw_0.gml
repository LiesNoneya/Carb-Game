/// @description Insert description here
// You can write your code in this editor
x += get_frame_offset_x();
y += get_frame_offset_y();
snap_all_layers();
draw_self();
x -= get_frame_offset_x();
y -= get_frame_offset_y();