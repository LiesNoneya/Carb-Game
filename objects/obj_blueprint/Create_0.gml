/// @description Insert description here
// You can write your code in this editor

event_inherited();
//recipe = global.crafting_recipes.debug_recipe_1;
work_count = 0;
rolled = true;
touchable = true;
workable = false;

found_ingredients = ds_list_create();

remaining_ingredients = [];
collected_ingredients = [];
//if it overlaps with an object in its recipe, and that object is not being held, and it still needs that object, take the object.
//I think the object should not be deleted since it might want to be able to keep its state, so it'll just go inactive

/* PLAN
VARIABLES
	array item_cache - stores all the items that are 

FUNCTIONS
	function unroll - unrolls the blueprint and starts the crafting

	function recipe_add - attempt to add the item to the recipe, do nothing to it if unsuccessful
	
	function craft - attempt to craft the object
	
	function reroll - rolls up the blueprint and cancels the crafting, dropping all the items back on the ground.
	
	function count_objects(object) - converts the matching objects in the object cache into the object count format from the array pair and returns whether or not the recipe has a sufficient amount of that object.

*/


grab_setup_ability(grabbed_ability);

function grabbed_ability()
{
	if(rolled)
	{
		unroll();	
	} else
	{
		reroll();	
	}
}

function reroll()
{
	//spill items
	
	//clear memory or whatever
	//swap sprite and state
	sprite_index = spr_blueprint_closed;
	rolled = true;
	workable = false;
	array_foreach(collected_ingredients, free_object);
	array_delete(collected_ingredients, 0, array_length(collected_ingredients));
	array_delete(remaining_ingredients, 0, array_length(remaining_ingredients));
}

function unroll()
{
	remaining_ingredients = read_recipe();
	//prep stuff
	
	
	//swap sprite and state
	sprite_index = spr_blueprint_open;
	rolled = false;
}



function state_start() {
	//just an outline, you can have as many states as you want
	switch(state) {
	case 0: 
	show_debug_message(array_length(remaining_ingredients));
		if(array_length(remaining_ingredients) == 0)
		{
			workable = true;
		}
		break;
	case 1:
		storage_start();
		break;
	case 2:
		workable = false;
		break;
	case 3:
		flung_start();
	}
}

function swap_state(_state) {
	
	//so that state end and start arent called eroniously
	//if you would like to restart a state you could just call state_start manually
	if(state != _state) {
		//call state end
		state_end(_state);
		state = _state;
		//then state start
		state_start();
	}
}

function run_state(state)
{
	switch(state) {
	case 0:
		if(!rolled)
		{
			
			collision_rectangle_list(x - 40, y - 30, x + 40, y + 30, remaining_ingredients, false, true, found_ingredients, false);
			while(ds_list_size(found_ingredients) > 0)
			{
				var _curr_item = ds_list_find_value(found_ingredients, 0);
				take_item(_curr_item);
				show_debug_message("ready to take item!");
				show_debug_message(_curr_item);
				ds_list_delete(found_ingredients, 0);
			}
			if(array_length(remaining_ingredients) == 0)
			{
				workable = true;
			}
		}
		break;
	case 2:
		grab_step();
		break;
	case 3:
		flung_step()
		break;
	}
}	

function read_recipe()
{
	returnArray = [];
	//iterate through the ingredients in the array
	for(var _i = 0; _i < array_length(recipe.ingredients); _i++)
	{
		//iterate for the amount of that ingredient in the recipe
		for(var __i = 0; __i < recipe.amounts[_i]; __i++)
		{
			array_push(returnArray, recipe.ingredients[_i]);
		}
	}
	show_debug_message(returnArray);
	return returnArray;
}

function take_item(_object)
{
	if(_object.grabbed == false)
	{
		//update arrays
		if(array_contains(remaining_ingredients, _object.object_index) && !array_contains(collected_ingredients, _object))
		{
			array_delete(remaining_ingredients, array_get_index(remaining_ingredients, _object.object_index), 1);
			array_push(collected_ingredients, _object);
			_object.swap_state(1);
		}
		//if remaining ingredients is empty, 
		if(array_length(remaining_ingredients) == 0)
		{
			workable = true;
		}
	}
}

function free_object(_object)
{
	_object.storage_x = x;
	_object.storage_y = y;
	_object.swap_state(0);	
}


function approach() {
	
}

function approached() {
	show_debug_message(self.object_index);
	show_debug_message("is being touched!");
}

function init_approach() {
	with(ds_list_find_value(touchers,ds_list_size(touchers) - 1)) {
		updateTarget(touching_inst); 
		target_y = target_y;
		//init goto
		init_goto(1.1,1.3,0,5,false);
		self.state_start();
	}
	approached();
}

function touch_start(_self) {
	with(_self) {
		if(x > target.x) {
		image_xscale = 1;	
		} else {
			image_xscale = -1;	
		}
		_self.swap_state(7);
	}
}

function touch_step(_self) {
	with(_self) {
		
	}
}

function work_hit() {
	work_count += 1;
	if(work_count >= recipe.work_required) {
	instance_create_layer(x,y,"Instances",recipe.result);
	die_general(false);
	}
}