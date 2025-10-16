/// @description Insert description here
// You can write your code in this editor
pawn = undefined;
controller = undefined;

function spawn()
{
	 var _new_pawn = instance_create_layer(x,y,layer, pawn);
	var _new_controller = instance_create_layer(0,0,layer, controller);
	_new_controller.pawn = _new_pawn;
	_new_pawn.controller = _new_controller;
	_new_controller.on_pawn_bound();
}