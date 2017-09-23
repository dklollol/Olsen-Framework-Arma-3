/*

Make Player Observer
Example: [test1,[m109]] call FNC_ArtMakePlayerObserver;
[unit,guns] call FNC_ArtMakePlayerObserver;
Params:
unit - obj - unit which should become fo;
guns - Array Object - aviable guns to the fo

Notes:

SetArtilleryData:
Example: [arty1,1,0,300,4,3,"",true] call FNC_SetArtilleryData;
[unit,fireRate,accuracy,spottingAccuracy,aimtime,calculationtime,unlimitedAmmo]  call FNC_SetArtilleryData;
Params:
unit -Object- unit of which the skills should change;
fireRate - float(1,) - fireRate modifiers for bursts. Weapon reloadtime * fireRate for waititme between bursts, min 1
accuracy - integer - accuracy of shots in meters
spottingAccuracy - integer - accuracy of spotting rounds in meters
aimtime - integer - time between recaluclations in seconds
calculationtime - integer - time to calculate a firing solution before firing spotting rounds
customName - String - name for the player Observer in his gui
unlimitedAmmo - bool - true for unlimitedAmmo
Notes: put -1 for default

SetObserverSkill:
Example: [obs1,0,0] call FNC_SetObserverSkill;
[unit,accuracy,speed] call FNC_SetObserverSkill;
Params:
unit -Object- unit of which the skills should change
accuracy - integer - accuracy of position estimation in meters
speed - integer - time to estimate position of target

PointFiremission:
Example: [arty1,getPos gameLogic1,200,10,5,10,100,0]   call FNC_PointFiremission;
[unit,position,dispersion,burstCount,roundsPerBurst,burstWaitTime,minSpottedDistance,roundtype]   call FNC_PointFiremission;
Params:
unit - Object- artillery vehicle;
position -Vector- center of firemission
dispersion -integer - dispersion of the fire mission
burstCount -integer - number of bursts
roundsPerBurst - integer - number of rounds per burst
burstWaitTime -integer - downtime between bursts
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype -integer- ammunition used ((magazinesAmmo _actualGunUnit) select _roundType)

LineFiremission:

Example: [arty2,getPos gameLogic2,getPos gameLogic3,10,2,10,100,0]   call FNC_LineFiremission;
[unit,startPoint,endPoint,segments,roundsPerSegment,waitTimePerSegment,minSpottedDistance,roundtype]   call FNC_LineFiremission;
Params:
unit - Object- artillery vehicle;
startPoint - Vector - start of line
endPoint - Vector - end of line
segments -integer - number of bursts
roundsPerSegment - integer - number of rounds per segment
waitTimePerSegment -integer - downtime between segments
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype -integer- ammunition used ((magazinesAmmo _actualGunUnit) select _roundType)

BracketFiremission:
Example:[arty2,getPos gameLogic2,getPos gameLogic3,10,2,10,100,0]  call FNC_BracketFiremission;
[unit,startPoint,endPoint,segments,roundsPerSegment,waitTimePerSegment,minSpottedDistance,roundtype]   call FNC_BracketFiremission;
Params:
unit - Object- artillery vehicle;
startPoint - Vector - start of line
endPoint - Vector - end of line
segments -integer - number of bursts
roundsPerSegment - integer - number of rounds per segment
waitTimePerSegment -integer - downtime between segments
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype -integer- ammunition used ((magazinesAmmo _actualGunUnit) select _roundType)

Notes: Artillery will fire alternating between end and start towards the center

DonutFiremission
Example: [arty4,getPos gameLogic6,200,400,10,5,20,100,0]   call FNC_DonutFiremission;
[unit,position,innerRadius,outRadius,burstCount,roundsPerBurst,burstWaitTime,minSpottedDistance,roundtype]   call FNC_DonutFiremission;
Params:
unit - Object- artillery vehicle;
position -Vector- center of firemission
innerRadius -integer - inner range of donut
outRadius -integer - outer range of donut
burstCount -integer - number of bursts
roundsPerBurst - integer - number of rounds per burst
burstWaitTime -integer - downtime between bursts
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype -integer- ammunition used ((magazinesAmmo _actualGunUnit) select _roundType)

MarkerFiremission
Example: [arty5,"artytarget1",10,5,20,100,0]   call FNC_MarkerFiremission;
[unit,marker,burstCount,roundsPerBurst,burstWaitTime,minSpottedDistance,roundtype]   call FNC_PointFiremission;
Params:
unit - Object- artillery vehicle;
marker - String - markername in which artillery should hit (rectangle or circle)
burstCount -integer - number of bursts
roundsPerBurst - integer - number of rounds per burst
burstWaitTime -integer - downtime between bursts
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype -integer- ammunition used ((magazinesAmmo _actualGunUnit) select _roundType)

PointmarkerFiremission
Example: [arty5,"artytarget1",10,5,20,100,0]   call FNC_PointMarkerFiremission;
[unit,marker,burstCount,roundsPerBurst,burstWaitTime,minSpottedDistance,roundtype]   call FNC_PointFiremission;
Params:
unit - Object- artillery vehicle;
marker - String - markername of where artillery should hit
burstCount -integer - number of bursts
roundsPerBurst - integer - number of rounds per burst
burstWaitTime -integer - downtime between bursts
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype -integer- ammunition used ((magazinesAmmo _actualGunUnit) select _roundType)



DynamicMarkerFiremission
Example: [arty5,"artytarget1",10,5,20,100,0]   call FNC_DynamicMarkerFiremission;
[unit,marker,dispersion,burstCount,roundsPerBurst,burstWaitTime,minSpottedDistance,roundtype]   call FNC_DynamicMarkerFiremission;
Params:
unit - Object- artillery vehicle;
marker - String - ingame text of the marker of where to hit and not the variable name
dispersion -integer - dispersion of the fire mission
burstCount -integer - number of bursts
roundsPerBurst - integer - number of rounds per burst
burstWaitTime -integer - downtime between bursts
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype -integer- ammunition used ((magazinesAmmo _actualGunUnit) select _roundType)

CurtainFiremission:
Example: [[arty6,arty7,arty8,arty9,arty10],getPos gameLogic7,getPos gameLogic8,200,10,5,20,100,0]   call FNC_CurtainFiremission;
[units,,startPoint,endPoint,width,segments,roundsPerSegment,waitTimePerSegment,minSpottedDistance,roundtype]   call FNC_CurtainFiremission;
Params:
unit -Array Object- artillery vehicles for mission;
startPoint - Vector - start of line
endPoint - Vector - end of line
width - integer - width of curtain
segments -integer - number of bursts
roundsPerSegment - integer - number of rounds per segment
waitTimePerSegment -integer - downtime between segments
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype -integer- ammunition used ((magazinesAmmo _actualGunUnit) select _roundType)

RegisterObserver:
[obs1,[arty11,arty12,arty13,arty14],1,300,1000,10,5,10,300,150,0] call FNC_RegisterForwardObserver;
[observer,batteries,knowledgerequired,minRange,viewRange,burstCount,roundsPerBurst,burstwaittime,minSpottedDistance,dispersion,roundType] call FNC_RegisterForwardObserver;
observer - obj - unit which observers;
batteries - Array Obj- artillery guns observer has access to;
knowledgerequired - integer (0,4) - https://community.bistudio.com/wiki/knowsAbout
minRange -integer- minimum range between firemission to stop massive 10 batteries shooting 1 guy (300 is good)
viewRange -integer- max range the unit can know
burstCount -integer - number of bursts
roundsPerBurst - integer - number of rounds per burst
burstWaitTime -integer - downtime between bursts
dispersion - integer - dispersion in meters
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundTpe - integer - ammunition used ((magazinesAmmo _actualGunUnit) select _roundType)


Example:
[arty1,1,0,300,4,3,"TestArty1",true] call FNC_SetArtilleryData;
[arty1,getPos gameLogic1,200,999,5,10,100,0]   call FNC_PointFiremission;
[arty2,1,0,300,4,3,"M109 Test",true] call FNC_SetArtilleryData;
[arty2,getPos gameLogic2,200,999,5,10,100,0]   call FNC_PointFiremission;


private _art = [arty3,arty4,arty5,arty6,arty7,arty8,arty9,arty10];
{
    [_x,1,0,300,4,3,"M109" + str (floor random 1000 ),false] call FNC_SetArtilleryData;
}forEach _art;
[test1,_art] call FNC_ArtMakePlayerObserver;
[test2,_art] call FNC_ArtMakePlayerObserver;
[test3,_art] call FNC_ArtMakePlayerObserver;
[test4,_art] call FNC_ArtMakePlayerObserver;
*/
