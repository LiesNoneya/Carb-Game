/// @description nom alarm
// You can write your code in this editor
if(action == Actions.Chomp && sprite_index = spr_carb_white_chomp)
{
	chomping_instance.struck();
	alarm_set(2,36);
}

if(action == Actions.Eat && sprite_index = spr_carb_white_eat)
{
	actionable = false;
	eating_instance.eaten();
}