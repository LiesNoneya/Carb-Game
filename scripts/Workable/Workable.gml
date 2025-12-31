


//HOW TO USE THIS COMPONENT
//1. Put an enable function in the object's create event.
//1. Add jobs to the object using work_add_job. Each task may only be assigned to one job. 
	//_task_name - what task from the Tasks enum is tied to this job
	//_req_approach - boolean for if this object must be approached before it can be worked on
	//_get_available_function - what function to use to check for if the object is available to be worked on.
	//_get_position_function - if _req_approach is true, what function to use to get the coordinates to walk to.
//3. Put work_destroy in the object's destroy event.

//4. when its time to do the work, have the worker's controller use work_try_task.
	//if the task is incompatible or unavailable, it will return undefined.
	//if the task is compatible and available, it will return the task information created in work_job.




function work_enable()
{
	//work_type = _work_type;
	sys_info.list_workables_add(self);
	list_working = ds_list_create();
	work_jobs_array = array_create(global.total_num_tasks, undefined);
}

function work_add_job(_task_name, _get_available_func, _req_approach, _get_position_func)
{
	work_jobs_array(_task_name) = work_job(_get_available_func, _req_approach, _get_position_func);
}

function work_job(_get_available_func, _req_approach, _get_position_func) constructor
{
	get_available = _get_available_func;
	req_approach = _req_approach;
	get_position = _get_position_func;
}

//optional way to end work early
function work_done()
{
	for(var _i = 0; _i < ds_list_size(list_working); _i++)
	{
		ds_list_find_value(list_working, _i).give_feedback(AIFeedback.Task_Done);	
	}
	ds_list_clear(list_working);
}

//automatically ends work early if the object dies.
function work_destroy()
{
	for(var _i = 0; _i < ds_list_size(sys_info.list_workables); _i++)
	{
		if(ds_list_find_value(sys_info.list_workables, _i) == self)
		{
			ds_list_delete(sys_info.list_workables, _i);
		}
	}
}


function work_try_task(_task, _obj)
{
	//get the job info
	var _job = _obj.work_jobs_array(_task)
	
	//check if that object has that task
	if(_job != undefined)
	{
		if(_obj.work_get_available())
		{
			return _job;
		}
	} 
	return undefined;
	
}
/*
PLAN

the thing that the carb does to the object it is working on should be normal functionality of the object

when the carb gets to the object, the controller should know that it has reached an object with the intent
to work on it, what object it intends to work on, and what action it needs to perform for the work.

the work will be a carb action, and the controller will tell the carb how to do that action

plan rework: the controller will determine what work is being done on the object based on the context of
when the work is started, rather than getting instructions from the working object


the worker must check itself if work is done
it basically works like this except the object can also just tell the worker that the work is done.
*/

