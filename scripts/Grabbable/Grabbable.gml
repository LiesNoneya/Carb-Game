enum Grab_States {Held, Flung, None, Tug}
enum Grab_Types {Held, Tug};


//HOW TO USE THIS COMPONENT

//1. Put an enable function in the object's create event. if you use the default enable, make sure you set a mouse interact hitbox!
//2. put grab_step into the object's step event.

//component enable functions initialize all the variables that the component will use and set starting values.

//TODO: 

//add ability to swap between using mi hitbox and custom hitbox after instantiation

//add destroy function to get rid of the hitbox
//did that I think god im so bad at this
function grab_enable()
{
	grab_enable_base();
	grab_uses_mi_hitbox = true;
	hitbox_list_add(sys_mouse.list_grab_hitboxes, mouse_interact_hitbox);
	
	//use this to disable the object being grabbed. note that this will not force the mouse to drop the object.
	
}

//I dont think this works at all
function grab_enable_custom_hb(_obj_hitbox)
{
	grab_enable_base();
	grab_uses_mi_hitbox = false;
	grab_hitbox = _obj_hitbox;
	hitbox_list_add(sys_mouse.list_grab_hitboxes, grab_hitbox);
	
}

//Component setup functions are optional functions that can make initializing specific aspects of a component easier.
//any variables that are required for proper function should be in the enable function, not in a setup function.
//component setup functions should have more descriptive variable names so that the function can be used without looking at the code to see how it works
function grab_setup_offset(_do_offset_and_snap, _x_offset, _y_offset)
{
	grab_do_offset = _do_offset_and_snap;
	grab_offset_x = _x_offset;
	grab_offset_y = _y_offset;
}
function grab_setup_anims(_pickup_anim, _grab_sprite, fling_sprite)
{
	grab_start_anim = _pickup_anim;
	grab_sprite = _grab_sprite;
	grab_fling_animation = fling_sprite;
}
function grab_setup_enable_mi()
{
	grab_miable = true;
}

function grab_setup_enable_tug(_tug_dist, _tug_resistance, _tug_end_function)
{
	grab_type = Grab_Types.Tug;
	tug_dist = _tug_dist;
	tug_resist = _tug_resistance;
	tug_progress = 0;
	tug_end = _tug_end_function;
	tug_mouse_x = 0;
	tug_mouse_y = 0;
	tug_mouse_dist = 0;
}

//allows you to choose functions in the object that will be triggered whenever the object is grabbed or put down.
//set any to undefined if you dont want them
function grab_setup_reaction_functions(_held_start_function, _tug_start_function, _flung_start_function, _none_start_function)
{
	obj_grab_held_start = _held_start_function;
	obj_grab_tug_start = _tug_start_function;
	obj_grab_flung_start = _flung_start_function;
	obj_grab_none_start = _none_start_function;
}

function grab_step()
{
	switch(grab_state)
	{
		case Grab_States.Held:
			grab_prev_x = x;
			grab_prev_y = y;
			x = mouse_x + grab_offset_x;
			y = mouse_y + grab_offset_y;
			
			break;
			
		case Grab_States.Flung:
			if(spd > 60) {
				spd = 60;	
			}
			spd = spd*weight_shitty;
			
			//state change check
			if(spd < 2) {
				grab_swap_state(Grab_States.None);
			}
			break;
			
		case Grab_States.Tug:
			//this implementation works but it breaks the principle of respecting the player's sensitivity
			//to fix I need to scale the room coords with the cam zoom
			tug_progress -= 0.1;
			tug_mouse_update();
			var _mouse_dist = clamp(point_distance(sys_mouse.x, sys_mouse.y, x, y), 0, tug_dist * 0.99);
			//should move the hand by the amount of distance the mouse moved on the screen scaled to the max distance of the hand from the plant
			sys_mouse.x -= tug_mouse_x * tug_dist/global.screen_center_smaller * (tug_dist - _mouse_dist)/tug_dist;
			sys_mouse.y -= tug_mouse_y * tug_dist/global.screen_center_smaller * (tug_dist - _mouse_dist)/tug_dist;
			var _tug_str = clamp(_mouse_dist, 0, tug_dist);
			display_mouse_set(global.screen_center_x, global.screen_center_y);
			tug_progress += 0.2 * (_tug_str/tug_dist);
			
			//if(tug_mouse_dist >= global.screen_center_y)
			//{
				//}
			tug_progress = clamp(tug_progress, 0, tug_resist);
			if(tug_progress >= tug_resist)
			{
				tug_end();
			}
			//tug_progress = 0;
			
	}
}

function grab_state_start()
{
	switch(grab_state)
	{
		case Grab_States.Held:
			miable = false;
			spd = 0;
			if(obj_grab_held_start != undefined)
			{
				obj_grab_held_start();	
			}
			if(controller != undefined)
			{
				actionable = false;
				controller.give_feedback(AIFeedback.Grab_Start);
			}
		//if the sprite doesnt lock to a set offset, use the vector to the mouse as the offset
		if(!grab_do_offset)
		{
			grab_offset_x = x - mouse_x - 1;
			grab_offset_y = y - mouse_y - 1;
		}
		//handle grab animation, filling in any undefined sprites
			if(grab_start_anim != undefined) {
				if(grab_sprite != undefined) {
					play_anim(grab_start_anim, grab_sprite);
				} else {
					//automatically hold the last frame of the grab animation
					play_anim_hold_frame(grab_start_anim, grab_start_anim.image_number);
				}
			} else
			{
				//no animation, just swap to grab sprite
				if(grab_sprite != undefined) {
					sprite_index = grab_sprite;
				}
			}
			//no sprites were entered at all, so do nothing. not recommended if the object does any animations, as they will loop during the grab.
			

			break;
			
		case Grab_States.Flung:
			//can replace with play anim easily if I ever get one
			if(obj_grab_flung_start != undefined)
			{
				obj_grab_flung_start();	
			}
			if(grab_fling_animation != undefined)
			{
				sprite_index = grab_fling_animation;
			}
			spd = point_distance(grab_prev_x, grab_prev_y,x,y)
			move_dir = point_direction(grab_prev_x, grab_prev_y,x,y);
			if(spd < 2) {
				grab_swap_state(Grab_States.None);
			}
			break;
		
		case Grab_States.None:
		//should prob have a check for if the object had mi
			miable = true;
			spd = 0;
			//sprite_index = ;
			if(obj_grab_none_start != undefined)
			{
				obj_grab_none_start();	
			}
			if(controller != undefined) 
			{
				actionable = true;
				controller.give_feedback(AIFeedback.Grab_End);
			}
			break;
		case Grab_States.Tug:
		
			tug_progress = 0;
			display_mouse_set(global.screen_center_x, global.screen_center_y);
			if(obj_grab_tug_start != undefined)
			{
				obj_grab_tug_start();	
			}
			break;
	}
}

function grab_state_end()
{
	switch(grab_state)
	{
		case Grab_States.Held:
			
			break;
		case Grab_States.Flung:
		
			break;
		case Grab_States.Tug:
			set_mouse_to_room_pos(sys_mouse.x, sys_mouse.y);
	}
}

function grab_swap_state(_state) 
{	
	//so that state end and start arent called eroniously
	//if you would like to restart a state you could just call state_start manually
	if(grab_state != _state) {
		//call state end
		grab_state_end();
		grab_state = _state;
		//then state start
		grab_state_start();
	}
}

function grab_released()
{
	grab_swap_state(Grab_States.Flung);	
}

function grab_start()
{
	switch(grab_type)
	{
		case Grab_Types.Held:
			if(object_get_parent(self.object_index) == ctrl_pawn)
			{
				interrupt();
			}
			grab_swap_state(Grab_States.Held);	
			break;
		case Grab_Types.Tug:
			grab_swap_state(Grab_States.Tug);
			break;
	}
}

function grab_end()
{
	switch(grab_type)
	{
		case Grab_Types.Held:
			grab_swap_state(Grab_States.Flung);
			break;
		case Grab_Types.Tug:
			grab_swap_state(Grab_States.None);
			break;
	}
}

#region Grab Related Utilities
//sorry if u need this then ur welcome
function set_mi_and_grab_mi(_bool)
{
	miable = _bool;
	grab_miable = _bool;
}

//snaps an object in the grabbed state to a set position from the mouse
function grab_snap(_x, _y)
{
	grab_offset_x = _x;
	grab_offset_y = _y;
}
#endregion

#region Grab Internal Functions
function tug_mouse_update()
{
	
	tug_mouse_x = clamp(global.screen_center_x - display_mouse_get_x(), -global.screen_center_smaller, global.screen_center_smaller);
	tug_mouse_y = clamp(global.screen_center_y - display_mouse_get_y(), -global.screen_center_smaller, global.screen_center_smaller);
	tug_mouse_dist = clamp(point_distance(global.screen_center_x, global.screen_center_y, display_mouse_get_x(), display_mouse_get_y()), -global.screen_center_smaller, global.screen_center_smaller);
}


function grab_enable_base()
{
	grab_state = Grab_States.None;
	grab_type = Grab_Types.Held;
	grab_do_offset = false;
	grab_offset_x = 0;
	grab_offset_y = 0;
	grab_start_anim = undefined;
	grab_sprite = undefined;
	grab_fling_animation = undefined;
	grabbable = true;
	ability = false;
	grab_prev_x = x;
	grab_prev_y = y;
	obj_grab_start = grab_start;
	obj_grab_end = grab_end;
	grab_miable = false;
	
	obj_grab_held_start = undefined;
	obj_grab_tug_start = undefined;
	obj_grab_flung_start = undefined;
	obj_grab_none_start = undefined;
}
#endregion