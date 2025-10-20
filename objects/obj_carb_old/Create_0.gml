/// @description Insert description here
// You can write your code in this editor
event_inherited();

grabbed = false;
prev_x = 0;
prev_y = 0;
target = obj_whistle;

//target position that doesnt update
target_x = 0;
target_y = 0;

do_tripping = true;

petted = false;

touching_inst = self;
touchers_index = -1;

//set these variables with init_goto, used in state 5
goto_spd_low = 0;
goto_spd_high = 0;
goto_giveup_time = 0;
goto_target_dist = 0;

//Im scared of running out of alarm slots so im reusing the work alarm for eating since they pretty similar
alarm_2_mode = 0;

function state_start() {
	//just an outline, you can have as many states as you want
	switch(state) {
	case 0: 
		//walking
		move_dir = random_range(0,360);
		if(1 == irandom_range(1,100)) {
			spd = 4;	
		} else {
		spd = random_range(0.2,1);
		}
		//spd = random_range(1,4);
		sprite_index = spr_carb_white_walk;
		//amount of time to walk
		alarm_set(0,irandom_range(30, 180));
		//alarm for random tripping
		//change to general stepping event?
		alarm_set(1,48);
		
		break;
	case 1:
		//standing
		spd = 0;
		//amount of time to stand
		alarm_set(0, irandom_range(1, 180));
		sprite_index = spr_carb_white;
		break;
	case 2:
		//grabbed
		interruption();
		spd = 0;
		break;
	case 3:
		//flung
		spd = point_distance(prev_x,prev_y,x,y)
		move_dir = point_direction(prev_x,prev_y,x,y);
		if(spd > 2) {
			sprite_index = spr_carb_white;	
		}
		//
		break;
	case 4:
		//tripping
		image_index = 0;
		sprite_index = spr_carb_white_trip;
		tripTimer = 0;
		break;
	case 5:
		//go to point
		sprite_index = spr_carb_white_walk;
		//location to go to
		
		//turn, and go at a random speed
		move_dir = point_direction(x,y,target_x,target_y);
		spd = random_range(goto_spd_low, goto_spd_high);
		//stop walking at 5 seconds
		if(goto_giveup_time != 0) {
		alarm_set(0, goto_giveup_time);
		}
		//alarm for random tripping
		alarm_set(1,48);
		break;
	case 6:
		//petted
		spd = 0;
		sprite_index = spr_carb_white_snuggle;
		image_xscale = 1;
		petted = true;
		var _self = self;
		//inform the mouse that it is interacting
		with(sys_mouse) {
			interact(_self);	
		}
		break;
	case 7:
		//working - for object interactions where the carb stands still and hits it
		//correct the carbs facing direction before you get here!
		spd = 0;
		sprite_index = spr_carb_white_chomp;
		image_index = 0;
		alarm_2_mode = 0;
		alarm_set(2,image_number * 6);
		break;
		
	case 8:
		//eating
		spd = 0;
		play_anim(spr_carb_white_eat, spr_carb_white);
		image_index = 0;
		alarm_2_mode = 1;
		alarm_set(2, 42);
		break;
	}
		
	
}
function switchWalkingState() {
	if(state == 0) {
		swap_state(1);	
		//state_start();
	}	else if (state == 1) {
		swap_state(0);
		//state_start();
	}
	if(state == 5) {
		swap_state(1);
		//state_start();
	}
}

function state_end(_state) {
	switch(state) {
	case 0: 
	
		break;
	case 1:
	
		break;
	case 2:
	
		break;
	case 3:
	
		break;
	case 4:
		//tripping
		image_speed = 1;
		break;
	case 5:
		//following
		if(target == obj_whistle) {
		//check for interactables	
		}
		
		break;
	case 6:
		image_xscale =-1;
		break;
	
	}
	
}
state_start();

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

function updateTarget(_obj) {
	target = _obj;
	target_x = target.x;
	target_y = target.y;
}

#region touching, task, work and Go To functions
function nearTasks (_radius) {
	var _tasks = sys_info.list_workables();
	if(!ds_list_empty(_tasks)) {
		filterDSHasVar(_tasks, 0, "workable");
		if(!ds_list_empty(_tasks)) {
			touching_inst = ds_list_find_value(_tasks,0);
			ds_list_add(touching_inst.touchers,self);
			touchers_index = ds_list_size(touching_inst.touchers) - 1;
			touching_inst.init_approach();
			return true;
		}
	}
	return false;
	//I think I'm done?
}


function init_goto(_spdlow, _spdhigh, _giveuptime, _dist, _tripping) {
goto_spd_low = _spdlow;
goto_spd_high = _spdhigh;
goto_giveup_time = _giveuptime;
goto_target_dist = _dist;
do_tripping = _tripping;
}

function goneTo() {
	target.touch_start(self);
}



//called by events that can interupt working or following, such as grabbing or whistling
function interruption() {
	if(variable_instance_exists(touching_inst, "touchers")) {
		ds_list_delete(touching_inst.touchers,touchers_index);
		touchers_index = -1;
	}
	
}
function work_done() {
	//happy animation?
	swap_state(1);	
	show_debug_message("work done!");
	show_debug_message(state);
	interruption();
}

#endregion

#region special item functions
	

#endregion
