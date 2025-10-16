/// @description Insert description here
// You can write your code in this editor
enum Grabbing_States {Hold, Tug, None}
grabbing = Grabbing_States.None;
grabbed_instance = undefined;
grabbed_obj = undefined;
interacting_instance = undefined;
interacting = false;
//drawpetting = false;
list_mi_hitboxes = ds_list_create();
list_grab_hitboxes = ds_list_create();

//window_set_cursor(cr_none);
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
	grabbing = Grabbing_States.None;	
	grabbed_instance = undefined;
	grabbed_obj = undefined;
	sprite_index = spr_handempty;
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

function set_mouse_to_room_pos(_x, _y)
{
	//I think I can simplify these calculations remind me to check up on that later
	var _cam_x = camera_get_view_x(view_camera[0]);
	var _cam_y = camera_get_view_y(view_camera[0]);
	var _a = [0, 0];
	var _b = [_cam_x, _cam_y];
	var _cam_off_len = point_distance(_a[0], _a[1], _b[0], _b[1]);
	var _cam_off_dir = point_direction(_a[0], _a[1], _b[0], _b[1]);
	var _x_off_b = lengthdir_x(_cam_off_len, _cam_off_dir);
	var _y_off_b = lengthdir_y(_cam_off_len, _cam_off_dir);
	draw_line(_x_off_b, _y_off_b, _a[0], _a[1]);
		
	var _c = [window_get_x(), window_get_y()];
	var _win_off_len = point_distance(_a[0], _a[1], _c[0], _c[1]);
	var _win_off_dir = point_direction(_a[0], _a[1], _c[0], _c[1]);
	var _x_off_c = lengthdir_x(_win_off_len, _win_off_dir);
	var _y_off_c = lengthdir_y(_win_off_len, _win_off_dir);
		
	var _window_mult_w = (window_get_width()/display_get_width())/sys_camera.cam_mult;
	var _window_mult_h = (window_get_height()/display_get_height())/sys_camera.cam_mult;
	display_mouse_set((_x - _x_off_b) * _window_mult_w  + _x_off_c, (_y - _y_off_b) * _window_mult_h + _y_off_c);
}

function clean_hitbox_lists()
{
	for(var _i = 0; _i < ds_list_size(list_mi_hitboxes); _i++)
	{
		if(ds_list_find_value(list_mi_hitboxes, _i).hitbox_destroy == true)
		{
			ds_list_delete(list_mi_hitboxes, _i);
		}
	}
	for(var _i = 0; _i < ds_list_size(list_grab_hitboxes); _i++)
	{
		if(ds_list_find_value(list_grab_hitboxes, _i).hitbox_destroy == true)
		{
			ds_list_delete(list_grab_hitboxes, _i);
		}
	}
}