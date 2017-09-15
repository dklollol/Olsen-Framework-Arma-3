
/*



SetArtillerySkill:
Example: [arty1,1,0,300,4,3] call FNC_SetArtillerySkill;
[unit,fireRate,accuracy,spottingAccuracy,aimtime,calculationtime]  call FNC_SetArtillerySkill;
Params:
unit -Object- unit of which the skills should change;
fireRate - float(1,) - fireRate modifiers for bursts. Weapon reloadtime * fireRate for waititme between bursts, min 1;
accuracy - integer - accuracy of shots in meters;
spottingAccuracy - integer - accuracy of spotting rounds in meters;
aimtime - integer - time between recaluclations in seconds;
calculationtime - integer - time to calculate a firing solution before firing spotting rounds;

SetObserverSkill:
Example: [obs1,0,0] call FNC_SetObserverSkill;
[unit,accuracy,speed] call FNC_SetObserverSkill;
Params:
unit -Object- unit of which the skills should change;
accuracy - integer - accuracy of position estimation in meters
speed - integer - time to estimate position of target

PointFiremission:
Example: [arty1,getPos gameLogic1,200,10,5,10,100,0]   call FNC_PointFireMission;
[unit,position,dispersion,burstCount,roundsPerBurst,burstWaitTime,minSpottedDistance,roundtype]   call FNC_PointFireMission;
Params:
unit - Object- artillery vehicle;
position -Vector- center of firemission
dispersion -integer - dispersion per burst in meter
burstCount -integer - number of bursts
roundsPerBurst - integer - number of rounds per burst
burstWaitTime -integer - downtime between bursts
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype -integer- ammunition used (getArtilleryAmmo [_unit] select _roundType)

LineFiremission:

Example: [arty2,getPos gameLogic2,getPos gameLogic3,10,2,10,100,0]   call FNC_LineFireMission;
[unit,startPoint,endPoint,segments,roundsPerSegment,waitTimePerSegment,minSpottedDistance,roundtype]   call FNC_LineFireMission;
Params:
unit - Object- artillery vehicle;
startPoint - Vector - start of line
endPoint - Vector - end of line
segments -integer - number of bursts
roundsPerSegment - integer - number of rounds per segment
waitTimePerSegment -integer - downtime between segments
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype -integer- ammunition used (getArtilleryAmmo [_unit] select _roundType)

BracketFiremission:
Example:[arty2,getPos gameLogic2,getPos gameLogic3,10,2,10,100,0]  call FNC_BracketFireMission;
[unit,startPoint,endPoint,segments,roundsPerSegment,waitTimePerSegment,minSpottedDistance,roundtype]   call FNC_BracketFireMission;
Params:
unit - Object- artillery vehicle;
startPoint - Vector - start of line
endPoint - Vector - end of line
segments -integer - number of bursts
roundsPerSegment - integer - number of rounds per segment
waitTimePerSegment -integer - downtime between segments
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype -integer- ammunition used (getArtilleryAmmo [_unit] select _roundType)

Notes: Artillery will fire alternating between end and start towards the center

DonutFiremission
Example: [arty4,getPos gameLogic6,200,400,10,5,20,100,0]   call FNC_DonutFireMission;
[unit,position,innerRadius,outRadius,burstCount,roundsPerBurst,burstWaitTime,minSpottedDistance,roundtype]   call FNC_DonutFireMission;
Params:
unit - Object- artillery vehicle;
position -Vector- center of firemission
innerRadius -integer - inner range of donut
outRadius -integer - outer range of donut
burstCount -integer - number of bursts
roundsPerBurst - integer - number of rounds per burst
burstWaitTime -integer - downtime between bursts
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype -integer- ammunition used (getArtilleryAmmo [_unit] select _roundType)

MarkerFiremission
Example: [arty5,"artytarget1",10,5,20,100,0]   call FNC_MarkerFireMission;
[unit,marker,burstCount,roundsPerBurst,burstWaitTime,minSpottedDistance,roundtype]   call FNC_PointFireMission;
Params:
unit - Object- artillery vehicle;
marker - String - markername of where artillery should hit
burstCount -integer - number of bursts
roundsPerBurst - integer - number of rounds per burst
burstWaitTime -integer - downtime between bursts
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype -integer- ammunition used (getArtilleryAmmo [_unit] select _roundType)

CurtainFiremission:
Example: [[arty6,arty7,arty8,arty9,arty10],getPos gameLogic7,getPos gameLogic8,200,10,5,20,100,0]   call FNC_CurtainFireMission;
[units,,startPoint,endPoint,width,segments,roundsPerSegment,waitTimePerSegment,minSpottedDistance,roundtype]   call FNC_CurtainFireMission;
Params:
unit -Array Object- artillery vehicles for mission;
startPoint - Vector - start of line
endPoint - Vector - end of line
width - integer - width of curtain
segments -integer - number of bursts
roundsPerSegment - integer - number of rounds per segment
waitTimePerSegment -integer - downtime between segments
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype -integer- ammunition used (getArtilleryAmmo [_unit] select _roundType)

RegisterObserver:
Example:  [obs1,[arty11,arty12,arty13,arty14],1,300,1000,10,5,10,300,0] call FNC_RegisterForwardObserver;
[observer,batteries,knowledgerequired,minRange,viewRange,burstCount,roundsPerBurst,burstwaittime,minSpottedDistance,dispersion] call FNC_RegisterForwardObserver;
observer - obj - unit which observers;
batteries - Array Obj- artillery guns observer has access to;
knowledgerequired - integer (0,4) - https://community.bistudio.com/wiki/knowsAbout
minRange -integer- minimum range between firemission to stop massive 10 batteries shooting 1 guy (300 is good)
viewRange -integer- max range the unit can know
burstCount -integer - number of bursts
roundsPerBurst - integer - number of rounds per burst
burstWaitTime -integer - downtime between bursts
minSpottedDistance - integer - range in m of how close spotting need to be to be accepted
roundtype - integer - ammunition used (getArtilleryAmmo [_unit] select _roundType)



Example:
[arty1,1,0,300,4,3] call FNC_SetArtillerySkill;
[arty2,1,0,300,4,3] call FNC_SetArtillerySkill;
[arty3,1,0,300,4,3] call FNC_SetArtillerySkill;
[arty4,1,0,300,4,3] call FNC_SetArtillerySkill;
[arty5,1,0,300,4,3] call FNC_SetArtillerySkill;
[arty6,1,0,300,4,3] call FNC_SetArtillerySkill;
[arty7,1,0,300,4,3] call FNC_SetArtillerySkill;
[arty8,1,0,300,4,3] call FNC_SetArtillerySkill;
[arty9,1,0,300,4,3] call FNC_SetArtillerySkill;
[arty10,1,0,300,4,3] call FNC_SetArtillerySkill;
[arty11,1,0,300,4,3] call FNC_SetArtillerySkill;
[arty12,1,0,300,4,3] call FNC_SetArtillerySkill;
[arty13,1,0,300,4,3] call FNC_SetArtillerySkill;
[arty14,1,0,300,4,3] call FNC_SetArtillerySkill;
[obs1,0,0] call FNC_SetObserverSkill;

[arty1,getPos gameLogic1,200,10,5,10,100,0]   call FNC_PointFireMission;
[arty2,getPos gameLogic2,getPos gameLogic3,10,2,10,100,0]   call FNC_LineFireMission;
[arty3,getPos gameLogic4,getPos gameLogic5,10,5,20,100,0]   call FNC_BracketFireMission;
[arty4,getPos gameLogic6,200,400,10,5,20,100,0]   call FNC_DonutFireMission;
[arty5,"artytarget1",10,5,20,100,0]   call FNC_MarkerFireMission;
[[arty6,arty7,arty8,arty9,arty10],getPos gameLogic7,getPos gameLogic8,200,10,5,20,100,0]   call FNC_CurtainFireMission;

[obs1,[arty11,arty12,arty13,arty14],1,300,1000,10,5,10,300,0] call FNC_RegisterForwardObserver;
*/
