000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. BILMNU01.
000300*---------------------------------
000400* Menu for the bill payment system.
000500*---------------------------------
000600 ENVIRONMENT DIVISION.
000700 INPUT-OUTPUT SECTION.
000800 FILE-CONTROL.
000900
001000 DATA DIVISION.
001100 FILE SECTION.
001200
001300 WORKING-STORAGE SECTION.
001400
001500 77  MENU-PICK                    PIC 9.
001600     88  MENU-PICK-IS-VALID       VALUES 0 THRU 2.
001700
001800 PROCEDURE DIVISION.
001900 PROGRAM-BEGIN.
002000     PERFORM OPENING-PROCEDURE.
002100     PERFORM MAIN-PROCESS.
002200     PERFORM CLOSING-PROCEDURE.
002300
002400 PROGRAM-EXIT.
002500     EXIT PROGRAM.
002600
002700 PROGRAM-DONE.
002800     STOP RUN.
002900
003000 OPENING-PROCEDURE.
003100
003200 CLOSING-PROCEDURE.
003300
003400 MAIN-PROCESS.
003500     PERFORM GET-MENU-PICK.
003600     PERFORM DO-THE-PICK
003700         UNTIL MENU-PICK = 0.
003800
003900*---------------------------------
004000* MENU
004100*---------------------------------
004200 GET-MENU-PICK.
004300     PERFORM DISPLAY-THE-MENU.
004400     PERFORM ACCEPT-MENU-PICK.
004500     PERFORM RE-ACCEPT-MENU-PICK
004600         UNTIL MENU-PICK-IS-VALID.
004700
004800 DISPLAY-THE-MENU.
004900     PERFORM CLEAR-SCREEN.
005000     DISPLAY "    PLEASE SELECT:".
005100     DISPLAY " ".
005200     DISPLAY "          1.  STATE CODE MAINTENANCE".
005300     DISPLAY "          2.  VENDOR MAINTENANCE".
005400     DISPLAY " ".
005500     DISPLAY "          0.  EXIT".
005600     PERFORM SCROLL-LINE 8 TIMES.
005700
005800 ACCEPT-MENU-PICK.
005900     DISPLAY "YOUR CHOICE (0-2)?".
006000     ACCEPT MENU-PICK.
006100
006200 RE-ACCEPT-MENU-PICK.
006300     DISPLAY "INVALID SELECTION - PLEASE RE-TRY.".
006400     PERFORM ACCEPT-MENU-PICK.
006500
006600 CLEAR-SCREEN.
006700     PERFORM SCROLL-LINE 25 TIMES.
006800
006900 SCROLL-LINE.
007000     DISPLAY " ".
007100
007200 DO-THE-PICK.
007300     IF MENU-PICK = 1
007400         PERFORM STATE-MAINTENANCE
007500     ELSE
007600     IF MENU-PICK = 2
007700         PERFORM VENDOR-MAINTENANCE.
007800
007900     PERFORM GET-MENU-PICK.
008000
008100*---------------------------------
008200* STATE
008300*---------------------------------
008400 STATE-MAINTENANCE.
008500     CALL "STCMNT04".
008600
008700*---------------------------------
008800* VENDOR
008900*---------------------------------
009000 VENDOR-MAINTENANCE.
009100     CALL "VNDMNT04".
009200
