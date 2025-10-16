/// @description Insert description here
// You can write your code in this editor
draw_self();
if(state == 1) {
	draw_line(x2,y2,mouse_x,mouse_y);	
}
draw_text(x,y - 100, upest_tile);
draw_text(x,y - 50, downest_tile);
draw_text(x - 100,y - 50, leftest_tile);
draw_text(x + 100,y - 50, rightest_tile);
var _x_size = rightest_tile - leftest_tile;
var _y_size = downest_tile - upest_tile;
draw_text(x - 100,y - 100, _x_size);
draw_text(x + 100,y - 100, _y_size);