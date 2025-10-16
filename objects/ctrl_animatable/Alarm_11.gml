/// @description Insert description here
// You can write your code in this editor
if(play_anim_sprite == sprite_index) {
	if(play_anim_hold)
	{
		//gotta make sure to reset that image speed!
		image_speed = 0; 
		image_index = play_anim_index_to_hold;
	} else {
		sprite_index = play_anim_rest_sprite;
		image_index = 0;
	}
}
