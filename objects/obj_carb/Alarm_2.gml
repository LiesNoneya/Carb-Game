/// @description nom alarm
// You can write your code in this editor
if(action == Actions.Chomp && sprite_index = spr_carb_white_chomp)
{
	nomming_instance.struck();
	alarm_set(2,36);
}

if(action == Actions.Strike && sprite_index = spr_carb_white_chomp)
{
	nomming_instance.struck();
	controller.give_feedback(AIFeedback.Task_Done);
}

if(action == Actions.Eat && sprite_index = spr_carb_white_eat)
{
	actionable = false;
	nomming_instance.eaten();
}