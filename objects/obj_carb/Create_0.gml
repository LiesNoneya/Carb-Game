//TODO:
/*
actually limit distance on carb actions
*/
/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
sys_info.list_carbs_add(self);
//ds_list_add(sys_info.list_carbs, self);

mouse_interact_hitbox = instantiate_hitbox(obj_hb_carb_mi);
mi_enable(MI_Types.Hold);
mi_mouse_sprite = spr_handpet;

grab_enable();
grab_setup_anims(spr_carb_white_grab, spr_carb_white_held, spr_carb_white);
grab_setup_offset(true, 9, 20);


tripping = false;
weight_shitty = 0.88;
//all functions that the AI tries to call in the carb should fail if the carb is not actionable
actionable = true;

//action variables
act_idle_sprite = spr_carb_white;
act_walk_sprite = spr_carb_white_walk;

#region unique actions


function trip()
{
	if(actionable)
	{
		//I should not do it like this this is so hacky someone should kill me
		var _spd = spd;
		interrupt();
		spd = _spd;
		action = Actions.Trip;
		trip_timer = 0;
		tripping = true;
		actionable = false;
		play_anim_hold_frame(spr_carb_white_trip, 9);
	}
}

function snuggle()
{
	if(actionable)
	{
		action = Actions.Snuggle;
		interrupt();
		image_xscale = 1;
		sprite_index = spr_carb_white_snuggle;
		controller.give_feedback(AIFeedback.Right_Clicked);
	}
}
function end_snuggle()
{
	if(action == Actions.Snuggle)
	{
		sprite_index = spr_carb_white;
		controller.give_feedback(AIFeedback.Task_Done);
		action = Actions.Idle;
	}
	
}

function chomp(_obj)
{
	action = Actions.Chomp;
	spd = 0;
	sprite_index = spr_carb_white_chomp;
	image_index = 0;
	nomming_instance = _obj;
	alarm_set(2,36);
}

function bite(_obj)
{
	action = Actions.Strike;
	spd = 0;
	sprite_index = spr_carb_white_chomp;
	image_index = 0;
	nomming_instance = _obj;
	alarm_set(2,36);
}

function eat(_obj)
{
	interrupt();
	action = Actions.Eat;
	spd = 0;
	sprite_index = spr_carb_white_eat;
	image_index = 0;
	nomming_instance = _obj;
	alarm_set(2,36);
}

#endregion

//stops absolutely everything the carb is doing
function interrupt()
{
	//setting variables back to defaults
	spd = 0;
	image_speed = 1;
	//disabling action specific variables
	tripping = false;

	//resetting alarms - DANGEROUS, be sure to double check that all variables set by this alarm are being set back to normal values above.
	alarm_set(0,-1);
	alarm_set(1,-1);
	alarm_set(11,-1);
	
	controller.give_feedback(AIFeedback.Interrupted);
}

function obj_mi_press()
{
	snuggle();
}

function obj_mi_hold()
{
	
}

function obj_mi_release()
{
	end_snuggle();
	//controller.give_feedback(AIFeedback.Task_Done);
}



function lasso(_x, _y) {
		//if carb is touching lasso tile
		var _tilemap = layer_tilemap_get_id("calc_tiles");
		if(!tile_get_empty(tilemap_get_at_pixel(_tilemap,x,y))) {
		//do state stuff
			x = _x;
			y = _y;
		}
	}
	
#region dropbox setup
mouth_box = dropbox_enable_ext(hb_carb_eat, 0, 0, dropped_eat, food_filter);
function food_filter(_obj)
{
	return _obj.object_index == obj_spiderfruit ?  true : false;
}
function dropped_eat(_obj)
{
	with(bound_obj)
	{
		eat(_obj);
	}
}

carry_box = dropbox_setup_new_dropbox_filter(hb_carb_carry, 0, 0, store_item, carry_filter);
function store_item(_obj)
{
	_obj.x = 0;
	_obj.y = 0;
}
function carry_filter(_obj)
{
	return _obj.object_index == obj_spiderfruit ?  false : true;
}
#endregion