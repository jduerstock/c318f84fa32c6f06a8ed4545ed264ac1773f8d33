
_fcc_bbox	=	0x62626f78
_fcc_bugx	=	0x62756778
_fcc_cnfn	=	0x636e666e
_fcc_icon	=	0x69636f6e
_fcc_init	=	0x696e6974
_fcc_krnl	=	0x6b726e6c
_fcc_ptch	=	0x70746368
_fcc_show	=	0x73686f77
_fcc_sysv	=	0x73797376

ROMBase		=	0x2ae
ExpandMem	=	0x2b6
DefltStack	=	0x322
TopMapHndl	=	0xa50
SysMap		=	0xa58
CurMap		=	0xa5a
RestProc	=	0xa8c

ADBReInit	=	0xa07b
UnimplTrap	=	0xa89f

.macro	CallVector base vector
		.short	0x2f30,0x81e2
		.short	\base
		.short	(\vector) << 2
	.endm

.macro	_Open
	.short	0xa000
.endm

.macro	_Close
	.short	0xa001
.endm

.macro	_Read
	.short	0xa002
.endm

.macro	_Write
	.short	0xa003
.endm

.macro	_Control
	.short	0xa004
.endm

.macro	_Status
	.short	0xa005
.endm

.macro	_MountVol
	.short	0xa00f
.endm

.macro	_GetEOF
	.short	0xa011
.endm

.macro	_SetEOF
	.short	0xa012
.endm

.macro	_GetVol
	.short	0xa014
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

.macro	_SetHandleSize
	.short	0xa024
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

.macro	_WriteParam
	.short	0xa038
.endm

.macro	_Delay
	.short	0xa03b
.endm

.macro	_CmpString
	.short	0xa03c
.endm

.macro	_InitUtil
	.short	0xa03f
.endm

.macro	_SetFPos
	.short	0xa044
.endm

.macro	_SetTrapAddress
	.short	0xa047
.endm

.macro	_HNoPurge
	.short	0xa04a
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

.macro	_SetAppBase
	.short	0xa057
.endm

.macro	_RmvTime
	.short	0xa059
.endm

.macro	_PrimeTime
	.short	0xa05a
.endm

.macro	_MemoryDispatch
	.short	0xa05c
.endm

.macro	_LockMemoryContiguous
	moveq	#4,%d0
	_MemoryDispatch
.endm

.macro	_NMInstall
	.short	0xa05e
.endm

.macro	_MoveHHi
	.short	0xa064
.endm

.macro	_HGetState
	.short	0xa069
.endm

.macro	_HSetState
	.short	0xa06a
.endm

.macro	_InitEvents
	.short	0xa06d
.endm

.macro	_SlotManager
	.short	0xa06e
.endm

.macro	_CountADBs
	.short	0xa077
.endm

.macro	_GetIndADB
	.short	0xa078
.endm

.macro	_ADBReInit
	.short	0xa07b
.endm

.macro	_ADBOp
	.short	0xa07c
.endm

.macro	_GetDefaultStartup
	.short	0xa07d
.endm

.macro	_InternalWait
	.short	0xa07f
.endm

.macro	_SCSIAtomic
	.short	0xa089
.endm

.macro	_SCSIAction
	moveq	#1,%d0
	_SCSIAtomic
.endm

.macro	_Egret
	.short	0xa092
.endm

.macro	_HWPriv
	.short	0xa098
.endm

.macro	_FlushCodeCacheRange
	moveq	#9,%d0
	_HWPriv
.endm

.macro	_PowerMgrDispatch
	.short	0xa09e
.endm

.macro	_PowerDispatch
	.short	0xa09f
.endm

.macro	_FSM
	.short	0xa0ac
.endm

.macro	_GetZone
	.short	0xa11a
.endm

.macro	_NewPtr
	.short	0xa11e
.endm

.macro	_NewHandle
	.short	0xa122
.endm

.macro	_PostEvent
	.short	0xa12f
.endm

.macro	_GetTrapAddress
	.short	0xa146
.endm

.macro	_PtrZone
	.short	0xa148
.endm

.macro	_Gestalt
	.short	0xa1ad
.endm

.macro	_PBControlImmed
	.short	0xa204
.endm

.macro	_PBStatusImmed
	.short	0xa205
.endm

.macro	_PBHGetVInfoSync
	.short	0xa207
.endm

.macro	_PBHDeleteSync
	.short	0xa209
.endm

.macro	_PBHRenameSync
	.short	0xa20b
.endm

.macro	_PBHGetFInfoSync
	.short	0xa20c
.endm

.macro	_PBHSetFInfoSync
	.short	0xa20d
.endm

.macro	_BlockMoveData
	.short	0xa22e
.endm

.macro	_MarkSensitiveEqualString
	.short	0xa23c
.endm

.macro	_SetOSTrapAddress
	.short	0xa247
.endm

.macro	_MarkSensitiveRelString	/* ??? */
	.short	0xa250
.endm

.macro	_HFSDispatch
	.short	0xa260
.endm

.macro	_PBCatMoveSync
	moveq	#5,%d0
	_HFSDispatch
.endm

.macro	_GetOSTrapAddress
	.short	0xa346
.endm

.macro	_NewGestalt
	.short	0xa3ad
.endm

.macro	_FreeMemSys
	.short	0xa41c
.endm

.macro	_CaseSensitiveEqualString
	.short	0xa43c
.endm

.macro	_ReserveMemSys
	.short	0xa440
.endm

.macro	_CompactMemSys
	.short	0xa44c
.endm

.macro	_CaseSensitiveRelString	/* ??? */
	.short	0xa450
.endm

.macro	_InsXTime
	.short	0xa458
.endm

.macro	_NewPtrSys
	.short	0xa51e
.endm

.macro	_ReplaceGestalt
	.short	0xa5ad
.endm

.macro	_CaseAndMarkSensitiveEqualString
	.short	0xa63c
.endm

.macro	_SetToolTrapAddress
	.short	0xa647
.endm

.macro	_CaseAndMarkSensitiveRelString	/* ??? */
	.short	0xa650
.endm

.macro	_NewPtrSysClear
	.short	0xa71e
.endm

.macro	_NewHandleSysClear
	.short	0xa722
.endm

.macro	_GetToolTrapAddress
	.short	0xa746
.endm

.macro	_rGetResource
	.short	0xa80c
.endm

.macro	_Count1Resources
	.short	0xa80d
.endm

.macro	_Get1IndResource
	.short	0xa80e
.endm

.macro	_CopyMask
	.short	0xa817
.endm

.macro	_HOpenResFile
	.short	0xa81a
.endm

.macro	_HCreateResFile
	.short	0xa81b
.endm

.macro	_Get1Resource
	.short	0xa81f
.endm

.macro	_ResourceDispatch
	.short	0xa822
.endm

.macro	_AliasDispatch
	.short	0xa823
.endm

.macro	_ComponentDispatch
	.short	0xa82a
.endm

.macro	_InitCursor
	.short	0xa850
.endm

.macro	_SetCursor
	.short	0xa851
.endm

.macro	_ShowCursor
	.short	0xa853
.endm

.macro	_BitShift
	.short	0xa85c
.endm

.macro	_GlobalToLocal
	.short	0xa871
.endm

.macro	_SetPort
	.short	0xa873
.endm

.macro	_GetPort
	.short	0xa874
.endm

.macro	_ForeColor
	.short	0xa862
.endm

.macro	_BackColor
	.short	0xa863
.endm

.macro	_InitPort
	.short	0xa86d
.endm

.macro	_InitGraf
	.short	0xa86e
.endm

.macro	_OpenPort
	.short	0xa86f
.endm

.macro	_MovePortTo
	.short	0xa877
.endm

.macro	_BackPat
	.short	0xa87c
.endm

.macro	_ClosePort
	.short	0xa87d
.endm

.macro	_DrawString
	.short	0xa884
.endm

.macro	_TextFont
	.short	0xa887
.endm

.macro	_TextFace
	.short	0xa888
.endm

.macro	_TextMode
	.short	0xa889
.endm

.macro	_TextSize
	.short	0xa88a
.endm

.macro	_GetFontInfo
	.short	0xa88b
.endm

.macro	_StringWidth
	.short	0xa88c
.endm

.macro	_LineTo
	.short	0xa891
.endm

.macro	_MoveTo
	.short	0xa893
.endm

.macro	_ShutDown
	.short	0xa895
.endm

.macro	_GetPenState
	.short	0xa898
.endm

.macro	_SetPenState
	.short	0xa899
.endm

.macro	_PenSize
	.short	0xa89b
.endm

.macro	_PenNormal
	.short	0xa89e
.endm

.macro	_UnimplTrap
	.short	0xa89f
.endm

.macro	_FrameRect
	.short	0xa8a1
.endm

.macro	_PaintRect
	.short	0xa8a2
.endm

.macro	_EraseRect
	.short	0xa8a3
.endm

.macro	_FillRect
	.short	0xa8a5
.endm

.macro	_OffsetRect
	.short	0xa8a8
.endm

.macro	_InsetRect
	.short	0xa8a9
.endm

.macro	_FrameRoundRect
	.short	0xa8b0
.endm

.macro	_FillRoundRect
	.short	0xa8b4
.endm

.macro	_ScriptUtil
	.short	0xa8b5
.endm

.macro	_NewRgn
	.short	0xa8d8
.endm

.macro	_DisposeRgn
	.short	0xa8d9
.endm

.macro	_RectRgn
	.short	0xa8df
.endm

.macro	_CopyBits
	.short	0xa8ec
.endm

.macro	_DrawPicture
	.short	0xa8f6
.endm

.macro	_InitFonts
	.short	0xa8fe
.endm

.macro	_GetFNum
	.short	0xa900
.endm

.macro	_PaintBehind
	.short	0xa90d
.endm

.macro	_InitWindows
	.short	0xa912
.endm

.macro	_ShowWindow
	.short	0xa915
.endm

.macro	_GetWRefCon
	.short	0xa917
.endm

.macro	_SetWRefCon
	.short	0xa918
.endm

.macro	_SelectWindow
	.short	0xa91f
.endm

.macro	_FrontWindow
	.short	0xa924
.endm

.macro	_CloseWindow
	.short	0xa92d
.endm

.macro	_InitMenus
	.short	0xa930
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

.macro	_SetControlTitle
	.short	0xa95f
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

.macro	_UpdateDialog
	.short	0xa978
.endm

.macro	_InitDialogs
	.short	0xa97b
.endm

.macro	_GetNewDialog
	.short	0xa97c
.endm

.macro	_DrawDialog
	.short	0xa981
.endm

.macro	_DisposeDialog
	.short	0xa983
.endm

.macro	_Alert
	.short	0xa985
.endm

.macro	_GetDialogItem
	.short	0xa98d
.endm

.macro	_SetDialogItemText
	.short	0xa98f
.endm

.macro	_ModalDialog
	.short	0xa991
.endm

.macro	_DetachResource
	.short	0xa992
.endm

.macro	_CurResFile
	.short	0xa994
.endm

.macro	_RsrcZoneInit
	.short	0xa996
.endm

.macro	_OpenResFile
	.short	0xa997
.endm

.macro	_UseResFile
	.short	0xa998
.endm

.macro	_UpdateResFile
	.short	0xa999
.endm

.macro	_CloseResFile
	.short	0xa99a
.endm

.macro	_SetResLoad
	.short	0xa99b
.endm

.macro	_CountResources
	.short	0xa99c
.endm

.macro	_GetIndResource
	.short	0xa99d
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

.macro	_HomeResFile
	.short	0xa9a4
.endm

.macro	_GetResourceSizeOnDisk
	.short	0xa9a5
.endm

.macro	_GetResInfo
	.short	0xa9a8
.endm

.macro	_ChangedResource
	.short	0xa9aa
.endm

.macro	_AddResource
	.short	0xa9ab
.endm

.macro	_RemoveResource
	.short	0xa9ad
.endm

.macro	_ResError
	.short	0xa9af
.endm

.macro	_GetCursor
	.short	0xa9b9
.endm

.macro	_GetString
	.short	0xa9ba
.endm

.macro	_GetPicture
	.short	0xa9bc
.endm

.macro	_SysBeep
	.short	0xa9c8
.endm

.macro	_SysError p1
	.ifnb	\p1
		.ifge	\p1-128
			movew	#\p1,%d0
		.else
			moveq	#\p1,%d0
		.endif
	.endif
	.short	0xa9c9
.endm

.macro	_TEInit
	.short	0xa9cc
.endm

.macro	_Munger
	.short	0xa9e0
.endm

.macro	_HandToHand
	.short	0xa9e1
.endm

.macro	_InitAllPacks
	.short	0xa9e6
.endm

.macro	_Pack7
	.short	0xa9ee
.endm

.macro	_Launch
	.short	0xa9f2
.endm

.macro	_Debugger
	.short	0xa9ff
.endm

.macro	_OpenCPort
	.short	0xaa00
.endm

.macro	_InitCPort
	.short	0xaa01
.endm

.macro	_CloseCPort
	.short	0xaa02
.endm

.macro	_PenPixPat
	.short	0xaa0a
.endm

.macro	_BackPixPat
	.short	0xaa0b
.endm

.macro	_RGBForeColor
	.short	0xaa14
.endm

.macro	_RGBBackColor
	.short	0xaa15
.endm

.macro	_GetCPixel
	.short	0xaa17
.endm

.macro	_GetForeColor
	.short	0xaa19
.endm

.macro	_GetBackColor
	.short	0xaa1a
.endm

.macro	_GetCIcon
	.short	0xaa1e
.endm

.macro	_PlotCIcon
	.short	0xaa1f
.endm

.macro	_DisposeCIcon
	.short	0xaa25
.endm

.macro	_GetDeviceList
	.short	0xaa29
.endm

.macro	_GetMainDevice
	.short	0xaa2a
.endm

.macro	_GetNextDevice
	.short	0xaa2b
.endm

.macro	_TestDeviceAttribute
	.short	0xaa2c
.endm

.macro	_NewCWindow
	.short	0xaa45
.endm

.macro	_GetCWMgrPort
	.short	0xaa48
.endm

.macro	_HighLevelFSDispatch
	.short	0xaa52
.endm

.macro	_TextServicesDispatch
	.short	0xaa54
.endm

.macro	_MixedModeDispatch
	.short	0xaa59
.endm

.macro	_CodeFragmentDispatch
	.short	0xaa5a
.endm

.macro	_DialogDispatch
	.short	0xaa68
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

.macro	_InitPalettes
	.short	0xaa90
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

.macro	_RegistryEntryIDInit
	moveq	#0,%d0
	_NameRegistryDispatch
.endm

.macro	_RegistryEntryIDDispose
	moveq	#3,%d0
	_NameRegistryDispatch
.endm

.macro	_RegistryEntryIterateCreate
	moveq	#7,%d0
	_NameRegistryDispatch
.endm

.macro	_RegistryEntryIterateDispose
	moveq	#8,%d0
	_NameRegistryDispatch
.endm

.macro	_RegistryEntryIterate
	moveq	#10,%d0
	_NameRegistryDispatch
.endm

.macro	_RegistryEntrySearch
	moveq	#11,%d0
	_NameRegistryDispatch
.endm

.macro	_RegistryCStrEntryLookup
	moveq	#12,%d0
	_NameRegistryDispatch
.endm

.macro	_RegistryCStrEntryToName
	moveq	#15,%d0
	_NameRegistryDispatch
.endm

.macro	_RegistryPropertyGet
	moveq	#23,%d0
	_NameRegistryDispatch
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

.macro	_ExecuteRiscContext
	.short	0xfe03
.endm

.macro	_MoveFromECR
	.short	0xfe04
.endm

.macro	_MoveToECR
	.short	0xfe05
.endm

.macro	_HandleMixedModeFault
	.short	0xfe07
.endm

.macro	_KernelVMDispatch
	.short	0xfe0a
.endm

.macro	_nkMMUFinalInit
	moveq	#2,%d0
	_KernelVMDispatch
.endm

.macro	_nkMMUGetPhysicalPage
	moveq	#10,%d0
	_KernelVMDispatch
.endm

.macro	_nkMakePageWriteThrough
	moveq	#24,%d0
	_KernelVMDispatch
.endm

.macro	_BlueBoxDispatch	/* ??? */
	.short	0xfe22
.endm

