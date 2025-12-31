/// @description Insert description here
// You can write your code in this editor
if(!keyboard_check(vk_control))
{
	blueprint_a = create_blueprint(sys_mouse.x, sys_mouse.y, global.crafting_recipes.debug_recipe_1);
} else
{
	if(blueprint_a != undefined)
	{
		show_debug_message("collected: ");
		show_debug_message(blueprint_a.collected_ingredients);
		show_debug_message("remaining: ");
		show_debug_message(blueprint_a.remaining_ingredients);
	}
}