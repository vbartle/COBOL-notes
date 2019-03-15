000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. CTLMNT01.
000300*---------------------------------
000400* Change and Inquire only
000500* for the bills system control
000600* file.
000700*---------------------------------
000800 ENVIRONMENT DIVISION.
000900 INPUT-OUTPUT SECTION.
001000 FILE-CONTROL.
001100
001200     COPY "SLCONTRL.CBL".
001300
001400 DATA DIVISION.
001500 FILE SECTION.
001600
001700     COPY "FDCONTRL.CBL".
001800
001900 WORKING-STORAGE SECTION.
002000
002100 77  MENU-PICK                    PIC 9.
002200     88  MENU-PICK-IS-VALID       VALUES 0 THRU 2.
002300
002400 77  THE-MODE                     PIC X(7).
002500 77  RECORD-FOUND                 PIC X.
002600 77  WHICH-FIELD                  PIC 9.
002700 77  A-DUMMY                      PIC X.
002800
002900 PROCEDURE DIVISION.
003000 PROGRAM-BEGIN.
003100     PERFORM OPENING-PROCEDURE.
003200     PERFORM MAIN-PROCESS.
003300     PERFORM CLOSING-PROCEDURE.
003400
003500 PROGRAM-EXIT.
003600     EXIT PROGRAM.
003700
003800 PROGRAM-DONE.
003900     ACCEPT OMITTED. STOP RUN.
004000
004100 OPENING-PROCEDURE.
004200     OPEN I-O CONTROL-FILE.
004300
004400 CLOSING-PROCEDURE.
004500     CLOSE CONTROL-FILE.
004600
004700
004800 MAIN-PROCESS.
004900     PERFORM GET-MENU-PICK.
005000     PERFORM MAINTAIN-THE-FILE
005100         UNTIL MENU-PICK = 0.
005200
005300*---------------------------------
005400* MENU
005500*---------------------------------
005600 GET-MENU-PICK.
005700     PERFORM DISPLAY-THE-MENU.
005800     PERFORM ACCEPT-MENU-PICK.
005900     PERFORM RE-ACCEPT-MENU-PICK
006000         UNTIL MENU-PICK-IS-VALID.
006100
006200 DISPLAY-THE-MENU.
006300     PERFORM CLEAR-SCREEN.
006400     DISPLAY "    PLEASE SELECT:".
006500     DISPLAY " ".
006600     DISPLAY "        1.  CHANGE  CONTROL INFORMATION".
006700     DISPLAY "        2.  DISPLAY CONTROL INFORMATION".
006800     DISPLAY " ".
006900     DISPLAY "        0.  EXIT".
007000     PERFORM SCROLL-LINE 8 TIMES.
007100
007200 ACCEPT-MENU-PICK.
007300     DISPLAY "YOUR CHOICE (0-2)?".
007400     ACCEPT MENU-PICK.
007500
007600 RE-ACCEPT-MENU-PICK.
007700     DISPLAY "INVALID SELECTION - PLEASE RE-TRY.".
007800     PERFORM ACCEPT-MENU-PICK.
007900
008000 CLEAR-SCREEN.
008100     PERFORM SCROLL-LINE 25 TIMES.
008200
008300 SCROLL-LINE.
008400     DISPLAY " ".
008500
008600 MAINTAIN-THE-FILE.
008700     PERFORM DO-THE-PICK.
008800     PERFORM GET-MENU-PICK.
008900
009000 DO-THE-PICK.
009100     IF MENU-PICK = 1
009200         PERFORM CHANGE-MODE
009300     ELSE
009400     IF MENU-PICK = 2
009500         PERFORM INQUIRE-MODE.
009600
009700*---------------------------------
009800* CHANGE
009900*---------------------------------
010000 CHANGE-MODE.
010100     MOVE "CHANGE" TO THE-MODE.
010200     PERFORM GET-CONTROL-RECORD.
010300     IF RECORD-FOUND = "Y"
010400         PERFORM CHANGE-RECORDS.
010500
010600 CHANGE-RECORDS.
010700     PERFORM GET-FIELD-TO-CHANGE.
010800     PERFORM CHANGE-ONE-FIELD.
010900
011000     PERFORM GET-CONTROL-RECORD.
011100
011200 GET-FIELD-TO-CHANGE.
011300     PERFORM DISPLAY-ALL-FIELDS.
011400     PERFORM ASK-WHICH-FIELD.
011500
011600 ASK-WHICH-FIELD.
011700     MOVE 1 TO WHICH-FIELD.
011800
011900 CHANGE-ONE-FIELD.
012000     PERFORM CHANGE-THIS-FIELD.
012100
012200 CHANGE-THIS-FIELD.
012300     IF WHICH-FIELD = 1
012400         PERFORM ENTER-CONTROL-LAST-VOUCHER.
012500
012600     PERFORM REWRITE-CONTROL-RECORD.
012700
012800*---------------------------------
012900* INQUIRE
013000*---------------------------------
013100 INQUIRE-MODE.
013200     MOVE "DISPLAY" TO THE-MODE.
013300     PERFORM GET-CONTROL-RECORD.
013400     IF RECORD-FOUND = "Y"
013500         PERFORM INQUIRE-RECORDS.
013600
013700 INQUIRE-RECORDS.
013800     PERFORM DISPLAY-ALL-FIELDS.
013900     PERFORM PRESS-ENTER.
014000
014100 PRESS-ENTER.
014200     DISPLAY " ".
014300     DISPLAY "PRESS ENTER TO CONTINUE".
014400     ACCEPT A-DUMMY.
014500
014600*---------------------------------
014700* Routines for Change
014800*---------------------------------
014900 ENTER-CONTROL-LAST-VOUCHER.
015000     PERFORM ACCEPT-CONTROL-LAST-VOUCHER.
015100
015200 ACCEPT-CONTROL-LAST-VOUCHER.
015300     DISPLAY "ENTER LAST VOUCHER NUMBER".
015400     ACCEPT CONTROL-LAST-VOUCHER.
015500
015600*---------------------------------
015700* Routines shared by Change and Inquire
015800*---------------------------------
015900 INIT-CONTROL-RECORD.
016000     MOVE ZEROES TO CONTROL-RECORD.
016100
016200 ENTER-CONTROL-KEY.
016300     MOVE 1 TO CONTROL-KEY.
016400
016500 GET-CONTROL-RECORD.
016600     PERFORM INIT-CONTROL-RECORD.
016700     PERFORM ENTER-CONTROL-KEY.
016800     MOVE "N" TO RECORD-FOUND.
016900     PERFORM FIND-CONTROL-RECORD.
017000
017100 FIND-CONTROL-RECORD.
017200     PERFORM READ-CONTROL-RECORD.
017300     IF RECORD-FOUND = "N"
017400         DISPLAY "RECORD NOT FOUND"
017500         DISPLAY "YOU MUST RUN CTLBLD01"
017600         DISPLAY "TO CREATE THIS FILE".
017700
017800 DISPLAY-ALL-FIELDS.
017900     DISPLAY " ".
018000     PERFORM DISPLAY-CONTROL-LAST-VOUCHER.
018100     DISPLAY " ".
018200
018300 DISPLAY-CONTROL-LAST-VOUCHER.
018400     DISPLAY "1. LAST VOUCHER NUMBER: "
018500                 CONTROL-LAST-VOUCHER.
018600
018700*---------------------------------
018800* File I-O Routines
018900*---------------------------------
019000 READ-CONTROL-RECORD.
019100     MOVE "Y" TO RECORD-FOUND.
019200     READ CONTROL-FILE RECORD
019300       INVALID KEY
019400          MOVE "N" TO RECORD-FOUND.
019500
019600*or  READ CONTROL-FILE RECORD WITH LOCK
019700*      INVALID KEY
019800*         MOVE "N" TO RECORD-FOUND.
019900
020000*or  READ CONTROL-FILE RECORD WITH HOLD
020100*      INVALID KEY
020200*         MOVE "N" TO RECORD-FOUND.
020300
020400 REWRITE-CONTROL-RECORD.
020500     REWRITE CONTROL-RECORD
020600         INVALID KEY
020700         DISPLAY "ERROR REWRITING CONTROL RECORD".
020800
