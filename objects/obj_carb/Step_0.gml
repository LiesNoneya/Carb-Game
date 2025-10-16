/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
grab_step();
if(xspd != 0) image_xscale = sign(-xspd);

if(sprite_index == spr_carb_white_walk ) {
	if(alarm_get(1) == -1) {
		//trip
		alarm_set(1,48);
		
	}
} else
{
	alarm_set(1, -1);	
}
if(tripping)
{
	if(image_index == 6) {
			spd = 0;	
	}
	if(image_index == 9 && sprite_index == spr_carb_white_trip) {
		trip_timer += 1;
	}
	if(trip_timer > irandom_range(20,420)) {
		sprite_index = spr_carb_white_getup;
		image_speed = 1;
		image_index = 0;
		trip_timer = 0;
	}
	if(image_index == 9 && sprite_index == spr_carb_white_getup) {
		tripping = false;
		actionable = true;
		controller.give_feedback(AIFeedback.Trip_Done);
	}
}

if(action == Actions.Eat && image_index = 21)
{
	actionable = true;
	controller.give_feedback(AIFeedback.Task_Done);
	
}