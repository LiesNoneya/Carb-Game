/// @description Insert description here
// You can write your code in this editor
if(alarm_get(0) != -1) {
day_time = day_length - alarm_get(0);
} else {
day_time = -1;	
}

day_elapsed = day_time/day_length;