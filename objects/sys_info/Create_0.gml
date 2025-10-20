/// @description Insert description here
// You can write your code in this editor
list_carbs = ds_list_create();
list_workables = ds_list_create();

function list_carbs_add(_obj)
{
	ds_list_add(list_carbs, _obj);	
}
function list_workables_add(_obj)
{
		ds_list_add(list_workables, _obj);	
}


//will need to update this if I ever add screen switching
global.screen_center_x = display_get_width()/2;
global.screen_center_y = display_get_height()/2;
global.window_center_x = window_get_width()/2;
global.window_center_y = window_get_height()/2;
//prob unneccassary i dont really know what good practice is for this
global.screen_center_smaller = min(global.screen_center_x, global.screen_center_x);