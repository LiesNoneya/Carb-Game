//HOW TO USE THIS COMPONENT

//1. Put an enable function in the object's create event.
//2. Put debug_bar_draw in the object's draw event
//3. track yo numba
function debug_bar_enable(_tracking_num, _goal_num, _y_off, _x_scale)
{
	bar_start_num = 0;
	bar_left_border = -(10 *_x_scale);
	bar_right_border = (10 * _x_scale);
	bar_top_border = _y_off - 5;
	bar_bottom_border = _y_off + 5;
}

function debug_bar_draw(_tracking_num, _goal_num)
{
	var _do_outline = (_goal_num <= _tracking_num);
	if(!_do_outline)
	{
		draw_rectangle_color(x + bar_left_border, y + bar_top_border, x + bar_right_border, y + bar_bottom_border, c_white, c_white, c_white, c_white, false);
	}
	var _prog_col = c_lime;
	if((_tracking_num - bar_start_num)/_goal_num < 0)
	{
		
		_prog_col = c_red;
	}
	//if the bar desyncs due to left and right border not being the same number that is caused by this line of code
	draw_rectangle_color(x + bar_left_border, y + bar_top_border, x + (bar_left_border + (bar_right_border-bar_left_border) * ((_tracking_num - bar_start_num)/_goal_num)), y + bar_bottom_border, _prog_col, _prog_col, _prog_col, _prog_col, false);
	if(_do_outline)
	{
		draw_rectangle_color(x + bar_left_border, y + bar_top_border, x + bar_right_border, y + bar_bottom_border, c_white, c_white, c_white, c_white, true);
	}
}