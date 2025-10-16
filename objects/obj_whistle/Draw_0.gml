/// @description Insert description here
// You can write your code in this editor

if(draw_radius == true) {
	//max opacity * time left/timer length
	var _alph_per = alarm_get(1)/alarm_1_length;
	draw_set_alpha(0.9 * _alph_per);
	if(whistle_fade)
	{
		draw_circle(call_x, call_y, whistle_distance - 15, true);
	} else {
		draw_circle(x, y, whistle_distance - 15, true);
	}
	draw_set_alpha(1);
}

draw_self();