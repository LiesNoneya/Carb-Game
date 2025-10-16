/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
drops_enable();
//simple drops test
/*
drops = [obj_whistle,obj_whistle,obj_log,obj_spiderfruit];
//these arrays must be as long as drops
	//the amount of copies of the object in this slot of the drops array that have a chance to drop
	//you may leave this array empty if it drops one of each object
	drop_count = [1,2,5,3];
	//the chance for the object in this slot to drop, out of 100.
	drop_chance = [100,50,20,33];
*/
//exclusive drop set test

drops_setup_add_excl_drop_set([obj_rock, obj_spiderfruit, obj_spiderfluff], [1, 1, 1], [25, 50, 25]);


die_general(false);
