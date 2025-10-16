/// @description Insert description here
// You can write your code in this editor
if (grabbing != Grabbing_States.None)
{
	grabbed_instance.obj_grab_end();
	mouse_grab_end();
}


/*
rip old shitty code
if(grabbing && grabbed_obj == obj_carb_old) {
grabbing = false;	
grabbed_instance = hand_empty;
grabbed_obj = hand_empty;
} else 