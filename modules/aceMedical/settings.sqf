//This module is a slightly modified BIS_ambientAnim module, for multiplayer purposes.

	ACE_medical_medicSetting_SurgicalKit = 1;	//2: Doctor, 1: Medic, 0: Normal
	ACE_medical_medicSetting_PAK = 2;			//See FNC_assignMedic

	ACE_medical_useLocation_SurgicalKit = 0;	//0: Field, 1: Medical Vehicle, 2: Medical Facility, 3: Vehicle OR Facility
	ACE_medical_useLocation_PAK = 0;

	ACE_medical_useCondition_SurgicalKit = 1;	//0: Anytime, 1: Stable Only
	ACE_medical_useCondition_PAK = 1;

	ACE_medical_consumeItem_SurgicalKit = 0;	//0 Keep, 1 Consume
	ACE_medical_consumeItem_PAK = 0;

	ACE_medical_amountOfReviveLives = 1;		//Number of revives

	ACE_medical_enableFor = 0;					//0: No AI, 1: AI

	ACE_medical_maxReviveTime = 600;			//Time until death when unconscious

	ACE_medical_preventInstaDeath = true;		//Prevents instant death, will send you to revive mode always

	ACE_medical_allowDeadBodyMovement = false;
	ACE_medical_increaseTrainingInLocations = true;