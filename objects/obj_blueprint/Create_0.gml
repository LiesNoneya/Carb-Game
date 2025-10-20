/// @description Insert description here
// You can write your code in this editor
enum BPStates {Rolled, Unrolled, Ready}

event_inherited();
//recipe = global.crafting_recipes.debug_recipe_1;
work_count = 0;
craft_state = BPStates.Rolled;
touchable = true;
workable = false;

found_ingredients = ds_list_create();

remaining_ingredients = [];
collected_ingredients = [];

work_enable();

function work_get_available()
{
	if(array_length(remaining_ingredients) == 0 && workable)
	{
		return true;
	} else
	{
		return false;	
	}
}

function work_get_position(_obj)
{
	return [x, y];
}

function work_instructions(_obj)
{
	_obj.chomp(self);
}

function bitten()
{
	work_done();
	instance_create_layer(x,y, "instances", recipe.result);
	array_foreach(collected_ingredients, bpdestroy)
	collected_ingredients = [];
	instance_destroy(self);
}
//I have to make this cuz otherwise array_foreach would pass the array index into instance_destroy and im mad about it
function bpdestroy(_obj)
{
	instance_destroy(_obj);
}
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

grab_enable();
mi_enable(MI_Types.Press);
function obj_mi_press()
{
	if(craft_state == BPStates.Rolled)
	{
		unroll();	
	} else
	{
		reroll();	
	}
}

function obj_mi_hold()
{

}

function obj_mi_release()
{

}

grab_setup_enable_mi();
grab_setup_reaction_functions(disable_work, undefined, undefined, enable_work);

function disable_work()
{
	workable = false;	
}
function enable_work()
{
	if(craft_state == BPStates.Ready)
	{
			workable = true;
	}
}
function grabbed_ability()
{
	if(blueprint_state == BPStates.Rolled)
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
	array_foreach(collected_ingredients, free_object);
	
	//clear memory or whatever
	array_delete(collected_ingredients, 0, array_length(collected_ingredients));
	array_delete(remaining_ingredients, 0, array_length(remaining_ingredients));

	//swap sprite and state
	sprite_index = spr_blueprint_closed;
	swap_craft_state(BPStates.Rolled);
	//prevent crafting
	work_done();
	workable = false;
	}

function unroll()
{
	//prep stuff
	remaining_ingredients = read_recipe();
	
	//swap sprite and state
	sprite_index = spr_blueprint_open;
	swap_craft_state(BPStates.Unrolled);
}



function craft_state_start() {
	switch(craft_state) {
	case BPStates.Rolled: 
	
		break;
	case BPStates.Unrolled:
		break;
	case BPStates.Ready:
		if(grab_state == Grab_States.None)
		{
			workable = true;
		}
		break;
	}
}

function craft_state_end() {
	switch(craft_state) {
	case BPStates.Rolled: 
	
		break;
	case BPStates.Unrolled:
		break;
	case BPStates.Ready:
		
		break;
	}
}

function swap_craft_state(_state) {
	
	//so that state end and start arent called eroniously
	//if you would like to restart a state you could just call state_start manually
	if(craft_state != _state) {
		//call state end
		craft_state_end();
		craft_state = _state;
		//then state start
		craft_state_start();
	}
}	

function read_recipe()
{
	var returnArray = [];
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

//pick the item up and add it to colleccted ingredients
function take_item(_object)
{
	if(_object.grab_state == Grab_States.None || _object.grab_state == Grab_States.Flung)
	{
		//update arrays
		if(array_contains(remaining_ingredients, _object.object_index) && !array_contains(collected_ingredients, _object))
		{
			array_delete(remaining_ingredients, array_get_index(remaining_ingredients, _object.object_index), 1);
			array_push(collected_ingredients, _object);
			_object.enter_storage(self);
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
	//reimplement
	_object.swap_state(ItemStates.Normal);
}

