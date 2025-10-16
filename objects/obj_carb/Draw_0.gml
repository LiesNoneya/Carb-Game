/// @description Insert description here
// You can write your code in this editor
draw_self();
if(controller != pointer_null)
{
	draw_text(x, y - 50, controller.state);
	draw_text(x, y - 100, action);
}