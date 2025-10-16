event_inherited();
//Instance Variables
state = 0;
default_state = 0;
//movement functions (such as boost) will need to array_push themselves to this.
active_movements = [];

//Set On Create

#region Death Variables
death_sprite = sprite_index;
death_drops = false;
#endregion

#region Methods

#region detection methods
//detection with range and width check.
function detect_basic(_agro_dist, _target, _width) {
	//returns true when state will be changed
	if(distance_to_object(_target) < _agro_dist && check_visible(_target, _width)) {
			return true;
		}
}

function detect_timer(_agro_dist, _agro_time, _target, _width, _reset_time, _min_time) {
	/*
	trying to find the least jank solution
	1. starts an alarm
	alarm would add 1 every frame if not visible
	how to deal with reset
	variable that counts up each frame it is paused - might not work
	variable created with the parent object?
	if it equals reset time, reset
	how to return true
	doesn't technically need to return true, as long as it is acting like it returns true
	if alarm time = 0?
	shouldn't even use an alarm at that point
	does a lot of useless busy work
	*/
	//returns true when state will be changed
	if(distance_to_object(_target) < _agro_dist && check_visible(_target, _width)) {
			return true;
		}
}

//detection with range check, _agro_dist = 0 to disable.
function deagro_basic(_agro_dist, _target) {
	//returns true when state will be changed
	if( (distance_to_object(_target) > _agro_dist || _agro_dist == 0) && !check_visible(_target, 1)) {
			return true;
		}
}
//Checks if any walls are between the Object and a target
function check_visible(_target, _width) {
	var _return_var;
		//just set width to 0 if you don't want to worry about it
	if(_width = 0) {
		_return_var = !collision_line(x, y, _target.x, _target.y, obj_wall, false, true);	
	} else {
		
		//math stuff for lines
		//var _y_angle = (x - _target.x);
		//var _x_angle = (y - _target.y);
		
		//var _t = abs(_y_angle) + abs(_x_angle);

		//var _x_dist = _x_angle/_t * _width/2;
		//var _y_dist = _y_angle/_t * _width/2;
		
		var _angle = point_direction(x, y, _target.x, _target.y);
		var _point1x = lengthdir_x(_width,_angle + 90);
		var _point1y = lengthdir_y(_width,_angle + 90);
		var _point2x = lengthdir_x(_width,_angle - 90);
		var _point2y = lengthdir_y(_width,_angle - 90);
		//checks two lines by the determined width
		_return_var = true;
		if(collision_line(_point1x + x,_point1y + y,_point1x + _target.x,_point1y + _target.y, obj_wall, false, true)) {
		_return_var = false;	
		}
		if(collision_line(_point2x + x,_point2y + y,_point2x + _target.x,_point2y + _target.y, obj_wall, false, true)) {
		_return_var = false;
		}
		
		//draw_line_color(_point1x + x,_point1y + y,_point1x + _target.x,_point1y + _target.y,c_gray,c_gray);
		//draw_line_color(_point2x + x,_point2y + y,_point2x + _target.x,_point2y + _target.y,c_gray,c_gray);
	}
	return _return_var;
}

//if you don't like check_visible or have something with a strangely shaped hitbox
function check_visible_strict(_target, _interpolation_dist) {
	var _return_var;
		
		var _angle = point_direction(x, y, _target.x, _target.y);
		
		var _projection = 0;
		
		var _proj_x = x;
		var _proj_y = y;
		//checks projected hitbox locations by determined interpolation
		_return_var = true;
		while(place_meeting(x + _proj_x, y +  _proj_y, _target) == false) {
			//updates projection
			_projection += _interpolation_dist;
			_proj_x = lengthdir_x(_projection,_angle);
			_proj_y = lengthdir_y(_projection,_angle);
			//checks for wall
			//since update happens after target check and before wall check, wall detection takes priority over target detection.
			if(place_meeting(x + _proj_x, y + _proj_y, obj_wall)) {
				_return_var = false;
				return _return_var;
			}
		}
	return _return_var;
}
#endregion

//for anything that has very simple telegraphing
//will very likely have sound functionality in the future.
function telegraphing(_tele_spr,_wait_time, _reset_spd, _alarm) {
	with(self) {
	sprite_index = _tele_spr;
	
	//an alarm must be reserved for telegraphing function
	alarm[_alarm] = _wait_time;
	}
	
	//Handy little thing
	if(_reset_spd == true)
		with(self) {
			spd = 0;
		}
}

//resolves speed for when lots of AI functions are running
//goes after relative update and before move_step
function spd_resolve() {
	var _l = array_length(active_movements);
	for (var i = 0; i < _l; i++) {
		//incase multiple functions end on the first loop
		if(i < 0) {
			i = 0;
		}
		//iterates through all the function names to check which ones are active, then runs them.
		if(_l != 0) {
			switch(active_movements[i]) {

				//function name
				case "boost":
					//add speed
					xspd += boost_x;
					yspd += boost_y;
					//
					boost_x = 0;
					boost_y = 0;
					
					boost_increment(boost_con);
					//show_debug_message("boost found");
					//check for delete
					if(boost_end) {
						kill_boost();
					}
					
					break;
			}
		}
	}
}
#endregion

#endregion


#region State control functions


function state_start() {
	//just an outline, you can have as many states as you want
	switch(state) {
	case 0: 
	
		break;
	case 1:
	
		break;
	case 2:
	
		break;
	case 3:
	
		break;
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

//TO DO: add random drop locations
function die_general(_do_spr) {
	if(_do_spr) {
		sprite_index = death_sprite;
		image_index = 0;
	}
//work
	if(death_drops)
	{
		drop_all();
	}
//forgot to make it actually die lol
	if(!_do_spr)
	{
		instance_destroy(self);	
	}
}
