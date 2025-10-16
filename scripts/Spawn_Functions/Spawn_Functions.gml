// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//returns the spawned object
function spawn_square_area (_x1,_x2,_y1,_y2, _obj) {
	var _x = random_range(_x1,_x2);
	var _y = random_range(_y1, _y2);
	var _spawned =  instance_create_layer(_x,_y,"Instances",_obj);
	var _self = self;
	_spawned.spawner = _self;
	return _spawned;
}

function spawn_round_area (_x, _y, _max, _min, _obj)
{
	var _mag = random_range(_min, _max);
	var _ang = random_range(0, 360);
	var _x_off = lengthdir_x(_mag, _ang);
	var _y_off = lengthdir_y(_mag, _ang);
	/*
	var _spawned =  instance_create_layer(_x,_y,"Instances",_obj);
	var _self = self;
	_spawned.spawner = _self;
	return _spawned;
	*/
	return instance_create_layer(_x + _x_off, _y + _y_off,"Instances",_obj);
}