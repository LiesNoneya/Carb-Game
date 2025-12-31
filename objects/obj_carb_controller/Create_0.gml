/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
enum States{Stand, Walk, Pet, Whistled, Work_Approaching, Work}
state = States.Stand;
heard_whistle = undefined;
working_instance = undefined;
work_dist = 500;

function state_end() {
	switch(state) 
	{
		case States.Stand:
			
			break;
			
		case States.Walk:
			
			break;
		case States.Pet:
			
			break;
			
		case States.Whistled:
			
			break;
		
		case States.Work_Approaching:
			
			break;
			
		case States.Work:
			working_instance = undefined;
			break;
	
	}
	
}
function state_start()
{
	switch(state) 
	{
		case States.Stand:
			pawn.act_idle(irandom_range(1, 180));
			break;
			
		case States.Walk:
		//starts the walk, but if it fails, returns to stand state to try again
			if(!start_idle_walk())
			{
				swap_state(States.Stand);
			}
			break;
		case States.Whistled:
			
			break;
	}
}

function swap_state(_state) {
	
	//so that state end and start arent called eroniously
	//if you would like to restart a state you could just call state_start manually
	if(state != _state) {
		//call state end
		state_end();
		state = _state;
		//then state start
		state_start();
	}
}
function give_feedback(_fb)
{
	switch(_fb)
	{
		case AIFeedback.Task_Done:
			//only triggers if they are in an idle state dw
			choose_idle_action();
			//any state tasks that return to idle once they are finished should be added to the list here
			return_to_idle();
			if(state == States.Whistled)
			{
				
			}
			//remaining states
			switch(state)
			{
				case States.Whistled:
					working_instance = find_near_task(Tasks.Work, 400);	
					if(working_instance != undefined)
					{
						if(!work_start_approach())
						{
							working_instance = undefined;
							swap_state(States.Stand);
						}
					} else
					{
						swap_state(States.Stand);
					}
					break;
				case States.Work_Approaching:
					swap_state(States.Work);
					working_instance.work_instructions(self);
					break;
			}
			break;
			
		case AIFeedback.Instantiated:
			
			break;
		
		case AIFeedback.Trip_Done:
			swap_state(States.Stand);
			state_start();
			break;
		case AIFeedback.Grab_End:
			//show_debug_message("feedback recieved!");
			swap_state(States.Stand);
			state_start();
			break;
		case AIFeedback.Right_Clicked:
			swap_state(States.Pet);
			break;
		case AIFeedback.Interrupted:
			if(array_contains([States.Work_Approaching, States.Work], state))
			{
				if(working_instance != undefined)
				{
					ds_list_delete(working_instance.list_working, ds_list_find_index(working_instance.list_working, self));
					working_instance = undefined;
				}
				swap_state(States.Stand);
			}
		case AIFeedback.Hit:
			if(
			break;
	}
}

function hear_whistle(_obj)
{
	if(pawn.actionable)
	{
		heard_whistle = _obj;
		swap_state(States.Whistled);
		walk_to(heard_whistle.x, heard_whistle.y, 1.6, 2.3, 50);
	}	
}

//Dont let speed be 0!
function walk_to(_target_x, _target_y, _spd_max, _spd_min, _goal_dist)
{
	var _target_dir = point_direction(pawn.x, pawn.y, _target_x, _target_y);
	var _rand_spd = random_range(_spd_max,_spd_min);
	var _walk_time = point_distance(pawn.x, pawn.y, _target_x, _target_y)/_rand_spd;
	_walk_time -= _goal_dist/_rand_spd;
	return pawn.act_walk(_target_dir, _rand_spd, _walk_time);
	//time = length/speed
}
function start_idle_walk()
{
	var _rand_dir = random_range(0,360);
	var _rand_spd = random_range(0.4,2);
	if(1 == irandom_range(1,100)) {
			_rand_spd = 8;	
		}
	var _rand_time = irandom_range(30, 180);
	return pawn.act_walk(_rand_dir, _rand_spd, _rand_time);
		
		//alarm for feedback

		//change to general stepping event?
		//alarm_set(1,48);	
}

function choose_idle_action() {
	if(state == States.Stand) {
		//Add: randomly select between walk, hit, idle anim
		swap_state(States.Walk);	
		
	}	else if (state == States.Walk) {
		//Add: chance to hit something instead.
		swap_state(States.Stand);
	}
}

function on_pawn_bound()
{
	state = States.Stand;
	state_start();
}

function return_to_idle()
{
	if(array_contains([States.Pet, States.Work], state) && pawn.actionable)
	{
		swap_state(States.Stand);
	}
}

function work_start_approach()
{
	if(working_instance.work_get_available())
	{
		var _task_pos = working_instance.work_get_position(pawn);
		walk_to(_task_pos[0], _task_pos[1], 1.6, 2.3, 5);
		swap_state(States.Work_Approaching);	
		ds_list_add(working_instance.list_working, self);
		return true;
	}
	return false;
}

function chomp(_obj)
{
	pawn.chomp(_obj);
}

function eat(_obj)
{
	pawn.eat(_obj);
}