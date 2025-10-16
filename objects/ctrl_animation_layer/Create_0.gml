event_inherited();
base = undefined;
depth_offset = 0;
//whether or not the speed of the base will effect the speed of the animation layer.
sync_speed = false;
//base_anim_array = undefined;
//anim_array = undefined;

function snap_to_base()
{
	x = base.x;
	y = base.y;
	image_angle = base.image_angle;
	image_xscale = base.image_xscale;
	depth = base.depth + depth_offset;
}