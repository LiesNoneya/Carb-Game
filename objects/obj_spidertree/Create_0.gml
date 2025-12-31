/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

death_sprite = spr_lies_spidertree_stump;
struck_animation_sprites = [spr_spidertree_damage,spr_spidertree_still];
//list all the items this object will drop when it dies
drops = [obj_log, obj_spiderfluff];

//these arrays must be as long as drops
	//the amount of copies of the object in this slot of the drops array that have a chance to drop
	//you may leave this array empty if it drops one of each object
	drop_count = [3, 2];
	//the chance for the object in this slot to drop, out of 100.
	drop_chance = [100, 100];

drops_setup_add_excl_drop_set([obj_spiderfruit, obj_spiderfluff], [1, 1], [1, 1]);
drops_setup_add_excl_drop_set([obj_spiderfruit, obj_spiderfluff], [1, 1], [1, 1]);


function work_get_position(_obj)
{
	var _tree_side = self.x < _obj.x;
	var _x = x + (_tree_side * 50) - 20;
	var _y = y + random_range(-19,18);
	return [_x, _y];
}

function work_instructions(_obj)
{
	_obj.chomp(self);
}

function custom_struck_behaviour()
{
	if(irandom(2) == 2) {
		drop_fruit();
	}
}

function drop_fruit() {
	var _recently_spawned = spawn_area(x - 8, x + 10, y - 30, y - 50, obj_spiderfruit)
}

