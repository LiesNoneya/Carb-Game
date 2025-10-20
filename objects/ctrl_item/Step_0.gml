event_inherited();
grab_step();
//run_state(state);
switch(state)
{
	case ItemStates.Normal:
		
		break;
	case ItemStates.Intangible:
		x = storer.x;
		y = storer.y;
		break;
	case ItemStates.Stored:
		x = storer.x;
		y = storer.y;
		break;
}