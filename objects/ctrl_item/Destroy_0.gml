/// @description Insert description here
// You can write your code in this editor

if(variable_instance_exists(self, "list_hitboxes"))
{
	for(var _i = 0; _i < ds_list_size(list_hitboxes); _i++)
	{
		instance_destroy(ds_list_find_value(list_hitboxes, _i))	
	}
}
sys_mouse.clean_hitbox_lists();