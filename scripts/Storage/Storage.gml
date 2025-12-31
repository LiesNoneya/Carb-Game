// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Storage(){

}


//PLAN
/*
General Storage:
Stored Items are kept in an array
functions for grabbing and releasing an item
Items have a storable variable that can be set freely
Items destroyed must be immediately removed from storage
Items have openstored and closedstored states
Item specific openstored, closedstored and generalstored step, start and end functions.
generalstored can probably be used most of the time, but closedstored will need to be used to ensure
	anything drawn by the item is disabled and reenabled.


Two types of storage, closed and open storage
Closed Storage:
items disappear to the shadow realm and are disabled from interacting with the world in any way
	hitboxes are disabled
	Workable, Grabbable, MIable set to false
	Items are ignored in any location based checks
	Item specific start_tangible and start_intangible functions should be made
Movement code is disabled
Items are invisible
Icons representing the items may be displayed in UIs, 
	but they should not be the actual items to avoid any unintended interactions

Open Storage:
items are visible but behave as if they were being carried by the storer, and are seperated from the world
	positions decided by their storers, with default functionality being an offset from storer
	Grabbable and Miable set by storer config, ideally objects that are visible should be clickable
		Grabbing an item will immediately take it out of storage, MI might be fine.
	Items will not be workable since they cant interact with the outside world.
		Items should be ignored or considered at their storer's position for any location based checks.
Movement code is disabled
*/

