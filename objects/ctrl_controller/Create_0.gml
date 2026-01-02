/// @description Insert description here
// You can write your code in this editor
//these are kinda in a random order sorry about that
enum AIFeedback {Task_Done, Instantiated, Trip_Done, Grab_Start, Grab_End, Right_Clicked, Task_Cancelled, Interrupted, Hit}
pawn = undefined;	
curr_job = undefined;
intention = undefined;
//used by the pawn to give the controller feedback
function give_feedback(_fb)
{
	switch(_fb)
	{
		case AIFeedback.Task_Done:
			
			break;
	}
}

//used by other objects that would like to interact with the pawn through the controller
//uhm idk what this comment is for I think I decided not to do whatever this is

function on_pawn_bound()
{
	
}

//defines job, returns working instance.
function find_near_task(_dist)
{
	var _best_dist = _dist;
	var _list_workables = sys_info.list_workables;
	var _selected = undefined;
	//iterate through all workable objects
	for(var i = 0; i < ds_list_size(_list_workables); i++)
	{
		//get the object and it's job
		var _workable = ds_list_find_value(_list_workables, i)
		var _job = work_try_task(intention, _workable);
		//if the job is compatible
		if(_job != undefined)
		{
			//if it is the closest compatible object, select it
			var _work_dist = point_distance(pawn.x, pawn.y, _workable.x, _workable.y)
			if(_work_dist < _best_dist)
			{
					_best_dist = _work_dist;
					_selected = _workable;
					curr_job = _job;
			}
		}
	}
	return _selected;
}