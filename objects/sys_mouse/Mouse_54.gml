if(grabbing == Grabbing_States.None)
{
	var _ds_size = ds_list_size(list_mi_hitboxes)
	if(_ds_size > 0)
	{
		var _hitbox_array = array_create(_ds_size);
		for(var _i = 0; _i < _ds_size; _i++)
		{
			_hitbox_array[_i] = ds_list_find_value(list_mi_hitboxes, _i);

		}
	
		var _clicked = collision_point(mouse_x, mouse_y, _hitbox_array, false, true);
		if(_clicked != noone)
		{
			if(_clicked.bound_obj.miable = true)
			{
				_clicked.bound_obj.obj_mi_press();	
				mouse_interact_start(_clicked.bound_obj);
			}
		}
	}
} 
//this must be replaced
else if(grabbed_instance.grab_miable) {
	grabbed_instance.obj_mi_press();	
	mouse_interact_start(grabbed_instance);
}

//figure out a way to make this more efficient
//there isnt any code down here so I think that means I did it