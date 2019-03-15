000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. STCMNT04.
000300*---------------------------------
000400* Add, Change, Inquire and Delete
000500* for the State Code.
000600* Calls the State Codes Report.
000700*---------------------------------
000800 ENVIRONMENT DIVISION.
000900 INPUT-OUTPUT SECTION.
001000 FILE-CONTROL.
001100
001200     COPY "SLSTATE.CBL".
001300
001400 DATA DIVISION.
001500 FILE SECTION.
001600
001700     COPY "FDSTATE.CBL".
001800
001900 WORKING-STORAGE SECTION.
002000
002100 77  MENU-PICK                    PIC 9.
002200     88  MENU-PICK-IS-VALID       VALUES 0 THRU 5.
002300
002400 77  THE-MODE                     PIC X(7).
002500 77  OK-TO-DELETE                 PIC X.
002600 77  RECORD-FOUND                 PIC X.
002700 77  WHICH-FIELD                  PIC 9.
002800
002900     COPY "WSCASE01.CBL".
003000
003100 PROCEDURE DIVISION.
003200 PROGRAM-BEGIN.
003300     PERFORM OPENING-PROCEDURE.
003400     PERFORM MAIN-PROCESS.
003500     PERFORM CLOSING-PROCEDURE.
003600
003700 PROGRAM-EXIT.
003800     EXIT PROGRAM.
003900
004000 PROGRAM-DONE.
004100     ACCEPT OMITTED. STOP RUN.
004200
004300 OPENING-PROCEDURE.
004400     OPEN I-O STATE-FILE.
004500
004600 CLOSING-PROCEDURE.
004700     CLOSE STATE-FILE.
004800
004900
005000 MAIN-PROCESS.
005100     PERFORM GET-MENU-PICK.
005200     PERFORM MAINTAIN-THE-FILE
005300         UNTIL MENU-PICK = 0.
005400
005500*---------------------------------
005600* MENU
005700*---------------------------------
005800 GET-MENU-PICK.
005900     PERFORM DISPLAY-THE-MENU.
006000     PERFORM ACCEPT-MENU-PICK.
006100     PERFORM RE-ACCEPT-MENU-PICK
006200         UNTIL MENU-PICK-IS-VALID.
006300
006400 DISPLAY-THE-MENU.
006500     PERFORM CLEAR-SCREEN.
006600     DISPLAY "    PLEASE SELECT:".
006700     DISPLAY " ".
006800     DISPLAY "          1.  ADD RECORDS".
006900     DISPLAY "          2.  CHANGE A RECORD".
007000     DISPLAY "          3.  LOOK UP A RECORD".
007100     DISPLAY "          4.  DELETE A RECORD".
007200     DISPLAY "          5.  PRINT RECORDS".
007300     DISPLAY " ".
007400     DISPLAY "          0.  EXIT".
007500     PERFORM SCROLL-LINE 8 TIMES.
007600
007700 ACCEPT-MENU-PICK.
007800     DISPLAY "YOUR CHOICE (0-5)?".
007900     ACCEPT MENU-PICK.
008000
008100 RE-ACCEPT-MENU-PICK.
008200     DISPLAY "INVALID SELECTION - PLEASE RE-TRY.".
008300     PERFORM ACCEPT-MENU-PICK.
008400
008500 CLEAR-SCREEN.
008600     PERFORM SCROLL-LINE 25 TIMES.
008700
008800 SCROLL-LINE.
008900     DISPLAY " ".
009000
009100 MAINTAIN-THE-FILE.
009200     PERFORM DO-THE-PICK.
009300     PERFORM GET-MENU-PICK.
009400
009500 DO-THE-PICK.
009600     IF MENU-PICK = 1
009700         PERFORM ADD-MODE
009800     ELSE
009900     IF MENU-PICK = 2
010000         PERFORM CHANGE-MODE
010100     ELSE
010200     IF MENU-PICK = 3
010300         PERFORM INQUIRE-MODE
010400     ELSE
010500     IF MENU-PICK = 4
010600         PERFORM DELETE-MODE
010700     ELSE
010800     IF MENU-PICK = 5
010900         PERFORM PRINT-THE-RECORDS.
011000
011100*---------------------------------
011200* ADD
011300*---------------------------------
011400 ADD-MODE.
011500     MOVE "ADD" TO THE-MODE.
011600     PERFORM GET-NEW-STATE-CODE.
011700     PERFORM ADD-RECORDS
011800        UNTIL STATE-CODE = "ZZ".
011900
012000 GET-NEW-STATE-CODE.
012100     PERFORM INIT-STATE-RECORD.
012200     PERFORM ENTER-STATE-CODE.
012300     MOVE "Y" TO RECORD-FOUND.
012400     PERFORM FIND-NEW-STATE-RECORD
012500         UNTIL RECORD-FOUND = "N" OR
012600               STATE-CODE = "ZZ".
012700
012800 FIND-NEW-STATE-RECORD.
012900     PERFORM READ-STATE-RECORD.
013000     IF RECORD-FOUND = "Y"
013100         DISPLAY "RECORD ALREADY ON FILE"
013200         PERFORM ENTER-STATE-CODE.
013300
013400 ADD-RECORDS.
013500     PERFORM ENTER-REMAINING-FIELDS.
013600     PERFORM WRITE-STATE-RECORD.
013700     PERFORM GET-NEW-STATE-CODE.
013800
013900 ENTER-REMAINING-FIELDS.
014000     PERFORM ENTER-STATE-NAME.
014100
014200*---------------------------------
014300* CHANGE
014400*---------------------------------
014500 CHANGE-MODE.
014600     MOVE "CHANGE" TO THE-MODE.
014700     PERFORM GET-STATE-RECORD.
014800     PERFORM CHANGE-RECORDS
014900        UNTIL STATE-CODE = "ZZ".
015000
015100 CHANGE-RECORDS.
015200     PERFORM GET-FIELD-TO-CHANGE.
015300*    PERFORM CHANGE-ONE-FIELD
015400*        UNTIL WHICH-FIELD = ZERO.
015500     PERFORM CHANGE-ONE-FIELD.
015600
015700     PERFORM GET-STATE-RECORD.
015800
015900 GET-FIELD-TO-CHANGE.
016000     PERFORM DISPLAY-ALL-FIELDS.
016100     PERFORM ASK-WHICH-FIELD.
016200
016300 ASK-WHICH-FIELD.
016400*    PERFORM ACCEPT-WHICH-FIELD.
016500*    PERFORM RE-ACCEPT-WHICH-FIELD
016600*        UNTIL WHICH-FIELD NOT > 1.
016700     MOVE 1 TO WHICH-FIELD.
016800
016900*ACCEPT-WHICH-FIELD.
017000*    DISPLAY "ENTER THE NUMBER OF THE FIELD".
017100*    DISPLAY "TO CHANGE (1) OR 0 TO EXIT".
017200*    ACCEPT WHICH-FIELD.
017300*
017400*RE-ACCEPT-WHICH-FIELD.
017500*    DISPLAY "INVALID ENTRY".
017600*    PERFORM ACCEPT-WHICH-FIELD.
017700
017800 CHANGE-ONE-FIELD.
017900     PERFORM CHANGE-THIS-FIELD.
018000*    PERFORM GET-FIELD-TO-CHANGE.
018100
018200 CHANGE-THIS-FIELD.
018300     IF WHICH-FIELD = 1
018400         PERFORM ENTER-STATE-NAME.
018500
018600     PERFORM REWRITE-STATE-RECORD.
018700
018800*---------------------------------
018900* INQUIRE
019000*---------------------------------
019100 INQUIRE-MODE.
019200     MOVE "DISPLAY" TO THE-MODE.
019300     PERFORM GET-STATE-RECORD.
019400     PERFORM INQUIRE-RECORDS
019500        UNTIL STATE-CODE = "ZZ".
019600
019700 INQUIRE-RECORDS.
019800     PERFORM DISPLAY-ALL-FIELDS.
019900     PERFORM GET-STATE-RECORD.
020000
020100*---------------------------------
020200* DELETE
020300*---------------------------------
020400 DELETE-MODE.
020500     MOVE "DELETE" TO THE-MODE.
020600     PERFORM GET-STATE-RECORD.
020700     PERFORM DELETE-RECORDS
020800        UNTIL STATE-CODE = "ZZ".
020900
021000 DELETE-RECORDS.
021100     PERFORM DISPLAY-ALL-FIELDS.
021200
021300     PERFORM ASK-OK-TO-DELETE
021400     IF OK-TO-DELETE = "Y"
021500         PERFORM DELETE-STATE-RECORD.
021600
021700     PERFORM GET-STATE-RECORD.
021800
021900 ASK-OK-TO-DELETE.
022000     PERFORM ACCEPT-OK-TO-DELETE.
022100     PERFORM RE-ACCEPT-OK-TO-DELETE
022200        UNTIL OK-TO-DELETE = "Y" OR "N".
022300
022400 ACCEPT-OK-TO-DELETE.
022500     DISPLAY "DELETE THIS RECORD (Y/N)?".
022600     ACCEPT OK-TO-DELETE.
022700
022800     INSPECT OK-TO-DELETE
022900       CONVERTING LOWER-ALPHA
023000       TO         UPPER-ALPHA.
023100
023200 RE-ACCEPT-OK-TO-DELETE.
023300     DISPLAY "YOU MUST ENTER YES OR NO".
023400     PERFORM ACCEPT-OK-TO-DELETE.
023500
023600*---------------------------------
023700* PRINT
023800*---------------------------------
023900 PRINT-THE-RECORDS.
024000     CLOSE STATE-FILE.
024100     DISPLAY "REPORT IN PROGRESS".
024200     CALL "STCRPT02".
024300     OPEN I-O STATE-FILE.
024400
024500*---------------------------------
024600* Routines shared by all modes
024700*---------------------------------
024800 INIT-STATE-RECORD.
024900     MOVE SPACE TO STATE-RECORD.
025000
025100 ENTER-STATE-CODE.
025200     PERFORM ACCEPT-STATE-CODE.
025300     PERFORM RE-ACCEPT-STATE-CODE
025400         UNTIL STATE-CODE NOT = SPACE.
025500
025600 ACCEPT-STATE-CODE.
025700     DISPLAY " ".
025800     DISPLAY "ENTER STATE CODE OF THE STATE" .
025900     DISPLAY "TO " THE-MODE
026000               "(2 UPPER CASE CHARACTERS)".
026100     DISPLAY "ENTER ZZ TO STOP ENTRY".
026200     ACCEPT STATE-CODE.
026300
026400     INSPECT STATE-CODE
026500       CONVERTING LOWER-ALPHA
026600       TO         UPPER-ALPHA.
026700
026800 RE-ACCEPT-STATE-CODE.
026900     DISPLAY "STATE CODE MUST BE ENTERED".
027000     PERFORM ACCEPT-STATE-CODE.
027100
027200 GET-STATE-RECORD.
027300     PERFORM INIT-STATE-RECORD.
027400     PERFORM ENTER-STATE-CODE.
027500     MOVE "N" TO RECORD-FOUND.
027600     PERFORM FIND-STATE-RECORD
027700         UNTIL RECORD-FOUND = "Y" OR
027800               STATE-CODE = "ZZ".
027900
028000*---------------------------------
028100* Routines shared Add and Change
028200*---------------------------------
028300 FIND-STATE-RECORD.
028400     PERFORM READ-STATE-RECORD.
028500     IF RECORD-FOUND = "N"
028600         DISPLAY "RECORD NOT FOUND"
028700         PERFORM ENTER-STATE-CODE.
028800
028900 ENTER-STATE-NAME.
029000     PERFORM ACCEPT-STATE-NAME.
029100     PERFORM RE-ACCEPT-STATE-NAME
029200         UNTIL STATE-NAME NOT = SPACES.
029300
029400 ACCEPT-STATE-NAME.
029500     DISPLAY "ENTER STATE NAME".
029600     ACCEPT STATE-NAME.
029700
029800     INSPECT STATE-NAME
029900       CONVERTING LOWER-ALPHA
030000       TO         UPPER-ALPHA.
030100
030200 RE-ACCEPT-STATE-NAME.
030300     DISPLAY "STATE NAME MUST BE ENTERED".
030400     PERFORM ACCEPT-STATE-NAME.
030500
030600*---------------------------------
030700* Routines shared by Change,
030800* Inquire and Delete
030900*---------------------------------
031000 DISPLAY-ALL-FIELDS.
031100     DISPLAY " ".
031200     PERFORM DISPLAY-STATE-CODE.
031300     PERFORM DISPLAY-STATE-NAME.
031400     DISPLAY " ".
031500
031600 DISPLAY-STATE-CODE.
031700     DISPLAY "   STATE CODE: " STATE-CODE.
031800
031900 DISPLAY-STATE-NAME.
032000     DISPLAY "1. STATE NAME: " STATE-NAME.
032100
032200*---------------------------------
032300* File I-O Routines
032400*---------------------------------
032500 READ-STATE-RECORD.
032600     MOVE "Y" TO RECORD-FOUND.
032700     READ STATE-FILE RECORD
032800       INVALID KEY
032900          MOVE "N" TO RECORD-FOUND.
033000
033100*or  READ STATE-FILE RECORD WITH LOCK
033200*      INVALID KEY
033300*         MOVE "N" TO RECORD-FOUND.
033400
033500*or  READ STATE-FILE RECORD WITH HOLD
033600*      INVALID KEY
033700*         MOVE "N" TO RECORD-FOUND.
033800
033900 WRITE-STATE-RECORD.
034000     WRITE STATE-RECORD
034100         INVALID KEY
034200         DISPLAY "RECORD ALREADY ON FILE".
034300
034400 REWRITE-STATE-RECORD.
034500     REWRITE STATE-RECORD
034600         INVALID KEY
034700         DISPLAY "ERROR REWRITING STATE RECORD".
034800
034900 DELETE-STATE-RECORD.
035000     DELETE STATE-FILE RECORD
035100         INVALID KEY
035200         DISPLAY "ERROR DELETING STATE RECORD".
035300
