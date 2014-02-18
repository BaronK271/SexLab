scriptname sslSystemConfig extends Quest


bool property SOSEnabled auto hidden
bool property bDisablePlayer auto hidden
float property fMaleVoiceDelay auto hidden
float property fFemaleVoiceDelay auto hidden
float property fVoiceVolume auto hidden
bool property bEnableTCL auto hidden
bool property bScaleActors auto hidden
bool property bUseCum auto hidden
bool property bAllowFFCum auto hidden
float property fCumTimer auto hidden
bool property bUseStrapons auto hidden
bool property bReDressVictim auto hidden
bool property bRagdollEnd auto hidden
bool property bUseMaleNudeSuit auto hidden
bool property bUseFemaleNudeSuit auto hidden
bool property bUndressAnimation auto hidden

bool[] property bStripMale auto hidden
bool[] property bStripFemale auto hidden
bool[] property bStripLeadInFemale auto hidden
bool[] property bStripLeadInMale auto hidden
bool[] property bStripVictim auto hidden
bool[] property bStripAggressor auto hidden

bool property bRestrictAggressive auto hidden
bool property bAllowCreatures auto hidden

string property sPlayerVoice auto hidden
bool property bNPCSaveVoice auto hidden

int property kBackwards auto hidden ; Right Shift
int property kAdjustStage auto hidden; Right Ctrl
int property kAdvanceAnimation auto hidden ; Space
int property kChangeAnimation auto hidden ; O
int property kChangePositions auto hidden ; =
int property kAdjustChange auto hidden ; K
int property kAdjustForward auto hidden ; L
int property kAdjustSideways auto hidden ; '
int property kAdjustUpward auto hidden ; ;
int property kRealignActors auto hidden ; [
int property kMoveScene auto hidden ; ]
int property kRestoreOffsets auto hidden ; -
int property kRotateScene auto hidden ; U
int property kToggleFreeCamera auto hidden ; NUM 3

bool property bAutoTFC auto hidden
float property fAutoSUCSM auto hidden

float property fSFXDelay auto hidden
float property fSFXVolume auto hidden
bool property bAutoAdvance auto hidden
bool property bForeplayStage auto hidden
bool property bOrgasmEffects auto hidden
string property sNPCBed auto hidden
float[] property fStageTimer auto hidden
float[] property fStageTimerLeadIn auto hidden
float[] property fStageTimerAggr auto hidden

bool function BackwardsPressed()
	return (Input.IsKeyPressed(kBackwards) || ((kBackwards == 42 || kBackwards == 54) && (Input.IsKeyPressed(42) || Input.IsKeyPressed(54))))
endFunction
bool function AdjustStagePressed()
	return (Input.IsKeyPressed(kAdjustStage) || ((kAdjustStage == 157 || kAdjustStage == 29) && (Input.IsKeyPressed(157) || Input.IsKeyPressed(29))))
endFunction

function HotkeyCallback(sslThreadController Thread, int keyCode)
	; Advance Stage
	if keyCode == kAdvanceAnimation
		Thread.AdvanceStage(BackwardsPressed())

	; Change Animation
	elseIf keyCode == kChangeAnimation
		Thread.ChangeAnimation(BackwardsPressed())

	; Forward / Backward adjustments
	elseIf keyCode == kAdjustForward
		Thread.AdjustForward(BackwardsPressed(), AdjustStagePressed())

	; Up / Down adjustments
	elseIf keyCode == kAdjustUpward
		Thread.AdjustUpward(BackwardsPressed(), AdjustStagePressed())

	; Left / Right adjustments
	elseIf keyCode == kAdjustSideways
		Thread.AdjustSideways(BackwardsPressed(), AdjustStagePressed())

	; Rotate Scene
	elseIf keyCode == kRotateScene
		Thread.RotateScene(BackwardsPressed())
	; Change Adjusted Actor

	elseIf keyCode == kAdjustChange
		Thread.AdjustChange(BackwardsPressed())

	; RePosition Actors
	elseIf keyCode == kRealignActors
		Thread.RealignActors()

	; Change Positions
	elseIf keyCode == kChangePositions
		Thread.ChangePositions(BackwardsPressed())

	; Restore animation offsets
	elseIf keyCode == kRestoreOffsets
		Thread.RestoreOffsets()

	; Move Scene
	elseIf keyCode == kMoveScene
		Thread.MoveScene()
	endIf
endFunction


float function GetVoiceDelay(bool IsFemale = false, int stage = 1)
	float VoiceDelay
	if IsFemale
		VoiceDelay = fFemaleVoiceDelay
	else
		VoiceDelay = fMaleVoiceDelay
	endIf
	if stage > 1
		return (VoiceDelay - (stage * 0.8)) + Utility.RandomFloat(-0.3, 0.3)
	endIf
	return VoiceDelay
endFunction

bool[] function GetStrip(bool IsFemale, bool IsLeadIn = false, bool IsAggressive = false, bool IsVictim = false)
	if IsLeadIn
		if IsFemale
			return bStripLeadInFemale
		else
			return bStripLeadInMale
		endIf
 	elseif IsAggressive
 		if IsVictim
 			return bStripVictim
 		else
 			return bStripAggressor
 		endIf
 	elseIf IsFemale
 		return bStripFemale
 	else
 		return bStripMale
 	endIf
endFunction

bool function UsesNudeSuit(bool IsFemale)
	return ((!IsFemale && bUseMaleNudeSuit) || (IsFemale && bUseFemaleNudeSuit))
endFunction


function _Defaults()

	sPlayerVoice = "$SSL_Random"
	bNPCSaveVoice = true

	; Config Hotkeys
	kBackwards = 54 ; Right Shift
	kAdjustStage = 157; Right Ctrl
	kAdvanceAnimation = 57 ; Space
	kChangeAnimation =  24 ; O
	kChangePositions = 13 ; =
	kAdjustChange = 37 ; K
	kAdjustForward = 38 ; L
	kAdjustSideways = 40 ; '
	kAdjustUpward = 39 ; ;
	kRealignActors = 26 ; [
	kMoveScene = 27 ; ]
	kRestoreOffsets = 12 ; -
	kRotateScene = 22 ; U
	kToggleFreeCamera = 81 ; NUM 3
	; MCM TFC settings
	bAutoTFC = false
	fAutoSUCSM = 5.0

	bRestrictAggressive = true
	bAllowCreatures = false

	; Config
	bDisablePlayer = false
	fMaleVoiceDelay = 7.0
	fFemaleVoiceDelay = 6.0
	fVoiceVolume = 0.7
	bEnableTCL = false
	bScaleActors = false
	bUseCum = true
	bAllowFFCum = false
	fCumTimer = 120.0
	bUseStrapons = true
	bReDressVictim = true
	bRagdollEnd = false
	bUseMaleNudeSuit = false
	bUseFemaleNudeSuit = false
	bUndressAnimation = false

	; Strip
	bStripMale = new bool[33]
	bStripMale[0] = true
	bStripMale[1] = true
	bStripMale[2] = true
	bStripMale[3] = true
	bStripMale[7] = true
	bStripMale[8] = true
	bStripMale[9] = true
	bStripMale[4] = true
	bStripMale[11] = true
	bStripMale[15] = true
	bStripMale[16] = true
	bStripMale[17] = true
	bStripMale[19] = true
	bStripMale[23] = true
	bStripMale[24] = true
	bStripMale[26] = true
	bStripMale[27] = true
	bStripMale[28] = true
	bStripMale[29] = true
	bStripMale[32] = true

	bStripFemale = new bool[33]
	bStripFemale[0] = true
	bStripFemale[1] = true
	bStripFemale[2] = true
	bStripFemale[3] = true
	bStripFemale[4] = true
	bStripFemale[7] = true
	bStripFemale[8] = true
	bStripFemale[9] = true
	bStripFemale[11] = true
	bStripFemale[15] = true
	bStripFemale[16] = true
	bStripFemale[17] = true
	bStripFemale[19] = true
	bStripFemale[23] = true
	bStripFemale[24] = true
	bStripFemale[26] = true
	bStripFemale[27] = true
	bStripFemale[28] = true
	bStripFemale[29] = true
	bStripFemale[32] = true

	bStripLeadInFemale = new bool[33]
	bStripLeadInFemale[0] = true
	bStripLeadInFemale[2] = true
	bStripLeadInFemale[9] = true
	bStripLeadInFemale[14] = true
	bStripLeadInFemale[32] = true

	bStripLeadInMale = new bool[33]
	bStripLeadInMale[0] = true
	bStripLeadInMale[2] = true
	bStripLeadInMale[9] = true
	bStripLeadInMale[14] = true
	bStripLeadInMale[32] = true

	bStripVictim = new bool[33]
	bStripVictim[1] = true
	bStripVictim[2] = true
	bStripVictim[4] = true
	bStripVictim[9] = true
	bStripVictim[11] = true
	bStripVictim[16] = true
	bStripVictim[24] = true
	bStripVictim[26] = true
	bStripVictim[28] = true
	bStripVictim[32] = true

	bStripAggressor = new bool[33]
	bStripAggressor[2] = true
	bStripAggressor[4] = true
	bStripAggressor[9] = true
	bStripAggressor[16] = true
	bStripAggressor[24] = true
	bStripAggressor[26] = true

	; Config
	fSFXDelay = 4.0
	fSFXVolume = 0.8
	bAutoAdvance = true
	bForeplayStage = false
	bOrgasmEffects = false
	sNPCBed = "$SSL_Never"
	; Timers
	fStageTimer = new float[5]
	fStageTimer[0] = 30.0
	fStageTimer[1] = 20.0
	fStageTimer[2] = 15.0
	fStageTimer[3] = 15.0
	fStageTimer[4] = 9.0

	fStageTimerLeadIn = new float[5]
	fStageTimerLeadIn[0] = 10.0
	fStageTimerLeadIn[1] = 10.0
	fStageTimerLeadIn[2] = 10.0
	fStageTimerLeadIn[3] = 8.0
	fStageTimerLeadIn[4] = 8.0

	fStageTimerAggr = new float[5]
	fStageTimerAggr[0] = 20.0
	fStageTimerAggr[1] = 15.0
	fStageTimerAggr[2] = 10.0
	fStageTimerAggr[3] = 10.0
	fStageTimerAggr[4] = 3.0

endFunction


function _ExportFloat(string name, float value)
	StorageUtil.FileSetFloatValue("SexLabConfig."+name, value)
endFunction
function _ExportInt(string name, int value)
	StorageUtil.FileSetIntValue("SexLabConfig."+name, value)
endFunction
function _ExportBool(string name, bool value)
	StorageUtil.FileSetIntValue("SexLabConfig."+name, value as int)
endFunction
function _ExportString(string name, string value)
	StorageUtil.FileSetStringValue("SexLabConfig."+name, value)
endFunction

float function _ImportFloat(string name, float value)
	if StorageUtil.FileHasFloatValue("SexLabConfig."+name)
		value = StorageUtil.FileGetFloatValue("SexLabConfig."+name, value)
		StorageUtil.FileUnsetFloatValue("SexLabConfig."+name)
	endIf
	return value
endFunction
int function _ImportInt(string name, int value)
	if StorageUtil.FileHasIntValue("SexLabConfig."+name)
		value = StorageUtil.FileGetIntValue("SexLabConfig."+name, value)
		StorageUtil.FileUnsetIntValue("SexLabConfig."+name)
	endIf
	return value
endFunction
bool function _ImportBool(string name, bool value)
	if StorageUtil.FileHasIntValue("SexLabConfig."+name)
		value = StorageUtil.FileGetIntValue("SexLabConfig."+name, value as int) as bool
		StorageUtil.FileUnsetIntValue("SexLabConfig."+name)
	endIf
	return value
endFunction
string function _ImportString(string name, string value)
	if StorageUtil.FileHasStringValue("SexLabConfig."+name)
		value = StorageUtil.FileGetStringValue("SexLabConfig."+name, value)
		StorageUtil.FileUnsetStringValue("SexLabConfig."+name)
	endIf
	return value
endFunction

function _ExportFloatList(string name, float[] values, int len)
	StorageUtil.FileFloatListClear("SexLabConfig."+name)
	int i
	while i < len
		StorageUtil.FileFloatListAdd("SexLabConfig."+name, values[i])
		i += 1
	endWhile
endFunction
function _ExportBoolList(string name, bool[] values, int len)
	StorageUtil.FileIntListClear("SexLabConfig."+name)
	int i
	while i < len
		StorageUtil.FileIntListAdd("SexLabConfig."+name, values[i] as int)
		i += 1
	endWhile
endFunction

float[] function _ImportFloatList(string name, float[] values, int len)
	if StorageUtil.FileFloatListCount("SexLabConfig."+name) == len
		int i
		while i < len
			values[i] = StorageUtil.FileFloatListGet("SexLabConfig."+name, i)
			i += 1
		endWhile
	endIf
	StorageUtil.FileFloatListClear("SexLabConfig."+name)
	return values
endFunction
bool[] function _ImportBoolList(string name, bool[] values, int len)
	if StorageUtil.FileIntListCount("SexLabConfig."+name) == len
		int i
		while i < len
			values[i] = StorageUtil.FileIntListGet("SexLabConfig."+name, i) as bool
			i += 1
		endWhile
	endIf
	StorageUtil.FileIntListClear("SexLabConfig."+name)
	return values
endFunction
