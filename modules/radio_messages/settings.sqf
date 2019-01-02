//Usage: 
//This can store five complete radio message self-interaction triggers
//By default, uses BLUFOR_obj1Flag and BLUFOR_radio1Flag but this is not fixed, you can use whatever you want.
//
//VAR_RADIO_RADIOMESSAGESBLU contains the actual message to be sent. mapPosGrid can be used to provide the 6-figure grid position of the sender.
//VAR_RADIO_RADIOACTIONSBLU contains the conditions for the message to appear
//VAR_RADIO_RADIOINTERACTSBLU contains the interaction menu text

if (isNil "BLUFOR_obj1Flag") then {BLUFOR_obj1Flag = false};
if (isNil "BLUFOR_obj2Flag") then {BLUFOR_obj2Flag = false};
if (isNil "BLUFOR_obj3Flag") then {BLUFOR_obj3Flag = false};
if (isNil "BLUFOR_obj4Flag") then {BLUFOR_obj4Flag = false};
if (isNil "BLUFOR_obj5Flag") then {BLUFOR_obj5Flag = false};

if (isNil "BLUFOR_radio1Flag") then {BLUFOR_radio1Flag = false};
if (isNil "BLUFOR_radio2Flag") then {BLUFOR_radio2Flag = false};
if (isNil "BLUFOR_radio3Flag") then {BLUFOR_radio3Flag = false};
if (isNil "BLUFOR_radio4Flag") then {BLUFOR_radio4Flag = false};
if (isNil "BLUFOR_radio5Flag") then {BLUFOR_radio5Flag = false};

VAR_RADIO_RADIOMESSAGESBLU = [
	[
		[4,"Echo Mike 6, my pos, mapPosGrid, destroyed FIA assets, break."]
	],
	[
		[1,"'dummy'","BLUFOR_radio"]
	],
	[
		[1,"'dummy'","BLUFOR_radio"]
	],
	[
		[1,"'dummy'","BLUFOR_radio"]
	],
	[
		[1,"'dummy'","BLUFOR_radio"]
	]
];

VAR_RADIO_RADIOACTIONSBLU = [
	"BLUFOR_radio1Flag = false; publicVariable 'BLUFOR_radio1Flag'; BLUFOR_obj1Flag = false; publicVariable 'BLUFOR_obj1Flag';",
	"BLUFOR_radio2Flag = true; publicVariable 'BLUFOR_radio2Flag'; BLUFOR_obj2Flag = true; publicVariable 'BLUFOR_obj2Flag';",
	"BLUFOR_radio3Flag = true; publicVariable 'BLUFOR_radio3Flag'; BLUFOR_obj3Flag = true; publicVariable 'BLUFOR_obj3Flag';",
	"BLUFOR_radio4Flag = true; publicVariable 'BLUFOR_radio4Flag'; BLUFOR_obj4Flag = true; publicVariable 'BLUFOR_obj4Flag';",
	"BLUFOR_radio5Flag = true; publicVariable 'BLUFOR_radio5Flag'; BLUFOR_obj5Flag = true; publicVariable 'BLUFOR_obj5Flag';"
];

VAR_RADIO_RADIOINTERACTSBLU = [
	[
		"Report OBJ1 Secure",
		{false}
	],
	[
		"Report OBJ2 Secure",
		{false}
	],
	[
		"Report OBJ3 Secure",
		{false}
	],
	[
		"Report OBJ4 Secure",
		{false}
	],
	[
		"Report OBJ5 Secure",
		{false}
	]
];