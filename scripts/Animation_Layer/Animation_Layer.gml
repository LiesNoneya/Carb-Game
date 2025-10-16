//animation layers should have an animation that they play for each animation the original object can play
function create_animation_layer(_start_sprite, _depth_offset)
{
	//create the object
	var new_anim_layer = instance_create_layer(x,y,layer,ctrl_animation_layer);
	new_anim_layer.base = self;
	new_anim_layer.sprite_index = _start_sprite;
	depth_offset = _depth_offset;
	with(new_anim_layer)
	{
		snap_to_base();	
	}
	return new_anim_layer;
	
	//add it to the list of animation layers
	
	
	//keeping this in case it needs to be added
	//_base_anims_array, _layer_anims_array
	//store the fed arrays
}
/*
function create_animation_layer_offset(_start_sprite, _depth_offset, _2d_array_frame_offset)
{
	//create the object
	var new_anim_layer = instance_create_layer(x,y,layer,ctrl_animation_layer);
	new_anim_layer.base = self;
	new_anim_layer.sprite_index = _start_sprite;
	depth_offset = _depth_offset;
	curr_frame_offset = _2d_array_frame_offset;
	with(new_anim_layer)
	{
		snap_to_base();	
	}
	return new_anim_layer;
}
*/

function set_list_anim_layers(_object_array)
{
	list_anim_layers = undefined;
	array_copy(list_anim_layers, 0, _object_array, 0, array_length(_object_array));
	list_anim_layers = _object_array;	
}

function snap_all_layers()
{
	if(list_anim_layers != undefined)
	{
		for(var _i = 0; _i < array_length(list_anim_layers); _i++)
		{
			with(list_anim_layers[_i])
			{
				snap_to_base();
			}
		}
	}
}