/*
	Author: voiper
	
	Description: Grabs the RGB values of a particular GUI colour from player's colour profile, then converts them to HTML friendly format. Useful for briefings and addAction.
	
	Parameters:
		0: String; prefix name of colour type (A3 uses "IGUI_BCG", "IGUI_ERROR", "IGUI_WARNING", "IGUI_TEXT", "GUI_BCG", "GUI_TITLETEXT").

	Returns:
		String; colour in RGBA HTML format.
			
	Example:
		_colour = ["IGUI_TEXT"] call vip_cmn_fnc_cl_profileColoursHTML;
*/

_colourType = [_this, 0, "", [""]] call BIS_fnc_param;
_colourType = toUpper _colourType;

if !(_colourType in ["IGUI_BCG", "IGUI_ERROR", "IGUI_WARNING", "IGUI_TEXT", "GUI_BCG", "GUI_TITLETEXT"]) exitWith {["Colour type does not exist in profile."] call BIS_fnc_error};

_r = profileNameSpace getVariable [_colourType + "_RGB_R", 0.8];
_g = profileNameSpace getVariable [_colourType + "_RGB_G", 0.5];
_b = profileNameSpace getVariable [_colourType + "_RGB_B", 0.0];
_a = profileNameSpace getVariable [_colourType + "_RGB_A", 0.8];

[_r, _g, _b, _a] call BIS_fnc_colorRGBAtoHTML