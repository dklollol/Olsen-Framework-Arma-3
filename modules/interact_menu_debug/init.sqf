["Interact Menu Debug", "Adds a new menu to the framework allowing players to force the ACE Interact Menu to load.", "Starfox64"] call FNC_RegisterModule;

if (!hasInterface) exitWith {};

private ["_html"];

_html = "
<font size='18'>Debugging the Interract Menu</font><br/>
If you cannot access the ACE3 interract menu simply click on the link below.<br/>
<br/>
<execute expression='[] call compile preprocessFileLineNumbers ""\z\ace\addons\interact_menu\XEH_clientInit.sqf"";'>Force ACE Interact Menu<execute/>
";

_html spawn {

	sleep(0.1);

	player createDiaryRecord ["FW_Menu", ["Interact Menu Debug", _this]];

};