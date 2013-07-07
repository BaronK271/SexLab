scriptname sslBaseThread extends quest
{DEPRECATED SCRIPT, TO BE REMOVED IN 1.2}

SexLabFramework property SexLab auto

int function tid()
	return -1
endFunction

sslThreadController property Controller hidden
	sslThreadController function get()
		return SexLab.Controllers[tid()]
	endFunction
endProperty

int function GetPlayerPosition()
	_Deprecate("GetPlayerPosition", "GetPlayerPosition()")
	return Controller.GetPlayerPosition()
endFunction

int function GetStage()
	_Deprecate("GetStage", "Stage property")
	return Controller.Stage
endFunction

sslBaseAnimation function GetAnimation()
	_Deprecate("GetAnimation", "Animation property")
	return Controller.Animation
endFunction

actor[] function GetActors()
	_Deprecate("GetActors", "Positions property")
	return Controller.Positions
endFunction

function SetAnimation(sslBaseAnimation animation)
	_Deprecate("SetAnimation", "SetAnimation()")
	int aid = GetAnimationList().Find(animation)
	Controller.SetAnimation(aid)
endFunction

sslBaseAnimation[] function GetAnimationList()
	_Deprecate("GetAnimationList", "Animations property")
	return Controller.Animations
endFunction

function SetAnimationList(sslBaseAnimation[] animationList)
	_Deprecate("SetAnimationList", "SetAnimationList()")
	Controller.SetAnimations(animationList)
endFunction

function CenterOnCoords(float LocX = 0.0, float LocY = 0.0, float LocZ = 0.0, float RotX = 0.0, float RotY = 0.0, float RotZ = 0.0, bool resync = true)
	_Deprecate("CenterOnCoords", "CenterOnCoords()")
	Controller.CenterOnCoords(LocX, LocY, LocZ, RotX, RotY, RotZ, resync)
endFunction

function CenterOnObject(ObjectReference center, bool resync = true)
	_Deprecate("CenterOnObject","CenterOnObject()")
	Controller.CenterOnObject(center, resync)
endFunction

actor function GetVictim()
	_Deprecate("GetVictim","GetVictim()")
	return Controller.GetVictim()
endFunction

float function GetTime()
	_Deprecate("GetTime","GetTime()")
	return Controller.GetTime()
endFunction

function ChangeActors(actor[] changeTo)
	_Deprecate("ChangeActors","ChangeActors()")
	Controller.ChangeActors(changeTo)
endFunction

function _Deprecate(string deprecated, string replacer)
	Debug.Notification(deprecated+"() has been deprecated; check trace log")
	Debug.Trace("--------------------------------------------------------------------------------------------", 1)
	Debug.Trace("-- ATTENTION MODDER: SEXLAB DEPRECATION NOTICE ---------------------------------------------", 1)
	Debug.Trace("--------------------------------------------------------------------------------------------", 1)
	Debug.Trace(" sslBaseThread."+deprecated+"() is deprecated and will be removed in the next major update of SexLab.", 1)
	Debug.Trace(" Update your mod to use sslThreadController."+deprecated+" instead, or notify the creator", 1)
	Debug.Trace(" of the mod which is calling it.", 1)
	Debug.TraceStack(" sslBaseThread."+deprecated+"() Called By: ", 1)
	Debug.Trace("--------------------------------------------------------------------------------------------", 1)
endFunction

