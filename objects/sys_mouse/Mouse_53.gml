/// @description left click function for the whole game

var _ds_size = ds_list_size(list_grab_hitboxes)
if(_ds_size > 0)
{
	var _hitbox_array = array_create(_ds_size);
	for(var _i = 0; _i < _ds_size; _i++)
	{
		_hitbox_array[_i] = ds_list_find_value(list_grab_hitboxes, _i);

	}
	//create a temporary list of all the objects under the mouse
	var _under_mouse = ds_list_create();
	collision_point_list(mouse_x, mouse_y, _hitbox_array, false, true, _under_mouse, true);
	for(var __i = 0; __i < ds_list_size(_under_mouse); __i++)
	{
		//if any of them arent grabbable, remove them from the list
		if(!(ds_list_find_value(_under_mouse, __i).bound_obj.grabbable))
		{
			ds_list_delete(_under_mouse, __i);
		}
	}
	//take the first value in the list, since it was already ordered by distance.
	var _clicked = undefined;
	if(!ds_list_empty(_under_mouse))
	{
		_clicked = ds_list_find_value(_under_mouse, 0);
	}
	if(_clicked != undefined)
	{
		_clicked.bound_obj.obj_grab_start();	
		mouse_grab_start(_clicked.bound_obj);
	}
}

