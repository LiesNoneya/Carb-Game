function create_blueprint(_x, _y, _recipe) {
	var _newprint = instance_create_layer(_x, _y, "Instances", obj_blueprint); 
	_newprint.recipe = _recipe;
	return _newprint;
}

function create_recipe(_ingredients, _amounts, _result, _work_required) constructor
{
	ingredients = _ingredients;
	amounts = _amounts;
	result = _result;
	work_required = _work_required;
}

global.crafting_recipes = {
	debug_recipe_1 : new create_recipe(
		[obj_spiderfruit, obj_log], 
		[1,1], 
		obj_spidertree,
		3
	),
	debug_recipe_2 : new create_recipe(
		[obj_whistle, obj_log], 
		[1,2], 
		obj_whistle,
		3
	),
	debug_recipe_3 : new create_recipe(
		[obj_log, obj_spiderfruit], 
		[3,2], 
		obj_grass,
		3
	)
	//debug recipe 4, for when I want to add recipes that result in multiple items.
}