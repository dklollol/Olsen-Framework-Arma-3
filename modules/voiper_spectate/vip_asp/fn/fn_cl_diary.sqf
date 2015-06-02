_colourText = str (["IGUI_WARNING"] call vip_cmn_fnc_cl_profileColoursHTML);

call vip_cmn_fnc_cl_authorDiaryTopic;

player createDiaryRecord ["vip_modules_var_cl_diary", ["ASP", format["
<font color=%1 size='18'>Adapted Spectator Platform</font>
<br /><br />
This mission uses voiper's Adapted Spectator Platform (ASP) module, derived from Arma 3's Splendid Cam.
", _colourText]]];