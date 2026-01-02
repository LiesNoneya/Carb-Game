event_inherited();
drops_enable();
grabbable = false;
droppable = false;
storable = false;
hp = 5;
//sprite it swaps to when hit and sprite it returns to when that animation is finished. 
//leave either undefiend to disable hit animation.
struck_animation_sprites = [undefined,undefined];
//if left undefined, the object will be deleted when it dies
death_sprite = undefined;


work_enable();
//formatted like constructor cuz it basically is one
work_add_job(
	Tasks.Work, 
	has_health,
	true, 
	get_side_position
);
work_add_job(
	Tasks.Play, 
	has_health,
	true, 
	get_side_position
);
	
function has_health()
{
	if(hp > 0)
	{
		return true;
	}
	return false;
}

function get_side_position(_obj)
{
	var _work_side = self.x < _obj.x;
	var _x = x + (_work_side * 50) - 20;
	var _y = y;
	return [_x, _y];
}

function struck()
{
	show_debug_message("ouchiee ouch ouch ouch!");
		hp -= 1;
		
		if(hp <= 0) {
			work_done();
			custom_death_behaviour();
			if(death_sprite != undefined)
			{
				die_general(true);
			} else
			{
				die_general(false);	
			}
		} else {
			if(struck_animation_sprites[0] != undefined &&  struck_animation_sprites[1] != undefined)
			{
				play_anim(struck_animation_sprites[0],struck_animation_sprites[1]);
				custom_struck_behaviour();
			}
		}		
}

//U can figure it out I believe in u
function custom_death_behaviour()
{
	
}

function custom_bit_behaviour()
{
	
}