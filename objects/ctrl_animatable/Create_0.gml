
/// @description Insert description here
//rest_sprite = 
//note that only small changes should be made using this system as the offset is purely visual
//also this system is kind of fragile, these values should only be modified 
anim_x_offset = 0;
anim_y_offset = 0;
list_anim_layers = undefined;
//I know that doing it this way seems overly convoluted but trust me for some reason doing it any more intuitive way desyncs the offset from the animation
//first number is x offset, second is y offset, 
default_frame_offset = [[0,0],[0,0],[0,0],[0,0]];
curr_frame_offset = default_frame_offset;
function get_frame_offset()
{
	var _image_index = image_index;
	while(_image_index >= array_length(curr_frame_offset))
	{
		_image_index -= array_length(curr_frame_offset)
	}
	return curr_frame_offset[_image_index];
}
function get_frame_offset_x()
{
	var _image_index = image_index;
	while(_image_index >= array_length(curr_frame_offset))
	{
		_image_index -= array_length(curr_frame_offset)
	}
	return curr_frame_offset[_image_index, 0];
}
function get_frame_offset_y()
{
	var _image_index = image_index;
	while(_image_index >= array_length(curr_frame_offset))
	{
		_image_index -= array_length(curr_frame_offset)
	}
	return curr_frame_offset[_image_index, 1];
}

function play_anim(_anim,_rest_spr){
	//initializing variables for the alarm
	play_anim_sprite = _anim;
	play_anim_hold = false;
	//settings the object's sprite to the animation
	sprite_index = _anim;
	anim_sprite = _anim;
	//makes the animation play from the first frame
	image_index = 0;
	play_anim_rest_sprite = _rest_spr;
	//this alarm is automatically set to last for the exact amount of time until the animation ends
	//when it ends, the carbs animation is set to rest_spr
	alarm_set(11,image_number * 6);
	
}

function play_anim_hold_frame(_anim, _index_to_hold)
{
	//initializing variables for the alarm
	play_anim_sprite = _anim;
	play_anim_hold = true;
	//settings the object's sprite to the animation
	sprite_index = _anim;
	play_anim_index_to_hold = _index_to_hold;
	//makes the animation play from the first frame
	image_index = 0;
	//this alarm is automatically set to last for the exact amount of time until the animation ends
	//when it ends, the carbs image speed is set to 0 and the image index is set to _index_to_hold
	alarm_set(11,image_number * 6);
}

function choose_random_sprite(_sprites_arr)
{
	sprite_index = _sprites_arr[irandom(array_length(_sprites_arr) - 1)];
}