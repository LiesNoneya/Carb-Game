//dont instantiate this by itself, it will not work!
//it is meant to function as part of the dropbox component

//default values
bound_obj = undefined;
dropbox_accept_flung = true;
visible = false;

image_alpha = 0.1;
dropbox_filter = undefined;
db_x_off = 0;
db_y_off = 0;
//did not need this I think
//dropbox_got = ds_list_create();
item_accept_function = undefined;

function accept_item(_obj)
{
	if(_obj != bound_obj)
	{
		if(item_accept_function != undefined)
		{
			item_accept_function(_obj);
		} else
		{
			show_debug_message("Item accept function was never defined.");	
		}
	}
	with(_obj)
	{
		ds_list_clear(dropbox_dropped_on);
	}
}