//HOW TO USE THIS COMPONENT

//1. Put an enable function in the object's create event.
//2. Use a setup function to enable and configure one of the drop types
//3. call a function from the Drop Functions region whenever you need a drop!

//drops on death will be enabled by default
function drops_enable()
{
		//list all the items this object will drop when it dies
		drops = [undefined];
		//these arrays must be as long as drops
			//the amount of copies of the object in this slot of the drops array that have a chance to drop
			//you may leave this array empty if it drops one of each object
		drop_count = [undefined];
			//the chance for the object in this slot to drop, out of 100.
			//you may leave this array empty if you want all drops for to be guarunteed
		drop_chance = [undefined];
		drop_sets = [];	
	
		death_drops = true;
		
		drop_range = 40;
}

function drops_setup_simple(_objs_to_drop, _counts_of_objs, _chance_of_objs, _obj_drop_max_dist)
{
	drops = _objs_to_drop;
	drop_count = _counts_of_objs;
	drop_chance = _chance_of_objs;
}

function drops_setup_add_excl_drop_set(_drops, _counts, _weights)
{
	var _new_set = new create_exclusive_drop_set(_drops, _counts, _weights, self);
	
	array_push(drop_sets, _new_set);
}

//how exclusive drop sets work
	/*
		each index of weights has a weights[index]/(combined value of all indexes) chance of being selected.
		the corresponding object of the same index in drops will be selected.
		the corresponding amount of the same index in counts will be dropped.
		if the corresponding values in drops or counts are undefined, no item will be dropped.
		arrays must be the same length but may contain duplicate values
		
		Important notes - 
		Exclusive drop sets should not be modified after construction.
		object must have a drop_sets array
	*/
function create_exclusive_drop_set(_drops, _counts, _weights, _self) constructor
{
	//drop_range = other.drop_range
	parent = _self;
	drops = _drops;
	counts = _counts;
	weights = _weights;
	total_weight = 0;
	//work_required = _work_required;
	length = array_length(drops);
	for(var _i = 0; _i < length; _i++)
	{
		total_weight += weights[_i];
	}
	drop = drop_set_item;
	
	used = false;
}

function drop_item()
{
	//still need to add randomization
	var _drop = select_drop();
	if(_drop != undefined)
	{
		for(var _i = 0; _i < counts[_drop]; _i++)
		{
			spawn_round_area(x, y, drop_range, 5, array_get(drops,_drop));
		}
	}
	used = true;
}

function drop_set_item()
{
	x = parent.x;
	y = parent.y;
	drop_range = parent.drop_range;
	drop_item();
}

function select_drop()
{
	var _rand_drop = irandom_range(1, total_weight);
	var _num = 0;
	for(var _i = 0; _i < length; _i++)
	{
		_num += weights[_i];
		if(_num >= _rand_drop)
		{
			return _i;	
		}
	}	
}


#region Drop Functions
function drop_all()
{
	if((drops != undefined)) {
		var _does_count = (drop_count != undefined);
		var _does_random = (drop_chance != undefined);
		//iterate through drops list
		for(var _i = 0; _i < array_length(drops); _i++) {
			//default of one of each drop if drop_count is empty
			if(_does_count) {
				//run again for drop count
				for(var __i = 0; __i < array_get(drop_count,_i); __i++) {
					//check for randomness
					if(_does_random)
					{
					//apply randomness
						if(irandom(99) < array_get(drop_chance,_i)) {
							spawn_round_area(x, y, drop_range, 0.1, array_get(drops,_i));
						}
					} else
					{
						spawn_round_area(x, y, drop_range, 0.1, array_get(drops,_i));
					}
				}
			} else {
				//check for randomness
				if(_does_random)
				{
				//apply randomness
					if(irandom(99) < array_get(drop_chance,_i)) {
						spawn_round_area(x, y, drop_range, 0.1, array_get(drops,_i));
					}
				} else
				{
					spawn_round_area(x, y, drop_range, 0.1, array_get(drops,_i));
				}
			}
		}
	}
	for(var _i = 0; _i < array_length(drop_sets); _i++)
	{
		drop_sets[_i].drop();
	}
}

#endregion