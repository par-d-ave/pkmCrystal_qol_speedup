DelayFrame::
; Wait for one frame
	ld a, 1
	ld [wVBlankOccurred], a

; Wait for the next VBlank, halting to conserve battery
.halt
	halt
	nop
	ld a, [wVBlankOccurred]
	and a
	jr nz, .halt
	ret

DelayFrames::
; Wait c frames
	call DelayFrame
	dec c
	jr nz, DelayFrames
	ret

DEF BATTLE_WAIT_SHIFT EQU 3 ; pausas de combate: c / 8
DEF BATTLE_WAIT_MIN   EQU 4 ; mínimo: un ciclo completo de BG map

BattleDelayFrames::
; Como DelayFrames, pero acortada. Nunca espera menos de BATTLE_WAIT_MIN frames.
	rept BATTLE_WAIT_SHIFT
		srl c
	endr
	ld a, c
	cp BATTLE_WAIT_MIN
	jr nc, .go
	ld c, BATTLE_WAIT_MIN
.go
	jp DelayFrames
