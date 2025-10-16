/// @description Insert description here
// You can write your code in this editor
//these are kinda in a random order and some of them are unused sorry about that
//enum AIFeedback {Task_Done, Instantiated, Trip_Done, Grab_Start, Grab_End, Right_Clicked, Task_Cancelled, Interrupted}
pawn = undefined;	
//used by the pawn to give the controller feedback
function give_feedback(_fb)
{
	switch(_fb)
	{
		case AIFeedback.Task_Done:
			
			break;
	}
}

//used by other objects that would like to interact with the pawn through the controller

function on_pawn_bound()
{
	
}