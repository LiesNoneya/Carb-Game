/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
total_num_actions = 6;
enum Actions {Idle, Walk, Trip, Snuggle, Chomp, Eat, Strike}
action = Actions.Idle;
controller = undefined;

//Idle variables
act_idle_sprite = undefined;

//Walk variables
act_walk_sprite = undefined;

function act_idle(_time)
{
	if(actionable)
	{
		action = Actions.Idle;
		//standing
		spd = 0;
		//amount of time to stand
		alarm_set(0, _time);
		sprite_index = act_idle_sprite;
		return true;
	} else
	{
		return false;
	}
}

function act_walk(_dir, _spd, _time)
{
	if(actionable)
	{
		action = Actions.Walk;
		move_dir = _dir;
		spd = _spd;
		if(_time < 1) {_time = 1}
		alarm_set(0, _time);
		sprite_index = act_walk_sprite;
		return true;
	} else
	{
		return false;
	}
}

//MAKING A PAWN INTERRUPT FUNCTION
function interrupt()
{
//1.
	//set generic variables back to defaults
	
//2. 
	//disable action specific booleans

//3.
	//reset action related alarms

//4. 
	controller.give_feedback(AIFeedback.Interrupted);
}