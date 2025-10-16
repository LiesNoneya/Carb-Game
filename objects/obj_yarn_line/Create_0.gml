/// @description Insert description here
// You can write your code in this editor
line_x1 = 0;
line_y1 = 0;
line_x2 = 100;
line_y2 = 100;

yarn_color = make_colour_rgb(215, 71, 188);
yarn_outline_color = make_colour_rgb(112, 40, 166);


	
//each point has a row and a column

function init_yarnline(_creator) {
	/*
	if(point_distance(_x1,_y1,_x2,_y2) < 5) {
		instance_destroy();	
	} else {
	*/
		tilemap_ID = layer_tilemap_get_id("calc_tiles");
	var _map_width = (tilemap_get_width(tilemap_ID)) * 8;
	var _map_height = (tilemap_get_height(tilemap_ID)) * 8;
		
		line_x1 = clamp(_creator.x1, 0, _map_width - 1);
		line_x2 = clamp(_creator.x2, 0, _map_width - 1);
		line_y1 = clamp(_creator.y1, 0, _map_height - 1);
		line_y2 = clamp(_creator.y2, 0, _map_height - 1);
		//line_x1 = _creator.x1;
		//line_y1 = _creator.y1;
		//line_x2 = _creator.x2;
		//line_y2 = _creator.y2;
		_creator.x1 = line_x2;
		_creator.y1 = line_y2;
		

	//gets tilemap ID
	
	//tilemap_tileset()
	
	
	//first tile must be empty for this to work. Very jank.
	//blank_tile = tilemap_get(wallmap_ID, 0, 0);
	//I should have removed this comment two billion times by now
	
	var _calc_x = line_x1;
	var _calc_y = line_y1;
	var _line_dir = point_direction(line_x1, line_y1, line_x2, line_y2);
	var _line_dist = point_distance(line_x1, line_y1, line_x2, line_y2);
	var _x_dist = lengthdir_x(4, _line_dir);
	var _y_dist = lengthdir_y(4, _line_dir);
	
	for(var _i = 0; _i < _line_dist/4; _i++) {
	
		var _tilemap_x = _calc_x/8;
		var _tilemap_y = _calc_y/8;
		//sets the tile the line starts on to green
		tilemap_set(tilemap_ID, 1, _tilemap_x, _tilemap_y);
		//travel 4 units in the lines direction
		//if there is another tile, make it green
		_calc_x += _x_dist;
		_calc_y += _y_dist;
		
	}
}
