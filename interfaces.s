
CurMap	=	0xa5a

.macro	_Open
	.short	0xa000
.endm

.macro	_Control
	.short	0xa004
.endm

.macro	_Status
	.short	0xa005
.endm

.macro	_SetZone
	.short	0xa01b
.endm

.macro	_DisposePtr
	.short	0xa01f
.endm

.macro	_GetPtrSize
	.short	0xa021
.endm

.macro	_DisposeHandle
	.short	0xa023
.endm

.macro	_GetHandleSize
	.short	0xa025
.endm

.macro	_HLock
	.short	0xa029
.endm

.macro	_HUnlock
	.short	0xa02a
.endm

.macro	_InitApplZone
	.short	0xa02c
.endm

.macro	_SetApplLimit
	.short	0xa02d
.endm

.macro	_BlockMove
	.short	0xa02e
.endm

.macro	_GetOSEvent
	.short	0xa031
.endm

.macro	_Delay
	.short	0xa03b
.endm

.macro	_RelString
	.short	0xa050
.endm

.macro	_ReadXPRAM
	.short	0xa051
.endm

.macro	_WriteXPRAM
	.short	0xa052
.endm

.macro	_MemoryDispatch
	.short	0xa05c
.endm

.macro	_HGetState
	.short	0xa069
.endm

.macro	_HSetState
	.short	0xa06a
.endm

.macro	_GetZone
	.short	0xa11a
.endm

.macro	_NewPtr
	.short	0xa11e
.endm

.macro	_Gestalt
	.short	0xa1ad
.endm

.macro	_PBHGetFInfoSync
	.short	0xa20c
.endm

.macro	_BlockMoveData
	.short	0xa22e
.endm

.macro	_HFSDispatch
	.short	0xa260
.endm

.macro	_ReserveMemSys
	.short	0xa440
.endm

.macro	_NewPtrSys
	.short	0xa51e
.endm

.macro	_SetToolTrapAddress
	.short	0xa647
.endm

.macro	_NewPtrSysClear
	.short	0xa71e
.endm

.macro	_NewHandleSysClear
	.short	0xa722
.endm

.macro	_Get1Resource
	.short	0xa81f
.endm

.macro	_AliasDispatch
	.short	0xa823
.endm

.macro	_SetCursor
	.short	0xa851
.endm

.macro	_GlobalToLocal
	.short	0xa871
.endm

.macro	_InitGraf
	.short	0xa86e
.endm

.macro	_LineTo
	.short	0xa891
.endm

.macro	_MoveTo
	.short	0xa893
.endm

.macro	_GetWRefCon
	.short	0xa917
.endm

.macro	_ShowControl
	.short	0xa957
.endm

.macro	_HideControl
	.short	0xa958
.endm

.macro	_HiliteControl
	.short	0xa95d
.endm

.macro	_SetControlValue
	.short	0xa963
.endm

.macro	_TrackControl
	.short	0xa968
.endm

.macro	_DrawControls
	.short	0xa969
.endm

.macro	_FindControl
	.short	0xa96c
.endm

.macro	_TickCount
	.short	0xa975
.endm

.macro	_GetNewDialog
	.short	0xa97c
.endm

.macro	_DetachResource
	.short	0xa992
.endm

.macro	_CurResFile
	.short	0xa994
.endm

.macro	_UseResFile
	.short	0xa998
.endm

.macro	_CloseResFile
	.short	0xa99a
.endm

.macro	_GetResource
	.short	0xa9a0
.endm

.macro	_LoadResource
	.short	0xa9a2
.endm

.macro	_ReleaseResource
	.short	0xa9a3
.endm

.macro	_ResError
	.short	0xa9af
.endm

.macro	_GetCursor
	.short	0xa9b9
.endm

.macro	_SysError
	.short	0xa9c9
.endm

.macro	_TEInit
	.short	0xa9cc
.endm

.macro	_OpenCPort
	.short	0xaa00
.endm

.macro	_CloseCPort
	.short	0xaa02
.endm

.macro	_RGBForeColor
	.short	0xaa14
.endm

.macro	_RGBBackColor
	.short	0xaa15
.endm

.macro	_TestDeviceAttribute
	.short	0xaa2c
.endm

.macro	_HighLevelFSDispatch
	.short	0xaa52
.endm

.macro	_MixedModeDispatch
	.short	0xaa59
.endm

.macro	_CodeFragmentDispatch
	.short	0xaa5a
.endm

.macro	_ControlDispatch
	.short	0xaa73
.endm

.macro	_IconServicesDispatch
	.short	0xaa75
.endm

.macro	_StartupDispatch
	.short	0xaa7d
.endm

.macro	_MPDispatch	/* undocumented -- MultiprocessingDispatch */
	.short	0xaa7f
.endm

.macro	_ExpansionBusDispatch
	.short	0xaaf3
.endm

.macro	_IconDispatch
	.short	0xabc9
.endm

.macro	_NameRegistryDispatch
	.short	0xabe9
.endm

.macro	_DisplayDispatch
	.short	0xabeb
.endm

.macro	_GestaltValueDispatch
	.short	0xabf1
.endm

.macro	_DebugStr
	.short	0xabff
.endm
