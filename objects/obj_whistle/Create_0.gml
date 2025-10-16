/// @description Insert description here
// You can write your code in this editor
whistle_distance = 300;
whistle_default_distance = 25;
whistle_max_distance = 450;
draw_radius = false;
whistle_fade = false;
call_x = 0;
call_y = 0;
alarm_1_length = 100;
// Inherit the parent event
event_inherited();

mi_enable(MI_Types.Hold);
grab_setup_enable_mi();
miable = false;

draw_set_circle_precision(200);


function play_whistle() {
	//draw_radius = true;
	call_x = x;
	call_y = y;
	whistle_fade = true;
	//show_debug_message( ds_list_size(sys_info.list_carbs))
	for(var _i = 0; _i < ds_list_size(sys_info.list_carbs); _i++)
	{
		var _curr_carb = ds_list_find_value(sys_info.list_carbs, _i)
		//show_debug_message(point_distance(call_x, call_y, curr_carb.x, curr_carb.y));
		if(point_distance(call_x, call_y, _curr_carb.x, _curr_carb.y) < whistle_distance)
		{
			_curr_carb.controller.hear_whistle(self);
		}
	}
	//obj_carb.controller.give_feedback(AIFeedback.Heard_Whistle);
}

//6, -5

/*
while right click is held draw the whistle circle

whistle distance gets bigger longer right click is held

makes the call when the whistle right click player let go of it



*/

function obj_mi_press()
{
	whistle_distance = whistle_default_distance;
	draw_radius = true;
	whistle_fade = false;
}

function obj_mi_hold()
{
	whistle_distance += 25;
	whistle_distance = clamp(whistle_distance, 0, whistle_max_distance);
	alarm_set(1, alarm_1_length);
	
}

function obj_mi_release()
{
	play_whistle();
}