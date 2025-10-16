event_inherited();
grab_setup_enable_tug(100, 6, pluck);
plucked_sprite = undefined;
plucked_x = 0;
plucked_y = 0;


function pluck()
{
	sprite_index = plucked_sprite;
	grab_type = Grab_Types.Held;
	grab_swap_state(Grab_States.Held);
	grab_snap(plucked_x, plucked_y);
}