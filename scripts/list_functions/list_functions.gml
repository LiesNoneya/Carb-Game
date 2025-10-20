// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//must be called from an object
function listObjectsWithVar(_radius, _ds, _has_variable){
	var _unfiltered = ds_list_create()
	collision_circle_list(x,y, _radius, all, false, true, _unfiltered, true);
	filterDSHasVar(_unfiltered, _ds, _has_variable);
	
}

//if you want to output to the same DS List, set _ds_out to 0
function filterDSHasVar(_ds_in, _ds_out, _var) {
	for(var _i = 0; _i < ds_list_size(_ds_in); _i++) {
		var _curr = ds_list_find_value(_ds_in, _i);
		if(variable_instance_get(_curr, _var)) {
			ds_list_add(_ds_out, _curr);
		} else if(_ds_out == 0) {
			ds_list_delete(_ds_in,_i);
			_i--;
			if(ds_list_empty(_ds_in)) return; 
		}
	}
}


function work_done_DSList(_ds) {
	
	for(var _i = 0; _i < ds_list_size(_ds); _i++) {
		var _curr = ds_list_find_value(_ds, _i);
		with (_curr) {
		work_done();
		}
	}
}

function interrupt_DSList(_ds) {
	
	for(var _i = 0; _i < ds_list_size(_ds); _i++) {
		var _curr = ds_list_find_value(_ds, _i);
		with (_curr) {
		interruption();
		}
	}
}
/*
the list is already ordered by distance!!!
function DSClosest(_ds,_x,_y) {
	var _min =  ds_list_find_value(_ds, 0);
	for(var _i = 0; _i < ds_list_size(_ds); _i++) {
		var _curr = ds_list_find_value(_ds, _i);
		if(abs(point_distance(_x,_y,_curr.x,_curr.y)) < _min) {
			_min = _curr;
		}
	}
	return _min;
}
*/

//removes an item from a ds list by finding its index
function ds_list_remove(_ds_list, _to_remove){
	var _num = ds_list_find_index(_ds_list, _to_remove);
	if(_num != -1)
	{
		ds_list_delete(_ds_list, _num);
		show_debug_message(_ds_list);
	} else
	{
		show_debug_message("item not found in list");	
	}
}

//only adds the item to the list if it is not already present
function ds_list_add_new(_ds_list, _to_add)
{
	if(ds_list_find_index(_ds_list, _to_add) == -1)
	{
		ds_list_add(_ds_list, _to_add);
		return true;
	} 
	show_debug_message(ds_list_find_index(_ds_list, _to_add));
	return false;
}