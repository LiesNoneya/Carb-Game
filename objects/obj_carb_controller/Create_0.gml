/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
enum States{Stand, Walk, Pet, Whistled, Approaching, Work, Play}
state = States.Stand;
heard_whistle = undefined;
interacting_instance = undefined;
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
		
		case States.Approaching:
			
			break;
			
		case States.Work:
			interacting_instance = undefined;
			curr_job = undefined;
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
		//right when the job starts
		case States.Work:
		//might cause problems if I ever add an object with a worker cap
			//curr_job = working_instance.work_get_available();
			if(curr_job != undefined)
			{
				//its time to work
				work_start();
			} else
			{
				//if job is invalid, go to standing
				swap_state(States.Stand);
			}
		case States.Play:
			if(curr_job != undefined)
			{
				//its time to work
				play_start();
			} else
			{
				//if job is invalid, go to standing
				swap_state(States.Stand);
			}
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
			if(!choose_idle_action())
			{
			
				switch(state)
				{
					//after the carb went to the whistle
					case States.Whistled:
						//the carb intends to work
						intention = Tasks.Work;
						//find the closest task
						interacting_instance = find_near_task(400);	
						try_task();
						break;
					case States.Approaching:
						if(interacting_instance != false)
						{
							switch(intention)
							{
								case Tasks.Work:
									swap_state(States.Work);
									break;
								case Tasks.Play:
									swap_state(States.Play);
							}
							break;
						} else
						{
							swap_state(States.Stand);
						}
					case States.Play:
						swap_state(States.Stand);
				}
				break;
			}
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
			//ensure work related variables are unset if it was interrupted during a work state.
			if(array_contains([States.Approaching, States.Work], state))
			{
				if(interacting_instance != undefined)
				{
					ds_list_delete(interacting_instance.list_working, ds_list_find_index(interacting_instance.list_working, self));
					interacting_instance = undefined;
					job = undefined;
				}
				swap_state(States.Stand);
			}
		case AIFeedback.Hit:

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


//returns true if it chose a random action
function choose_idle_action() {
	if(state == States.Stand) {
		//Add: randomly select between walk, hit, idle anim
		if(irandom(1) == 0)
		{
			intention = Tasks.Play;
			interacting_instance = find_near_task(400);
			if(!try_task())
			{
				swap_state(States.Walk);
			} else
			{
				return true;
			}
		} else
		{
			swap_state(States.Walk);	
		}
	}	else if (state == States.Walk) 
	{
		swap_state(States.Stand);
	}
	return false;
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


//DO NOT USE THIS FUNCTION FOR THINGS OTHER THAN WORK!!! (such as idle bite)
//CREATE A NEW FUNCTION!!! THIS IS ONLY FOR WORKING!!!!!
function job_init()
{
	//curr_job should have been defined by the function that found this job (for example, find_near_task.
	if(curr_job != undefined)
	{
		var _intention_state = States.Stand;
		var _speed_range = [1,1];
		switch(intention)
			{
				case Tasks.Work:
					_intention_state = States.Work;
					_speed_range = [1.6, 2.3];
					break;
				case Tasks.Play:
					_intention_state = States.Play;
					//same value range as idle walk
					_speed_range = [0.4, 2];
					break;
			}
		ds_list_add(interacting_instance.list_working, self);
		if(curr_job.req_approach)
		{
			var _task_pos = work_get_position(interacting_instance, curr_job, pawn);
			walk_to(_task_pos[0], _task_pos[1], _speed_range[0], _speed_range[1], 5);
			swap_state(States.Approaching);	
			return true;
		} else
		{
			swap_state(_intention_state);
			return true;
		}
		
	}
	return false;
}
//requires job, interacting instance and intention to be set.
//returns a bool for whether or not the task was done
function try_task()
{
	//if interacting instance is valid
	if(interacting_instance != undefined)
	{
		//try to start working
		if(!job_init())
		{
			//if unsuccessful, go back to standing
			interacting_instance = undefined;
			swap_state(States.Stand);
			return false;
		}
		//if successful, job_init will have handled everything.
		return true;
	} else
	{
		//if the job was invalid, go back to standing.
		swap_state(States.Stand);
		return false;
	}
}

function work_start()
{
	var _found_match = false;
	//each object will need to have its own work action defined in the below switch statement
	var _work_category = interacting_instance.object_index;
	//but it can use the action of another object if it fulfills one of these conditions
	if(object_get_parent(_work_category) == ctrl_destructable)
	{
		_work_category = ctrl_destructable;
	}
	switch(_work_category)
	{
		case ctrl_destructable:
			_found_match = true;
			chomp(interacting_instance);
			break;
		case obj_spiderfruit:
			_found_match = true;
			eat(interacting_instance);
			break;
	}
	//if it doesnt have a specified action for working on this object, return to idle
	if(!_found_match)
	{
		swap_state(States.Stand);
	}
}

function play_start()
{
	var _found_match = false;
	//each object will need to have its own action defined in the below switch statement
	var _play_category = interacting_instance.object_index;
	//but it can use the action of another object if it fulfills one of these conditions
	if(object_get_parent(_play_category) == ctrl_destructable)
	{
		_play_category = ctrl_destructable;
	}
	switch(_play_category)
	{
		case ctrl_destructable:
			_found_match = true;
			bite(interacting_instance);
			break;
		case obj_spiderfruit:
			_found_match = true;
			eat(interacting_instance);
			break;
	}
	//if it doesnt have a specified action for this object, return to idle
	if(!_found_match)
	{
		swap_state(States.Stand);
	}
}



#region pawn interface functions

function chomp(_obj)
{
	pawn.chomp(_obj);
}

function bite(_obj)
{
	pawn.bite(_obj);
}

function eat(_obj)
{
	pawn.eat(_obj);
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
#endregion