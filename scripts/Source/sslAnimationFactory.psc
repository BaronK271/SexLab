scriptname sslAnimationFactory extends Quest hidden

sslAnimationSlots property Slots auto hidden

; Gender Types
int property Male = 0 autoreadonly hidden
int property Female = 1 autoreadonly hidden
int property Creature = 2 autoreadonly hidden
int property CreatureMale = 2 autoreadonly hidden
int property CreatureFemale = 3 autoreadonly hidden
; Cum Types
int property Vaginal = 1 autoreadonly hidden
int property Oral = 2 autoreadonly hidden
int property Anal = 3 autoreadonly hidden
int property VaginalOral = 4 autoreadonly hidden
int property VaginalAnal = 5 autoreadonly hidden
int property OralAnal = 6 autoreadonly hidden
int property VaginalOralAnal = 7 autoreadonly hidden
; Content Types
int property Misc = 0 autoreadonly hidden
int property Sexual = 1 autoreadonly hidden
int property Foreplay = 2 autoreadonly hidden
; SFX Types
Sound property Squishing auto hidden
Sound property Sucking auto hidden
Sound property SexMix auto hidden
Sound property Squirting auto hidden

; ------------------------------------------------------- ;
; --- Registering Animations                          --- ;
; ------------------------------------------------------- ;

; Prepare the factory for use with the default animation slots
function PrepareFactory()
	Squishing = Game.GetFormFromFile(0x65A31, "SexLab.esm") as Sound
	Sucking   = Game.GetFormFromFile(0x65A32, "SexLab.esm") as Sound
	SexMix    = Game.GetFormFromFile(0x65A33, "SexLab.esm") as Sound
	Squirting = Game.GetFormFromFile(0x65A34, "SexLab.esm") as Sound
	Slots     = Game.GetFormFromFile(0x639DF, "SexLab.esm") as sslAnimationSlots
endFunction

; Prepare the factory for use with the default creature animation slots
function PrepareFactoryCreatures()
	Squishing = Game.GetFormFromFile(0x65A31, "SexLab.esm") as Sound
	Sucking   = Game.GetFormFromFile(0x65A32, "SexLab.esm") as Sound
	SexMix    = Game.GetFormFromFile(0x65A33, "SexLab.esm") as Sound
	Squirting = Game.GetFormFromFile(0x65A34, "SexLab.esm") as Sound
	Slots     = Game.GetFormFromFile(0x664FB, "SexLab.esm") as sslCreatureAnimationSlots
endFunction

; Send callback event to start registration
function RegisterAnimation(string Registrar)
	; Get free Animation slot
	int id = Slots.Register(Registrar)
	if id != -1
		; Send load event
		sslBaseAnimation Slot = Slots.GetBySlot(id)
		Slot.Initialize()
		Slot.Registry = Registrar
		Slot.Enabled  = true
		RegisterForModEvent(Registrar, Registrar)
		int eid = ModEvent.Create(Registrar)
		ModEvent.PushInt(eid, id)
		ModEvent.Send(eid)
	endIf
endFunction

; Gets the Animation resource object for use in the callback, MUST be called at start of callback to get the appropiate resource
sslBaseAnimation function Create(int id)
	sslBaseAnimation Slot = Slots.GetbySlot(id)
	UnregisterForModEvent(Slot.Registry)
	return Slot
endFunction

function Initialize()
	PrepareFactory()
endfunction
