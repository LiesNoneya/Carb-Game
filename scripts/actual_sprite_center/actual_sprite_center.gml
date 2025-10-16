// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//TODO:
/*
basically the idea is that, in order to get which sprite is selected by the user for things like
grabbing and interacting, the center of the sprite cant be used because that may have an offset for animation
alignment purposes, but using this offset center to determine which object is closest to the mouse would be
unintuitive to players, so whenever a new sprite is added I should add it's offset to this function so that
I can get the actual location I want to use for the calculation.

*/
function actual_sprite_center(){

}