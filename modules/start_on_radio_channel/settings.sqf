//This module allows you to set the starting channel for a specific unit on a specific radio.

//To use this module use the function [unit, radio, channel] call FNC_SetRadio; in the init field of the unit.
//If you want to change the block of a PRC343 you can simply increment the channel past the limit (16) meaning that channel 17 will correspond to Chan. 1 BLK. 2 and channel 33 to Chan. 1 BLK. 3 etc...

//Example:
//[this, "ACRE_PRC343", 2] call FNC_SetRadio;
//[this, "ACRE_PRC117F", 7] call FNC_SetRadio;