/// @description Insert description here
// You can write your code in this editor


function init_grass_option_1() {
	//gets tilemap ID
	floormap_ID = layer_tilemap_get_id("Floor");
	
	//first tile must be empty for this to work. Very jank.
	//I swear I fixed that forever ago
	
	var _floormap_width = tilemap_get_width(floormap_ID);
	var _floormap_height = tilemap_get_height(floormap_ID);
	// add if tile is grassable	check
	for(tile_x = 0; tile_x < _floormap_width; tile_x++) {
		for(tile_y = 0; tile_y < _floormap_height; tile_y++) {
			
			if(!tile_get_empty(tilemap_get(floormap_ID, tile_x, tile_y))) {
				if(irandom(2) == 1) {
					instance_create_layer((tile_x * 64) - 16, (tile_y * 64) - 16, "Instances", obj_grass);
				}
				if(irandom(2) == 1) {
					instance_create_layer((tile_x * 64) + 16, (tile_y * 64) - 16, "Instances", obj_grass);
				}
				if(irandom(2) == 1) {
					instance_create_layer((tile_x * 64) + 16, (tile_y * 64) + 16, "Instances", obj_grass);
				}
				if(irandom(2) == 1) {
					instance_create_layer((tile_x * 64) - 16, (tile_y * 64) + 16, "Instances", obj_grass);
				}
			}
		}
	}
}
//init_grass();

function init_grass_option_2() {
	//set number of grasses that can spawn
	
	//spawn in any location
	
	//grass minimum distance check
	
	
	
}