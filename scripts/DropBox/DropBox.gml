//HOW TO USE THIS COMPONENT

//1. write your item accept function, which will be executed from the dropbox when an item is accepted by the dropbox.
//it must take one instance as an input, this will be the item that was dropped onto the box.
//you should write the function inside of with(bound_obj), this will simulate executing the function from the object that has the dropbox component.
//2. Put an enable function in the object's create event.
//if you only have one dropbox, you can just put 0 for _db_index in all the functions and it will work fine.

//for multiple dropboxes
//dropboxes are stored in a dslist, their indexes are determined in the order of their creation.
//dropbox_setup_new_dropbox returns the index of the dropbox it creates that can be used to identify the dropbox.
//using these indexes, you can change the offset position, hitboxes or item accept function of each dropbox individually.

//for objects you want to be dropped
//all items that are grabbable have a droppable variable that is set to false. 
//Setting it to true will allow it to be interacted with by dropboxes.
//and this variable can be changed safely at any time.

function dropbox_enable(_spr_hb, _item_accept_function){
	dropboxes = ds_list_create();
	dropbox_setup_new_dropbox(_spr_hb, 0, 0, _item_accept_function);
	
}

//useful if you 
function dropbox_enable_ext(_spr_hb, _x_off, _y_off, _item_accept_function, _filter_function)
{
	dropboxes = ds_list_create();
	dropbox_setup_new_dropbox_filter(_spr_hb, _x_off, _y_off, _item_accept_function, _filter_function);
}
//returns the DS List index of the new dropbox
function dropbox_setup_new_dropbox(_spr_hb, _x_off, _y_off, _item_accept_function)
{
	var _db = instance_create_layer(x, y, "Instances", obj_db);
	var _self = self;
	with(_db)
	{
		bound_obj = _self;
		sprite_index = _spr_hb;
		db_x_off = _x_off;
		db_y_off = _y_off;
		dropbox_filter = no_filter;
		item_accept_function = _item_accept_function;
	}
	ds_list_add(dropboxes, _db);
	return ds_list_size(dropboxes) - 1;
}

function dropbox_setup_new_dropbox_filter(_spr_hb, _x_off, _y_off, _item_accept_function, _filter_function)
{
	var _db = instance_create_layer(x, y, "Instances", obj_db);
	var _self = self;
	with(_db)
	{
		bound_obj = _self;
		sprite_index = _spr_hb;
		db_x_off = _x_off;
		db_y_off = _y_off;
		dropbox_filter = _filter_function;
		item_accept_function = _item_accept_function;
	}
	ds_list_add(dropboxes, _db);
	return ds_list_size(dropboxes) - 1;
}

//chosen function should require an input that will be the object that was dropped and should return a bool
function dropbox_setup_filter(_filter_function, _db_index)
{
	with(ds_list_find_value(dropboxes, _db_index))
	{
		dropbox_filter = _filter_function;
	}
}

function dropbox_setup_change_bounds(_spr_hb, _x_off, _y_off, _db_index)
{
	with(ds_list_find_value(dropboxes, _db_index))
	{
		sprite_index = _spr_hb;
		db_x_off = _x_off;
		db_y_off = _y_off;
	}
}

function dropbox_setup_change_off(_x_off, _y_off, _db_index)
{
	with(ds_list_find_value(dropboxes, _db_index))
	{
		db_x_off = _x_off;
		db_y_off = _y_off;
	}
}

/* PLAN
 Drop box must have
	configurable item filter
	dropbox_accept_item
	input function
	configurable shape
	detect whether an item is dropped on it
	object can have multiple dropboxes
	item instantly does something with the dropped item, it is not stored in the dropbox

*/

function no_filter(_obj)
{
	return true;
}

function dropbox_add_list(_obj, _db_index)
{
	ds_list_add(dropboxes(_db_index), _obj);
}



/*
function create_dropbox()
{
	var _dropbox = 	
}
