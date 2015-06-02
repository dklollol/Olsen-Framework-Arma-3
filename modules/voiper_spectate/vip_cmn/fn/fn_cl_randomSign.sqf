/*
	Author: voiper
	
	Description: Random math sign. Good for random numbers that require a negative range (e.g. -100 to 100).
	
	Parameters:
		None.

	Returns:
		Scalar; -1 or 1.
		
	Example:
		_sign = call vip_cmn_fnc_cl_randomSign;
		_value = _sign * random(100);
		
*/

1 - (2 * round(random(1)))