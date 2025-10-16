event_inherited();

//take_damage(2);
//if for game over condition
	switch (state) {
		case 0:
			//state behavior
			//walking
			
			break;
		case 1:
			//state behavior
			//standing
			
			//state change check
			
			break;
		case 2:
			//state behavior
			//carried
			if(grabbed = true) {
			prev_x = x;
			prev_y = y;
			x = mouse_x + 9;
			y = mouse_y + 50;
			}
			//state change check
			break;
		case 3:
			//state behavior
			//state flung
			if(spd > 30) {
				spd = 30;	
			}
			spd = spd*0.88;
			
			//state change check
			if(spd < 2) {
				spd = 0;
				if(sprite_index == spr_carb_white) {
					//check for tasks, which swaps to state one if it fails.
					swap_state(1);
					//state_start();
				}
			}
			break;
		case 4:
			//state behaviour
			//tripping
			
			if(image_index == 6) {
			spd = 0;	
			}
			if(image_index == 9 && sprite_index == spr_carb_white_trip) {
				image_speed = 0;
				tripTimer += 1;
			}
			if(tripTimer > irandom_range(20,420)) {
				sprite_index = spr_carb_white_getup;
				image_speed = 1;
				image_index = 0;
				tripTimer = 0;
			}
			if(image_index == 9 && sprite_index == spr_carb_white_getup) {
				swap_state(1);
				//state_start();
			}
			break;
		case 5:
			//going to point
			
			target.approach(self);
			if(point_distance(x,y,target_x,target_y) < goto_target_dist) {
				goneTo();
				//state_start();
			}
			break;
		case 6:
			//petted
			if(petted == false) {
				swap_state(1);	
			}
			break;
		case 7:
			//working
			
			break;
		case 8:
			//eating
			if(sprite_index == rest_sprite) {
			swap_state(1);	
			}
			break;
			
	}
	relative_update();
	if(xspd != 0) image_xscale = sign(-xspd);
	
//}
if(hp <= 0){
	instance_destroy();
}

//var _pre_x = xspd;
//var _pre_y = yspd;
move_step();

//for now
//damage_jacket.x = x;
//damage_jacket.y = y;