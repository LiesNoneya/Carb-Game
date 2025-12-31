/// @description Insert description here
// You can write your code in this editor
enum Grabbing_States {Hold, Tug, None}
grabbing = Grabbing_States.None;
grabbed_instance = undefined;
grabbed_obj = undefined;
interacting_instance = undefined;
interacting = false;
//used for dropboxes
mouse_dropped = undefined;
list_mi_hitboxes = ds_list_create();
list_grab_hitboxes = ds_list_create();

window_set_cursor(cr_none);
/*
function interact (_obj) {
	
	//useful if only one instance can be interacted with at a time
	var _was_interacting = false;
	if(interacting) {_was_interacting = true;}
	
	interacting = true;
	
	switch(_obj.object_index) {
		case obj_carb:
			if(interactingWithType(_obj)) {
				obj_carb.interruption();
				cursor_sprite = Sprite15;
				interacting_instance = _obj;
				//drawpetting = true;
				sprite_index = spr_handpet;
				image_index = 0;
			}
			break;
		case obj_yarn:
			if(!_was_interacting) {
				cursor_sprite = Sprite15;
				interacting_instance = _obj;
				sprite_index = spr_handpinch;
			}
	}
}
*/

/*
function stopInteract() {
	if(interacting_instance != undefined)
	{
		switch(interacting_instance.object_index) {
			case obj_carb:

				with(interacting_instance.object_index) {
					petted = false;	
				}
				break;
		}
	}
	interacting_instance = undefined;
	interacting = false;
	//drawpetting = false;
}
*/
#region Mouse Interact and Grab Functions

function interactingWithType (_obj) {
	if(sys_mouse.grabbing == Grabbing_States.None) {
		if(sys_mouse.interacting_instance.object_index == _obj.object_index || sys_mouse.interacting_instance.object_index == hand_empty) {
		return true;
		}
	}
	return false;
}

function grabbed_ability()
{
	//?
}

function mouse_grab_start(_obj)
{
	grabbed_instance = _obj;
	grabbed_obj = _obj.object_index;	
	sprite_index = spr_handpinch;
	switch (_obj.grab_type)
	{
		case Grab_Types.Held:
			grabbing = Grabbing_States.Hold;
			break;
		case Grab_Types.Tug:
			grabbing = Grabbing_States.Tug;
			mouse_tug_start();
			break;
	}
	
}
function mouse_grab_end()
{
	grabbed_instance.obj_grab_end();
	mouse_tug_end();
	mouse_dropped = grabbed_instance;
	grabbing = Grabbing_States.None;	
	grabbed_instance = undefined;
	grabbed_obj = undefined;
	sprite_index = spr_handempty;
	//hope one day I can come up with something better than a stupid 2 frame alarm
	alarm_set(0,2)
}

function mouse_interact_start(_obj)
{
	//show_debug_message(_obj);
	mi_mouse_animate(_obj);
	if(_obj.mi_type == MI_Types.Hold)
	{
		interacting = true;
		interacting_instance = _obj;
		interacting_obj = _obj.object_index;
	}
}
function mouse_interact_end()
{
	//show_debug_message("mouseinteractending!")
	interacting = false;	
	interacting_instance = undefined;
	interacting_obj = undefined;
	sprite_index = spr_handempty;
}

function mouse_tug_start()
{
	tug_start_x = grabbed_instance.x;
	tug_start_y = grabbed_instance.y;
	
}

function mouse_tug_end()
{
	
}

#endregion


//this code sucks if it pisses me off one more time I change it to something normal
function clean_hitbox_lists()
{
	for(var _i = 0; _i < ds_list_size(list_mi_hitboxes); _i++)
	{
		if(ds_list_find_value(list_mi_hitboxes, _i).hitbox_destroy == true)
		{
			ds_list_delete(list_mi_hitboxes, _i);
			_i -= 1;
		}
	}
	for(var _i = 0; _i < ds_list_size(list_grab_hitboxes); _i++)
	{
		if(ds_list_find_value(list_grab_hitboxes, _i).hitbox_destroy == true)
		{
			ds_list_delete(list_grab_hitboxes, _i);
			_i -= 1;
		}
	}
}