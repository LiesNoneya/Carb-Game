event_inherited();
//Instance variables
	//the depth of the layer the object is spawned on.
	base_depth = depth;
	//dont modify base depth for most purposes, use this instead!
	depth_mod = 0;
	//direction of movement
	move_dir = 0;
	//direction of knockback
	kb_dir = 0;
	//speed of knockback
	kb_spd = 0;
	//relative speed in the x-axis
	xspd = 0;
	//relative speed in the y-axis
	yspd = 0;
	//aiming direction
	aim_dir = 0;
	//on_collide
	collide = false;
	//list for pierce 1 bullets
	damage_list = ds_list_create();
	//i_frames > 0 => invinicible
	i_frames = 0;
	//when true, destroys instance
	destroy = false;
	//
	previous_sprite = sprite_index; 
	//for objects that have special behaviours based on what they were spawned by, set this to a reference to that object.
	spawner = self;

//Set on create

	//speed of movement. If no mspd is set, spd will be the default speed during collision checks and movement
	spd = 0;
	

	//max speed. Used as a default speed and speedcap
	mspd = 0;
	
	//health of object. Dies with 0 health
	hp = 1;

	//prevents friendly fire. 1 = Player, 2 = Enemies
	team = 0;
	
	//i-frame reset. 0 for no i-frames
	i_frames_reset = 0;
	
	//how much knockback a projectile does/entity takes
	kb_mult = 1;
	
	//multiplier for various things that would be effected by weight in the shitty lazy weight system
	weight_shitty = 0.88;
	
//Methods

	
	relative_update = function()
	{
		//normal movement
		xspd = lengthdir_x(spd, move_dir);
		yspd = lengthdir_y(spd, move_dir);
		//knockback stuff
		kb_decay();
		if(kb_mult != 0) {
			xspd += lengthdir_x(kb_spd, kb_dir);
			yspd += lengthdir_y(kb_spd, kb_dir);
		}
	}
	
	//Parameter: _wall_type: Type of collision to check
	//Uses: x, y, xspd, yspd
	//Updates: 
	collision_check_return = function(_wall_type)
	{
		collide = false;
		var _return = false;
		//vertical collision
		if(place_meeting(x+xspd, y, _wall_type))
		{
			collide = true;
			_return = true;
		}
		//horizontal collision
		if(place_meeting(x, y+yspd, _wall_type))
		{
			collide = true;
			_return = true;
		}
		//both collision
		if(place_meeting(x+xspd, y+yspd, _wall_type))
		{
			collide = true;
			_return = true;
		}
		return _return;
	}
	
	//Parameter: _wall_type: Type of collision to check
	//Uses: x, y, xspd, yspd
	//Updates: collide, destroy
	collision_check_destroy = function(_wall_type)
	{
		collide = false;
		//vertical collision
		if(place_meeting(x+xspd, y, _wall_type))
		{
			collide = true;
			destroy = true;
		}
		//horizontal collision
		if(place_meeting(x, y+yspd, _wall_type))
		{
			collide = true;
			destroy = true;
		}
		//both collision
		if(place_meeting(x+xspd, y+yspd, _wall_type))
		{
			collide = true;
			destroy = true;
		}
	}
	
	//Parameter: _wall_type: Type of collision to check
	//Uses: x, y, xspd, yspd
	//Updates: collide, destroy, xspd, yspd
	collision_check_block = function(_wall_type)
	{
		collide = false;
		var _sgn_x = sign(xspd);
		var _sgn_y = sign(yspd);
		if(place_meeting(x+xspd, y, _wall_type)){
			collide = true;
		}
		while(place_meeting(x+xspd, y, _wall_type) && sign(xspd) == _sgn_x)
		{
			xspd -= _sgn_x;
		}
		if(sign(xspd) != _sgn_x){
			//Remove for a funny
			xspd = 0;
		}

		if(place_meeting(x+xspd, y+yspd, _wall_type)){
			collide = true;
		}
		while(place_meeting(x+xspd, y+yspd, _wall_type) && sign(yspd) == _sgn_y)
		{
			yspd -= _sgn_y;
		}
		if(sign(yspd) != _sgn_y){
			yspd = 0;
		}
	}

	
	//Uses: xspd, yspd
	//Updates: x, y
	move_step = function()
	{
		x += xspd;
		y += yspd;
	}
	
	
	function knockback(_inst_kb, _inst_dir) {
		//changing this will change knockback for all enemies!
		show_debug_message("knockback_called");
		var _base_kb = 2;
		
		var _incoming_kb = _base_kb * kb_mult * _inst_kb;
		
		//temporary implementation. doesn't account for anything.
		
		//kb_dir = _inst_dir;
		
		//add the speeds together in a way that makes sense - prob wont
		if(kb_spd = 0){
			kb_dir = _inst_dir;
		} else {
			//modify the direction instead of overriding it
			var dir_diff = angle_difference(_inst_dir, kb_dir);
			
			//get the speed ratio
			var adj_mult = abs(_incoming_kb/kb_spd);
			//show_debug_message(adj_mult);
			//multiply the directional change by the speed ratio in a logical way
			dir_diff = dir_diff * adj_mult;
			kb_dir += dir_diff;
		}
		kb_spd += _incoming_kb;
	}
	function kb_decay() {
		kb_spd -= 0.1;	
		kb_spd = clamp(kb_spd,0,99)
	}
	
	