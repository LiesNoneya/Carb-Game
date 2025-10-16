event_inherited();
//Items wont have controllers I think, so this is just to let functions know that it doesnt exist if they try to check for it
controller = undefined;
//Instance Variables
state = 0;

prev_x = 0;
prev_y = 0;
storage_x = 0;
storage_y = 0;

//enables carb interactions, should not be changed after instantiation.
touchable = false;
//whether the object is currently available to be interacted with by carbs.
workable = false;
hp = 6;
//the list of carbs touching the instance that any carb must remove themself from when they are done touching.
touchers = ds_list_create();
//movement functions (such as boost) will need to array_push themselves to this.
active_movements = [];

//Set On Create

weight_shitty = 0.88;

mouse_interact_hitbox = instantiate_hitbox(obj_hb_small_item_mi);
grab_enable();
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

//state 0 is idle, state 1 is in storage, state 2 is grabbed, state 3 is flung

#endregion

#region Default State Functions





#endregion
/*
rip shitty code u wont be missed
#region Carb Interaction Functions

//touch functions
//the part of an interaction executed by the carb
function approach() {
	updateTarget(touching_inst);
	
	//init_goto
	//state_start() or swap_state(5);
	
}

//if the object does anything before the carb approaches it
function approached() {
	
}

function touch_start(_self) {
	with(_self) {
		
	}
}

function touch_step(_self) {
	with(_self) {
		
	}
}

//called by the carb when it touches an object, should not be modified
function init_approach() {
	//start touching
	with(ds_list_find_value(touchers,ds_list_size(touchers) - 1)) {
		approach();
	}
	//start touched
	approached();
	//how will execution work?
}


//common touch type functions
function work_hit() {
		hp -= 1;
		//play hit anim
		if(hp <= 0) {
		//swap to death sprite
		work_done_DSList(touchers);
		}
}

function eaten() {
	if(grabbed == false) {
		instance_destroy();
	}	else {
		interrupt_DSList(touchers);
	}
}

#endregion
*/