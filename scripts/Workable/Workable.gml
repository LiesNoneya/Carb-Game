//HOW TO USE THIS COMPONENT

//1. Put an enable function in the object's create event.
//2. Put work_destroy in the object's destroy event.
//3. Add the function work_get_position, which returns an array: [x,y] to create event.
//4. add the function work_get_available, which returns a bool to create event.
//5. add the fucntion work_instructions, which tells the controller what to do as work to the create event.
//6. call work done when the work has been done!

function work_enable()
{
	//work_type = _work_type;
	sys_info.list_workables_add(self);
	list_working = ds_list_create();
}

function work_done()
{
	for(var _i = 0; _i < ds_list_size(list_working); _i++)
	{
		ds_list_find_value(list_working, _i).give_feedback(AIFeedback.Task_Done);	
	}
	ds_list_clear(list_working);
}

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
/*
PLAN

the thing that the carb does to the object it is working on should be normal functionality of the object

when the carb gets to the object, the controller should know that it has reached an object with the intent
to work on it, what object it intends to work on, and what action it needs to perform for the work.

the work will be a carb action, and the controller will tell the carb how to do that action

the worker must check itself if work is done
it basically works like this except the object can also just tell the worker that the work is done.
*/

