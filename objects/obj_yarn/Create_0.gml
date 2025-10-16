/// @description Insert description here
// You can write your code in this editor
event_inherited();
init_x1 = 0;
init_y1 = 0;
x1 = 0;
y1 = 0;
x2 = 0;
y2 = 0;

yarn_lines = [];

upest_tile = 0;
downest_tile = 0;
leftest_tile = 0;
rightest_tile = 0;

mi_enable(MI_Types.Hold);
mi_mouse_sprite = spr_handpinch;

#region State Control Functions
function state_start() {
	//just an outline, you can have as many states as you want
	switch(state) {
	case 0: 
	
		break;
	case 1:
		
		
		break;
	}
}

function state_end(_state) {
	switch(state) {
	case 0: 
	
		break;
	case 1:
		trigger_lasso();
		grabbable = true;
		break;
	}
}


//IMPORTANT
/* 
you must copy this function into your objects create event
under your new definitions of state_start and state_end, 
even if you are using event inherited.
*/
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

function state_entry_con(_state) {
	switch(state) {
	case 0: 
		if(false) {
			state = 0;	
		}
		break;
	case 1:
		if(false) {
			state = 1;	
		}
		break;
	case 2:
		if(false) {
			state = 2;	
		}
		break;
	case 3:
		if(false) {
			state = 3;	
		}	
		break;
	}
}


#endregion

function trigger_lasso() {
	#region deal with lines
	
	//draw final line from last line to mouse
	x2 = mouse_x;
	y2 = mouse_y;
	if(point_distance(x1, y1, x2, y2) > 5) {
		var _fin_line = instance_create_layer(0,0, "layer_yarn", obj_yarn_line);
		array_push(yarn_lines, _fin_line);
			var _self = self;
			with(_fin_line) {
				init_yarnline(_self);
			}
	}
	
	//draw final line from mouse to yarn
	x1 = init_x1;
	y1 = init_y1;
	x2 = mouse_x;
	y2 = mouse_y;
	if(point_distance(x1, y1, x2, y2) > 5) {
		var _fin_line = instance_create_layer(0,0, "layer_yarn", obj_yarn_line);
		array_push(yarn_lines, _fin_line);
			var _self = self;
			with(_fin_line) {
				init_yarnline(_self);
			}
	}
	
	array_foreach(yarn_lines, instance_destroy)	
	array_delete(yarn_lines, 0, array_length(yarn_lines));
	#endregion
	
	show_debug_message(point_distance(mouse_x,mouse_y,x,y));
	
	if(point_distance(mouse_x,mouse_y,x,y) < 150) {
		#region set up the tiles
		tilemap_ID = layer_tilemap_get_id("calc_tiles");
	
		var _tilemap_width = tilemap_get_width(tilemap_ID);
		var _tilemap_height = tilemap_get_height(tilemap_ID);
	
		for(var _i = 0; _i < _tilemap_height; _i++) {
			var _low_tile = 0
			var _high_tile = _tilemap_width - 1
			//for each row, find the furthest left and the furthest right tile
			for(_low_tile = _low_tile; tile_get_empty(tilemap_get(tilemap_ID,_low_tile,_i)); _low_tile++) {
				
			}
		
			for(_high_tile = _high_tile; tile_get_empty(tilemap_get(tilemap_ID,_high_tile,_i)); _high_tile--) {
				
			}
			tilemap_set(tilemap_ID, 2, _low_tile, _i);
			tilemap_set(tilemap_ID, 2, _high_tile, _i);
			for(var __i = _low_tile + 1; __i < _high_tile; __i++) {
				tilemap_set(tilemap_ID, 1, __i, _i);
			}

		}
		#endregion
	
		#region move carbs to center
		//Hypothetically I could integrate this into the first pass but that would be such a headache and its not like this is running multiple times a frame literallyt ever so it doesnt need that much efficiency right I think that's how that works.
		var _first = true;
		var _last = 0;
		//for loop to find center location
		for(var _i = 0; _i < _tilemap_height; _i++) {
			for(var __i = 0; __i < _tilemap_width; __i++) {
				if(!tile_get_empty(tilemap_get(tilemap_ID,__i,_i))) {
					if(_first == true) { 
						upest_tile = _i;
						leftest_tile = __i;
					}
					_first = false;
					if( _i > downest_tile) { downest_tile = _i }
					if(__i > rightest_tile) { rightest_tile = __i }
					if(__i < leftest_tile) { leftest_tile = __i }
				}	
			}
		}
		//mean wasnt working for some reason
		var _x_center = (leftest_tile + rightest_tile)/2;
		var _y_center = (upest_tile + downest_tile)/2;
	
		var _self = self;
		with(obj_carb) {
			lasso(_self.x, _self.y);	
		}
	
		#endregion
	}
}

function obj_mi_press()
{
	init_x1 = mouse_x;
	init_y1 = mouse_y;
	x1 = mouse_x;
	y1 = mouse_y;
	grabbable = false;
	
	
	//clean tiles
	var _tilemap_ID = layer_tilemap_get_id("calc_tiles");
	var _tilemap_height = tilemap_get_height(_tilemap_ID);
	var _tilemap_width = tilemap_get_width(_tilemap_ID)
		
	for(var _i = 0; _i < _tilemap_height; _i++) {
		for(var __i = 0; __i < _tilemap_width; __i++) {
			tilemap_set(_tilemap_ID,0,__i,_i);
		}
	}
}

function obj_mi_hold()
{
	x2 = mouse_x;
	y2 = mouse_y;
	if(point_distance(x1, y1, x2, y2) > 5) {
		var _cur_line = instance_create_layer(0,0, "layer_yarn", obj_yarn_line);
		array_push(yarn_lines, _cur_line);
		var _self = self;
		with(_cur_line) {
			init_yarnline(_self);
		}
	}
}

function obj_mi_release()
{
	trigger_lasso();
	grabbable = true;
}
