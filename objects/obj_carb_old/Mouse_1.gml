/// @description Insert description here
// You can write your code in this editor
var _self = self;
if(sys_mouse.interacting_instance != undefined)
{
	if(sys_mouse.interactingWithType(_self)) {
		sprite_index = spr_carb_white_snuggle;
		swap_state(6);	
	}
} else {
	sprite_index = spr_carb_white_snuggle;
	swap_state(6);
}