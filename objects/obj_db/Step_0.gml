/// @description Insert description here
// You can write your code in this editor
if(bound_obj != undefined)
{
	x = bound_obj.x + db_x_off;
	y = bound_obj.y + db_y_off;
} else
{
	show_debug_message("bound_obj undefined!");
}