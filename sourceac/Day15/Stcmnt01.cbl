000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. STCMNT01.
000300*---------------------------------
000400* Add, Change, Inquire and Delete
000500* for the State Code.
000600*---------------------------------
000700 ENVIRONMENT DIVISION.
000800 INPUT-OUTPUT SECTION.
000900 FILE-CONTROL.
001000
001100     COPY "SLSTATE.CBL".
001200
001300 DATA DIVISION.
001400 FILE SECTION.
001500
001600     COPY "FDSTATE.CBL".
001700
001800 WORKING-STORAGE SECTION.
001900
002000 77  MENU-PICK                    PIC 9.
002100     88  MENU-PICK-IS-VALID       VALUES 0 THRU 4.
002200
002300 77  THE-MODE                     PIC X(7).
002400 77  OK-TO-DELETE                 PIC X.
002500 77  RECORD-FOUND                 PIC X.
002600 77  WHICH-FIELD                  PIC 9.
002700
002800
002900
003000
003100
003200
003300 PROCEDURE DIVISION.
003400 PROGRAM-BEGIN.
003500     PERFORM OPENING-PROCEDURE.
003600     PERFORM MAIN-PROCESS.
003700     PERFORM CLOSING-PROCEDURE.
003800
003900 PROGRAM-DONE.
004000     ACCEPT OMITTED. STOP RUN.
004100
004200 OPENING-PROCEDURE.
004300     OPEN I-O STATE-FILE.
004400
004500 CLOSING-PROCEDURE.
004600     CLOSE STATE-FILE.
004700
004800
004900 MAIN-PROCESS.
005000     PERFORM GET-MENU-PICK.
005100     PERFORM MAINTAIN-THE-FILE
005200         UNTIL MENU-PICK = 0.
005300
005400*---------------------------------
005500* MENU
005600*---------------------------------
005700 GET-MENU-PICK.
005800     PERFORM DISPLAY-THE-MENU.
005900     PERFORM ACCEPT-MENU-PICK.
006000     PERFORM RE-ACCEPT-MENU-PICK
006100         UNTIL MENU-PICK-IS-VALID.
006200
006300 DISPLAY-THE-MENU.
006400     PERFORM CLEAR-SCREEN.
006500     DISPLAY "    PLEASE SELECT:".
006600     DISPLAY " ".
006700     DISPLAY "          1.  ADD RECORDS".
006800     DISPLAY "          2.  CHANGE A RECORD".
006900     DISPLAY "          3.  LOOK UP A RECORD".
007000     DISPLAY "          4.  DELETE A RECORD".
007100     DISPLAY " ".
007200     DISPLAY "          0.  EXIT".
007300     PERFORM SCROLL-LINE 8 TIMES.
007400
007500 ACCEPT-MENU-PICK.
007600     DISPLAY "YOUR CHOICE (0-4)?".
007700     ACCEPT MENU-PICK.
007800
007900 RE-ACCEPT-MENU-PICK.
008000     DISPLAY "INVALID SELECTION - PLEASE RE-TRY.".
008100     PERFORM ACCEPT-MENU-PICK.
008200
008300 CLEAR-SCREEN.
008400     PERFORM SCROLL-LINE 25 TIMES.
008500
008600 SCROLL-LINE.
008700     DISPLAY " ".
008800
008900 MAINTAIN-THE-FILE.
009000     PERFORM DO-THE-PICK.
009100     PERFORM GET-MENU-PICK.
009200
009300 DO-THE-PICK.
009400     IF MENU-PICK = 1
009500         PERFORM ADD-MODE
009600     ELSE
009700     IF MENU-PICK = 2
009800         PERFORM CHANGE-MODE
009900     ELSE
010000     IF MENU-PICK = 3
010100         PERFORM INQUIRE-MODE
010200     ELSE
010300     IF MENU-PICK = 4
010400         PERFORM DELETE-MODE.
010500
010600*---------------------------------
010700* ADD
010800*---------------------------------
010900 ADD-MODE.
011000     MOVE "ADD" TO THE-MODE.
011100     PERFORM GET-NEW-STATE-CODE.
011200     PERFORM ADD-RECORDS
011300        UNTIL STATE-CODE = "ZZ".
011400
011500 GET-NEW-STATE-CODE.
011600     PERFORM INIT-STATE-RECORD.
011700     PERFORM ENTER-STATE-CODE.
011800     MOVE "Y" TO RECORD-FOUND.
011900     PERFORM FIND-NEW-STATE-RECORD
012000         UNTIL RECORD-FOUND = "N" OR
012100               STATE-CODE = "ZZ".
012200
012300 FIND-NEW-STATE-RECORD.
012400     PERFORM READ-STATE-RECORD.
012500     IF RECORD-FOUND = "Y"
012600         DISPLAY "RECORD ALREADY ON FILE"
012700         PERFORM ENTER-STATE-CODE.
012800
012900 ADD-RECORDS.
013000     PERFORM ENTER-REMAINING-FIELDS.
013100     PERFORM WRITE-STATE-RECORD.
013200     PERFORM GET-NEW-STATE-CODE.
013300
013400 ENTER-REMAINING-FIELDS.
013500     PERFORM ENTER-STATE-NAME.
013600
013700*---------------------------------
013800* CHANGE
013900*---------------------------------
014000 CHANGE-MODE.
014100     MOVE "CHANGE" TO THE-MODE.
014200     PERFORM GET-STATE-RECORD.
014300     PERFORM CHANGE-RECORDS
014400        UNTIL STATE-CODE = "ZZ".
014500
014600 CHANGE-RECORDS.
014700     PERFORM GET-FIELD-TO-CHANGE.
014800     PERFORM CHANGE-ONE-FIELD
014900         UNTIL WHICH-FIELD = ZERO.
015000
015100
015200     PERFORM GET-STATE-RECORD.
015300
015400 GET-FIELD-TO-CHANGE.
015500     PERFORM DISPLAY-ALL-FIELDS.
015600     PERFORM ASK-WHICH-FIELD.
015700
015800 ASK-WHICH-FIELD.
015900     PERFORM ACCEPT-WHICH-FIELD.
016000     PERFORM RE-ACCEPT-WHICH-FIELD
016100         UNTIL WHICH-FIELD NOT > 1.
016200
016300
016400 ACCEPT-WHICH-FIELD.
016500     DISPLAY "ENTER THE NUMBER OF THE FIELD".
016600     DISPLAY "TO CHANGE (1) OR 0 TO EXIT".
016700     ACCEPT WHICH-FIELD.
016800
016900 RE-ACCEPT-WHICH-FIELD.
017000     DISPLAY "INVALID ENTRY".
017100     PERFORM ACCEPT-WHICH-FIELD.
017200
017300 CHANGE-ONE-FIELD.
017400     PERFORM CHANGE-THIS-FIELD.
017500     PERFORM GET-FIELD-TO-CHANGE.
017600
017700 CHANGE-THIS-FIELD.
017800     IF WHICH-FIELD = 1
017900         PERFORM ENTER-STATE-NAME.
018000
018100     PERFORM REWRITE-STATE-RECORD.
018200
018300*---------------------------------
018400* INQUIRE
018500*---------------------------------
018600 INQUIRE-MODE.
018700     MOVE "DISPLAY" TO THE-MODE.
018800     PERFORM GET-STATE-RECORD.
018900     PERFORM INQUIRE-RECORDS
019000        UNTIL STATE-CODE = "ZZ".
019100
019200 INQUIRE-RECORDS.
019300     PERFORM DISPLAY-ALL-FIELDS.
019400     PERFORM GET-STATE-RECORD.
019500
019600*---------------------------------
019700* DELETE
019800*---------------------------------
019900 DELETE-MODE.
020000     MOVE "DELETE" TO THE-MODE.
020100     PERFORM GET-STATE-RECORD.
020200     PERFORM DELETE-RECORDS
020300        UNTIL STATE-CODE = "ZZ".
020400
020500 DELETE-RECORDS.
020600     PERFORM DISPLAY-ALL-FIELDS.
020700
020800     PERFORM ASK-OK-TO-DELETE
020900     IF OK-TO-DELETE = "Y"
021000         PERFORM DELETE-STATE-RECORD.
021100
021200     PERFORM GET-STATE-RECORD.
021300
021400 ASK-OK-TO-DELETE.
021500     PERFORM ACCEPT-OK-TO-DELETE.
021600     PERFORM RE-ACCEPT-OK-TO-DELETE
021700        UNTIL OK-TO-DELETE = "Y" OR "N".
021800
021900 ACCEPT-OK-TO-DELETE.
022000     DISPLAY "DELETE THIS RECORD (Y/N)?".
022100     ACCEPT OK-TO-DELETE.
022200     IF OK-TO-DELETE = "y"
022300         MOVE "Y" TO OK-TO-DELETE.
022400     IF OK-TO-DELETE = "n"
022500         MOVE "N" TO OK-TO-DELETE.
022600
022700 RE-ACCEPT-OK-TO-DELETE.
022800     DISPLAY "YOU MUST ENTER YES OR NO".
022900     PERFORM ACCEPT-OK-TO-DELETE.
023000
023100*---------------------------------
023200* Routines shared by all modes
023300*---------------------------------
023400 INIT-STATE-RECORD.
023500     MOVE SPACE TO STATE-RECORD.
023600
023700 ENTER-STATE-CODE.
023800     PERFORM ACCEPT-STATE-CODE.
023900     PERFORM RE-ACCEPT-STATE-CODE
024000         UNTIL STATE-CODE NOT = SPACE.
024100
024200 ACCEPT-STATE-CODE.
024300     DISPLAY " ".
024400     DISPLAY "ENTER STATE CODE OF THE STATE" .
024500     DISPLAY "TO " THE-MODE
024600               "(2 UPPER CASE CHARACTERS)".
024700     DISPLAY "ENTER ZZ TO STOP ENTRY".
024800     ACCEPT STATE-CODE.
024900
025000
025100
025200
025300
025400 RE-ACCEPT-STATE-CODE.
025500     DISPLAY "STATE CODE MUST BE ENTERED".
025600     PERFORM ACCEPT-STATE-CODE.
025700
025800 GET-STATE-RECORD.
025900     PERFORM INIT-STATE-RECORD.
026000     PERFORM ENTER-STATE-CODE.
026100     MOVE "N" TO RECORD-FOUND.
026200     PERFORM FIND-STATE-RECORD
026300         UNTIL RECORD-FOUND = "Y" OR
026400               STATE-CODE = "ZZ".
026500
026600*---------------------------------
026700* Routines shared Add and Change
026800*---------------------------------
026900 FIND-STATE-RECORD.
027000     PERFORM READ-STATE-RECORD.
027100     IF RECORD-FOUND = "N"
027200         DISPLAY "RECORD NOT FOUND"
027300         PERFORM ENTER-STATE-CODE.
027400
027500 ENTER-STATE-NAME.
027600     PERFORM ACCEPT-STATE-NAME.
027700     PERFORM RE-ACCEPT-STATE-NAME
027800         UNTIL STATE-NAME NOT = SPACES.
027900
028000 ACCEPT-STATE-NAME.
028100     DISPLAY "ENTER STATE NAME".
028200     ACCEPT STATE-NAME.
028300
028400
028500
028600
028700
028800 RE-ACCEPT-STATE-NAME.
028900     DISPLAY "STATE NAME MUST BE ENTERED".
029000     PERFORM ACCEPT-STATE-NAME.
029100
029200*---------------------------------
029300* Routines shared by Change,
029400* Inquire and Delete
029500*---------------------------------
029600 DISPLAY-ALL-FIELDS.
029700     DISPLAY " ".
029800     PERFORM DISPLAY-STATE-CODE.
029900     PERFORM DISPLAY-STATE-NAME.
030000     DISPLAY " ".
030100
030200 DISPLAY-STATE-CODE.
030300     DISPLAY "   STATE CODE: " STATE-CODE.
030400
030500 DISPLAY-STATE-NAME.
030600     DISPLAY "1. STATE NAME: " STATE-NAME.
030700
030800*---------------------------------
030900* File I-O Routines
031000*---------------------------------
031100 READ-STATE-RECORD.
031200     MOVE "Y" TO RECORD-FOUND.
031300     READ STATE-FILE RECORD
031400       INVALID KEY
031500          MOVE "N" TO RECORD-FOUND.
031600
031700*or  READ STATE-FILE RECORD WITH LOCK
031800*      INVALID KEY
031900*         MOVE "N" TO RECORD-FOUND.
032000
032100*or  READ STATE-FILE RECORD WITH HOLD
032200*      INVALID KEY
032300*         MOVE "N" TO RECORD-FOUND.
032400
032500 WRITE-STATE-RECORD.
032600     WRITE STATE-RECORD
032700         INVALID KEY
032800         DISPLAY "RECORD ALREADY ON FILE".
032900
033000 REWRITE-STATE-RECORD.
033100     REWRITE STATE-RECORD
033200         INVALID KEY
033300         DISPLAY "ERROR REWRITING STATE RECORD".
033400
033500 DELETE-STATE-RECORD.
033600     DELETE STATE-FILE RECORD
033700         INVALID KEY
033800         DISPLAY "ERROR DELETING STATE RECORD".
033900
