//event_inherited();

if(base != undefined)
{
	//snapping to base is now done with all layers in the ctrl_animatable draw event
	//snap_to_base();
	//in case I need to swap to old plan
	//image_speed = base.image_speed;
	//image_index = base.image_index;

	if(sync_speed)
	{
		image_speed = base.image_speed;	
	} else
	{
		image_speed = 1;	
	}
}