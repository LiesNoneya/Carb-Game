	
if(grabbing != Grabbing_States.Tug)
{
	x = mouse_x;
	y = mouse_y;
} else
{
	set_mouse_to_room_pos(tug_start_x, tug_start_y);
}
draw_self();