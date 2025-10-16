event_inherited();
drops_enable();
grabbable = false;
hp = 5;
//sprite it swaps to when hit and sprite it returns to when that animation is finished. 
//leave either undefiend to disable hit animation.
bitten_animation_sprites = [undefined,undefined];
//if left undefined, the object will be deleted when it dies
death_sprite = undefined;


work_enable();

function work_get_available()
{
	if(hp > 0)
	{
		return true;
	}
	return false;
}

function work_get_position(_obj)
{
	var _work_side = self.x < _obj.x;
	var _x = x + (_work_side * 50) - 20;
	var _y = y;
	return [_x, _y];
}

function work_instructions(_obj)
{
	_obj.chomp(self);
}

function bitten()
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
			if(bitten_animation_sprites[0] != undefined &&  bitten_animation_sprites[1] != undefined)
			{
				play_anim(bitten_animation_sprites[0],bitten_animation_sprites[1]);
				custom_bit_behaviour();
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