//HOW TO USE THIS COMPONENT

//1. call instantiate hitbox and assign it to a variable
//2. simply check for a hitbox of that name whenever you want to check for a hitbox.

function instantiate_hitbox(_obj_hb){
	var _new_hitbox = instance_create_layer(x,y,layer,_obj_hb);
	_new_hitbox.bound_obj = self;
	//create the hitbox ds list if it doesnt ahve one already
	if(variable_instance_exists(self, "list_hitboxes"))
	{
		ds_list_add(list_hitboxes, _new_hitbox);	
	} else
	{
		list_hitboxes = ds_list_create();
		ds_list_add(list_hitboxes, _new_hitbox);	
	}
	return _new_hitbox;
	
}

function change_hitbox(_var_name, _new_hb_obj)
{
	//checks if the hitbox is in any lists, 
}

function hitbox_list_add(_list, _hb)
{
ds_list_add(_list, _hb);
}