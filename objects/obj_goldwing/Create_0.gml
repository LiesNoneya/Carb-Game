/// @description Insert description here
// You can write your code in this editor
event_inherited();

frame_offset_spr_goldwing_body = [[0,0],[0,-2],[0,2],[0,4]];
curr_frame_offset = frame_offset_spr_goldwing_body;
//wings = create_animation_layer_offset(spr_goldwing_wings, 1, curr_offset);
wings = create_animation_layer(spr_goldwing_wings, 1);
list_anim_layers = [wings];

function start_wait(_time)
{
	if(actionable)
	{
		action = Actions.Idle;
		//standing
		spd = 0;
		//amount of time to stand
		alarm_set(0, _time);
		sprite_index = spr_carb_white;
		return true;
	} else
	{
		return false;
	}
}

function start_walk(_dir, _spd, _time)
{
	if(actionable)
	{
		action = Actions.Idle;
		move_dir = _dir;
		spd = _spd;
		if(_time < 1) {_time = 1}
		alarm_set(0, _time);
		sprite_index = spr_carb_white_walk;
		return true;
	} else
	{
		return false;
	}
}