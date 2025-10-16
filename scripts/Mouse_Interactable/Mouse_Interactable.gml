//HOW TO USE THIS COMPONENT

//1. Put an enable function in the object's create event.
//2. Add the functions obj_mi_press, obj_mi_hold, and obj_mi_release to the objects create event.
//Even if they are empty you must add these. 
//Commented out samples are below to copy/paste into the create event.
//3. the object should also have a mouse_interact_hitbox but it should already have one of those anyways.

enum MI_Types{Press, Hold}

function mi_enable(_mi_type)
{
	mi_held = false;
	mi_type = _mi_type;
	hitbox_list_add(sys_mouse.list_mi_hitboxes, mouse_interact_hitbox);
	//use this to disable the object being mied. note that this will not force the mouse to unmiate the object.
	miable = true;
	mi_mouse_sprite = undefined;
}

function mi_setup_mouse_anim(_mouse_spr)
{
	mi_mouse_sprite = _mouse_spr;
}

//TODO: hold start and hold end interact sprite functionality
function mi_mouse_animate(_obj)
{
	if(_obj.mi_mouse_sprite != undefined)
	{
		switch(_obj.mi_type)
		{
			case MI_Types.Press:
				play_anim(_obj.mi_mouse_sprite, spr_handempty);
				break;
			case MI_Types.Hold:
				sys_mouse.sprite_index = _obj.mi_mouse_sprite;
				break;
		}
	}
}
/*
function obj_mi_press()
{
	
}

function obj_mi_hold()
{

}

function obj_mi_release()
{

}
*/