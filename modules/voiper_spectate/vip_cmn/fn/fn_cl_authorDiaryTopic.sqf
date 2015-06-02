/*
	Author: voiper
	
	Description: Prepares diary for voiper's Modules entries. 
	
	Parameters:
		None.
		
	Returns:
		None.
		
	Example:
		call vip_cmn_fnc_cl_authorDiaryTopic;
*/

if !(player diarySubjectExists "vip_modules_var_cl_diary") then {player createDiarySubject ["vip_modules_var_cl_diary", "voiper's Modules"]};