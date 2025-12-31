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
	case ItemStates.OpenStored:
		//default stored behaviour
		
		//Item specific functionality
		generalstorage_step();
		openstorage_step();
	case ItemStates.ClosedStored:
		//default stored behaviour
		
		//Item specific functionality
		generalstorage_step();
		closedstorage_step();
		break;
}