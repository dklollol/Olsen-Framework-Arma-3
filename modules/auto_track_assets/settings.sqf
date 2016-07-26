//This module automatically uses [asset, name, team] call FNC_TrackAsset; on all vehicles which are manned on spawn
//and tracks them based their crews sides. It only tracks the sides west, east and resistance and names them after their config names.

//To manually track an asset use [asset, name, team] call FNC_TrackAsset; in its init field, the team has to correspond with the teams declared in customization\settings.sqf.

//Example:
//[this, "UNICEF Hemmit", "USMC"] call FNC_TrackAsset;
//[this, "Entrenched DShK", "VDV"] call FNC_TrackAsset;

//To manually track all units inside a marker use [marker, team] call FNC_TrackAssetArea; the team has to correspond with the teams declared in customization\settings.sqf.

//Example:
//["SpawnUSMC", "USMC"] call FNC_TrackAssetArea;
//["SpawnVDV", "VDV"] call FNC_TrackAssetArea;