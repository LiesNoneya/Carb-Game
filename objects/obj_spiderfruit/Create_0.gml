/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

touchable = true;
workable = true;

spawner = self;
dropped = false;

work_enable();

function work_get_available()
{
	if(ds_list_empty(list_working))
	{
		return true;
	}
	return false;
}

function work_get_position(_obj)
{
	return [x,y];
}

function work_instructions(_obj)
{
	_obj.eat(self);
}

function eaten()
{
	work_done();
	die_general(false);
}