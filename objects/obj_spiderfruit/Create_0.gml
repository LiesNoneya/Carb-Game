/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

touchable = true;
workable = true;

spawner = self;
dropped = false;

work_enable();

work_add_job(
	Tasks.Work, 
	already_being_eaten, 
	true, 
	food_position
);

work_add_job(
	Tasks.Play, 
	already_being_eaten, 
	true, 
	food_position
);

function already_being_eaten()
{
	if(ds_list_empty(list_working))
	{
		return true;
	}
	return false;
}

function food_position(_obj)
{
	return [x,y];
}

function eaten()
{
	work_done();
	die_general(false);
}