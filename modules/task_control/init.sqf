["Task Control", "Utility to help with Arma 3 Tasks", "Briland"] call FNC_RegisterModule;

//private ["_month", "_hour", "_min", "_startTextArray", "_line", "_unparsedText"];

if (isServer) then {
	serverTaskArray = [];
};

#define ADDTASK(TARGET, DESTINATION, TITLE, DESCRIPTION, WPTITLE) \
[TARGET, DESTINATION, TITLE, DESCRIPTION, WPTITLE] call FNC_ADDTASK;

#define COMPLETETASK(TITLE) \
[TITLE, "Succeeded"] call FNC_SETTASKSTATE;

#define FAILTASK(TITLE) \
[TITLE, "Failed"] call FNC_SETTASKSTATE;

#define CANCELTASK(TITLE) \
[TITLE, "Canceled"] call FNC_SETTASKSTATE;

#define RESETTASK(TITLE) \
[TITLE, "Created"] call FNC_SETTASKSTATE;

#define ASSIGNTASK(TITLE) \
[TITLE, "Assigned"] call FNC_SETTASKSTATE;

#define REMOVETASK(TITLE) \
[TITLE] call FNC_REMOVETASK;

if (isServer) then {
	#include "settings.sqf"
};
