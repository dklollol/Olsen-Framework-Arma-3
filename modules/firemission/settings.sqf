





/*
	Quick-Reference:

	FNC_GetAmmoDisplayNameAndIndex; Get ammo of unit as string
	FNC_ArtMakePlayerObserver; make player an observer
	FNC_SetArtilleryData; set artillery Data
	FNC_PointFiremission; pointfiremission
	FNC_RegisterForwardObserver; make ai an observer
	FNC_SetObserverSkill; set skill of observer
*/

/*

	How firemissions work: (description of capitalised words are found in FNC description)
	A firemission script will be called. The Artillery gun will wait AIMTIME before firing spotting rounds. It will wait till splash to fire a new round.
	It will fire spotting rounds aslong as the distance from impact to actual target is above MINSPOTTEDDISTANCE. For no spotting rounds use a number greater than 1000.
	After it finished its spotting rounds it will wait CALCULATIONTIME to fire the actuall firemission.
	Example point firemission. It will find a spot within DISPERSION from the TARGETPOS and fire ROUNDSPERBURST at that spot. It will do this BURSTCOUNT times.
	It will wait BURSTWAITIME or FIRERATE * ROUNDSPERBURST depending on what is greater before the next burst is fired. BURSTWAITIME is the time from first shot of a burst to next burst.
*/

/*
 * FNC_GetAmmoDisplayNameAndIndex
 *
 * Returns an array of [index,className,displayName] for each ammunition defined in the artillery config.
 *
 * Arguments:
 * 0: unit <object>
 *
 * Return Value:
 * array
 *
 * Example:
 * unit call FNC_GetAmmoDisplayNameAndIndex;
 */

 /*
  * FNC_ArtMakePlayerObserver
  *
  * Makes a player an artillery observer
  *
  * Arguments:
  * 0: unit <object>
  * 1: guns Array<object> artillery vehicles the player should have access to
  *
  * Return Value:
  * none
  *
  * Example:
  * [fo,[m109]] call FNC_ArtMakePlayerObserver;
  *
  * Note:
  * for JIP compatibility use [this,guns] call FNC_ArtMakePlayerObserver; in the unit Init
  * Right now you cannot change the artilleries a unit has because of certain ace issues but you can disable the gun with [gun,isAviable] call FNC_SetArtyAviable; isAviable = false if you want it not be used
  */


  /*
   * FNC_SetArtilleryData
   *
   * Sets variables on the artillery gun which are used in firemissions
   *
   * Arguments:
   * 0: unit <object>
   * 1: fireRate		 <float>(1, 999)	firerate modifier. gunFireRate * modifier;
   * 2: accuracy		 <float>			accuracy in meters
   * 3: spottingAccuracy <object>		   spotting round accuracy in meters
   * 4: aimtime		  <float>			time needed before spotting rounds will be fired in seconds
   * 5: calculationtime  <float>			time needed to calculate and prep after spotting round and before actual firemission in seconds
   * 6: customName	   <string>		   custom name for the artillery gun used in the player FO dialog
   * 7: unlimitedAmmo	<bool>			 true for unlimited ammo in gun
   *
   * put -1 for default
   *
   * Return Value:
   * none
   *
   * Example:
   * [arty1,1,0,300,4,3,"Arty at Airfield",true] call FNC_SetArtilleryData;
   */

   /*
	* FNC_SetObserverSkill
	*
	* Sets variables on an AI Observer used in the observer function
	*
	* Arguments:
	* 0: unit <object>
	* 1: accuracy <float> accuracy of location estimation of target in meters
	* 2: speed <float> time needed to call in a firemission
	*
	* Return Value:
	* none
	*
	* Example:
	* [obs1,0,0] call FNC_SetObserverSkill;
	*/

	/*
	 * FNC_RegisterForwardObserver
	 *
	 * Makes an AI unit an FO who can call in artillery
	 *
	 * Arguments:
	 * 0: unit <object>
	 * 1: guns Array<object> aviable guns for the observer
	 * 2: knowledgerequired <int>(0,4) https://community.bistudio.com/wiki/knowsAbout
	 * 3: minRange <float> minimum range between firemission to stop massive 10 batteries shooting 1 guy (300 is good)
	 * 4: viewRange <int> max range the unit can see
	 * 5: dispersion <int> dispersion in meters
	 * 6: burstCount <int> number of bursts to fire
	 * 7: roundsPerBurst <int> number of rounds per burst
	 * 8: burstWaitTime <int> downtime between bursts
	 * 9: minSpottedDistance <int> range in m of how close a spotting round needs to be to be accepted
	 * 10: roundIndex <int> ammunition index from FNC_GetAmmoDisplayNameAndIndex
	 *
	 * Return Value:
	 * none
	 *
	 * Example:
	 *  [obs1,[arty11,arty12,arty13,arty14],1,300,1000,10,5,10,300,150,0] call FNC_RegisterForwardObserver;
	 */

	 /*
	  * FNC_PolarFiremission
	  *
	  * Calls in a polar firemission
	  *
	  * Arguments:
	  * 0: unit <object> artillery gun
	  * 1: position <string> grid of the caller
	  * 2: mils <float> mils from caller
	  * 3: distance <float> distance from caller in meters
	  * 4: dispersion <float> dispersion in meters
	  * 5: burstCount <int> number of bursts to fire
	  * 6: roundsPerBurst <int> number of rounds per burst
	  * 7: burstWaitTime <int> downtime between bursts
	  * 9: minSpottedDistance <int> range in m of how close a spotting round needs to be to be accepted
	  * 10: roundIndex <int> ammunition index from FNC_GetAmmoDisplayNameAndIndex

	  *
	  * Return Value:
	  * none
	  *
	  * Example:
	  *  [arty1,"132035",3230,500,200,10,5,10,100,0]   call FNC_PolarFiremission;
	  */

	  /*
	   * FNC_PointFiremission
	   *
	   * Calls in a point firemission
	   *
	   * Arguments:
	   * 0: unit <object> artillery gun
	   * 1: position <vector> position of target
	   * 2: dispersion <float> dispersion in meters
	   * 3: burstCount <int> number of bursts to fire
	   * 4: roundsPerBurst <int> number of rounds per burst
	   * 5: burstWaitTime <int> downtime between bursts
	   * 6: minSpottedDistance <int> range in m of how close a spotting round needs to be to be accepted
	   * 7: roundIndex <int> ammunition index from FNC_GetAmmoDisplayNameAndIndex

	   *
	   * Return Value:
	   * none
	   *
	   * Example:
	   *  [arty1,getPos gameLogic1,200,10,5,10,100,0]   call FNC_PointFiremission;
	   */

	   /*
		* FNC_LineFiremission
		*
		* Calls in a firemission which moves from startPoint to endPoint. Line between SP and EP will be cut into burstCount pieces and a burst will be fired at every piece
		*
		* Arguments:
		* 0: unit <object> artillery gun
		* 1: startPoint <vector> position of startPoint
		* 2: endPoint <vector> position of endPoint
		* 3: dispersion <float> dispersion in meters
		* 4: burstCount <int> number of bursts to fire
		* 5: roundsPerBurst <int> number of rounds per burst
		* 6: burstWaitTime <int> downtime between bursts
		* 7: minSpottedDistance <int> range in m of how close a spotting round needs to be to be accepted
		* 8: roundIndex <int> ammunition index from FNC_GetAmmoDisplayNameAndIndex

		*
		* Return Value:
		* none
		*
		* Example:
		*  [arty2,getPos gameLogic2,getPos gameLogic3,10,2,10,100,0]   call FNC_LineFiremission;
		*/

		/*
		 * FNC_BracketFiremission
		 *
		 * Calls in a firemission which moves from startPoint half way to endPoint and from endPoint halfway to startPoint. Line between SP and EP will be cut into burstCount pieces and a burst will be fired at every piece.
		 *
		 * Arguments:
		 * 0: unit <object> artillery gun
		 * 1: startPoint <vector> position of startPoint
		 * 2: endPoint <vector> position of endPoint
		 * 3: dispersion <float> dispersion in meters
		 * 4: burstCount <int> number of bursts to fire
		 * 5: roundsPerBurst <int> number of rounds per burst
		 * 6: burstWaitTime <int> downtime between bursts
		 * 7: minSpottedDistance <int> range in m of how close a spotting round needs to be to be accepted
		 * 8: roundIndex <int> ammunition index from FNC_GetAmmoDisplayNameAndIndex

		 *
		 * Return Value:
		 * none
		 *
		 * Example:
		 *  [arty2,getPos gameLogic2,getPos gameLogic3,10,2,10,100,0]  call FNC_BracketFiremission;
		 */

		 /*
		  * FNC_DonutFiremission
		  *
		  * Calls in a firemission where artillery will shoot between innerRadius and outerRadius from the target
		  *
		  * Arguments:
		  * 0: unit <object> artillery gun
		  * 1: position <vector> position of target
		  * 2: innerRadius <integer> inner radius of donut in meters
		  * 3: outerRadius <integer> outer radius of donut in meters
		  * 4: burstCount <int> number of bursts to fire
		  * 5: roundsPerBurst <int> number of rounds per burst
		  * 6: burstWaitTime <int> downtime between bursts
		  * 7: minSpottedDistance <int> range in m of how close a spotting round needs to be to be accepted
		  * 8: roundIndex <int> ammunition index from FNC_GetAmmoDisplayNameAndIndex

		  *
		  * Return Value:
		  * none
		  *
		  * Example:
		  *  [arty4,getPos gameLogic6,200,400,10,5,20,100,0]   call FNC_DonutFiremission;
		  */

		  /*
		   * FNC_MarkerFiremission
		   *
		   * Calls in a firemission where artillery will shoot in the rectangle or circle marker
		   *
		   * Arguments:
		   * 0: unit <object> artillery gun
		   * 1: marker <string> markername in which artillery should hit (rectangle or circle)
		   * 2: burstCount <int> number of bursts to fire
		   * 3: roundsPerBurst <int> number of rounds per burst
		   * 4: burstWaitTime <int> downtime between bursts
		   * 5: minSpottedDistance <int> range in m of how close a spotting round needs to be to be accepted
		   * 6: roundIndex <int> ammunition index from FNC_GetAmmoDisplayNameAndIndex

		   *
		   * Return Value:
		   * none
		   *
		   * Example:
		   * [arty5,"artytarget1",10,5,20,100,0]   call FNC_MarkerFiremission;
		   */

		   /*
			* FNC_PointMarkerFiremission
			*
			* Calls a point firemission on a given markername
			*
			* Arguments:
			* 0: unit <object> artillery gun
			* 1: marker <string> markername in which artillery should hit
			* 2: dispersion <float> dispersion in meters
			* 3: burstCount <int> number of bursts to fire
			* 4: roundsPerBurst <int> number of rounds per burst
			* 5: burstWaitTime <int> downtime between bursts
			* 6: minSpottedDistance <int> range in m of how close a spotting round needs to be to be accepted
			* 7: roundIndex <int> ammunition index from FNC_GetAmmoDisplayNameAndIndex

			*
			* Return Value:
			* none
			*
			* Example:
			* [arty5,"artytarget1",300,10,5,20,100,0]   call FNC_PointMarkerFiremission;
			*/

			/*
			 * FNC_DynamicMarkerFiremission
			 *
			 * Calls a point firemission on a marker with a given text
			 *
			 * Arguments:
			 * 0: unit <object> artillery gun
			 * 1: marker <string> marker ingame text. Must be unique or there might be issues.
			 * 2: dispersion <float> dispersion in meters
			 * 3: burstCount <int> number of bursts to fire
			 * 4: roundsPerBurst <int> number of rounds per burst
			 * 5: burstWaitTime <int> downtime between bursts
			 * 6: minSpottedDistance <int> range in m of how close a spotting round needs to be to be accepted
			 * 7: roundIndex <int> ammunition index from FNC_GetAmmoDisplayNameAndIndex

			 *
			 * Return Value:
			 * none
			 *
			 * Example:
			 * [arty5,"artytarget1",300,10,5,20,100,0]   call FNC_DynamicMarkerFiremission;
			 */

			 /*
			  * FNC_CurtainFiremission
			  *
			  * Calls in multiple synchronized line firemission from START to ENDPOINT with WIDTH left right dispersion
			  *
			  * Arguments:
			  * 0: unit Array<object> artillery guns
			  * 1: startPoint <vector> position of startPoint
			  * 2: endPoint <vector> position of endPoint
			  * 3: width  <integer>  width of curtain
			  * 4: burstCount <int> number of bursts to fire
			  * 5: roundsPerBurst <int> number of rounds per burst
			  * 6: burstWaitTime <int> downtime between bursts
			  * 7: minSpottedDistance <int> range in m of how close a spotting round needs to be to be accepted
			  * 8: roundIndex <int> ammunition index from FNC_GetAmmoDisplayNameAndIndex

			  *
			  * Return Value:
			  * none
			  *
			  * Example:
			  * [[arty6,arty7,arty8,arty9,arty10],getPos gameLogic7,getPos gameLogic8,200,10,5,20,100,0]   call FNC_CurtainFiremission;
			  */
