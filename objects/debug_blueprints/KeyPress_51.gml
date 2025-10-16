/// @description Insert description here
// You can write your code in this editor
if(!keyboard_check(vk_control))
{
	blueprint_c = create_blueprint(sys_mouse.x, sys_mouse.y, global.crafting_recipes.debug_recipe_3);
} else
{
	show_debug_message("collected: ");
	show_debug_message(blueprint_c.collected_ingredients);
	show_debug_message("remaining: ");
	show_debug_message(blueprint_c.remaining_ingredients);
}