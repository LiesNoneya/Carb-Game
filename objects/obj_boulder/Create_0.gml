event_inherited();
//sprite it swaps to when hit and sprite it returns to when that animation is finished. 
//leave either undefiend to disable hit animation.
bitten_animation_sprites = [undefined,undefined];
//if left undefined, the object will be deleted when it dies
death_sprite = undefined;
//list all the items this object will drop when it dies
drops = [obj_rock, obj_flint];
//these arrays must be as long as drops
	//the amount of copies of the object in this slot of the drops array that have a chance to drop
	//you may leave this array empty if it drops one of each object
drop_count = [2,1];
	//the chance for the object in this slot to drop, out of 100.
drop_chance = [100, 100];

drops_setup_add_excl_drop_set([obj_rock, obj_flint], [1,1], [1,3])

choose_random_sprite([spr_boulder_1, spr_boulder_2]);