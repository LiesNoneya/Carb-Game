/// @description Catching dropped or flung items
if(sys_mouse.mouse_dropped != undefined && sys_mouse.mouse_dropped == other)
{
	//dropped catching
	if(bound_obj != undefined && sys_mouse.mouse_dropped != bound_obj)
	{
		show_debug_message(sys_mouse.mouse_dropped.object_index);
		if(dropbox_filter(sys_mouse.mouse_dropped) && sys_mouse.mouse_dropped.droppable == true)
		{
			show_debug_message("filter passed");
			ds_list_add(sys_mouse.mouse_dropped.dropbox_dropped_on, self);
		}
	}
} else
{
//flung catching

	if(other.grab_state == Grab_States.Flung && other.droppable == true && other != bound_obj)
	{
	
	}
}