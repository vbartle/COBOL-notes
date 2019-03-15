000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. STCMNT05.
000300*---------------------------------
000400* Add, Change, Inquire and Delete
000500* for the State Codes File.
000600* Calls the state codes report
000700* Uses full screen IO
000800*---------------------------------
000900 ENVIRONMENT DIVISION.
001000 INPUT-OUTPUT SECTION.
001100 FILE-CONTROL.
001200
001300     COPY "SLSTATE.CBL".
001400
001500 DATA DIVISION.
001600 FILE SECTION.
001700
001800     COPY "FDSTATE.CBL".
001900
002000 WORKING-STORAGE SECTION.
002100
002200 77  MENU-PICK                    PIC 9 VALUE ZERO.
002300     88  MENU-PICK-IS-VALID       VALUES 0 THRU 5.
002400
002500 77  STATE-RECORD-FOUND           PIC X.
002600
002700 77  SCREEN-ERROR                 PIC X.
002800 77  ERROR-MESSAGE                PIC X(79) VALUE SPACE.
002900
003000 77  CONTINUE-MESSAGE             PIC X(40) VALUE SPACE.
003100 77  OK-TO-CONTINUE               PIC X.
003200
003300 01  FOOTER-FIELD.
003400     05  FOOTER-1-FIELD           PIC X(40) VALUE SPACE.
003500     05  FOOTER-2-FIELD           PIC X(39) VALUE SPACE.
003600
003700     COPY "WSCASE01.CBL".
003800
003900 SCREEN SECTION.
004000 01  MENU-SCREEN.
004100     05  BLANK SCREEN.
004200     05  LINE  2 COLUMN 30 VALUE "STATE CODE MAINTENANCE".
004300     05  LINE  6 COLUMN 20 VALUE "PLEASE SELECT:".
004400     05  LINE  8 COLUMN 25 VALUE "1. ADD RECORDS".
004500     05  LINE  9 COLUMN 25 VALUE "2. CHANGE A RECORD".
004600     05  LINE 10 COLUMN 25 VALUE "3. LOOK UP A RECORD".
004700     05  LINE 11 COLUMN 25 VALUE "4. DELETE A RECORD".
004800     05  LINE 12 COLUMN 25 VALUE "5. PRINT RECORDS".
004900     05  LINE 14 COLUMN 25 VALUE "0. EXIT".
005000     05  LINE 20 COLUMN  1 VALUE "YOUR SELECTION? ".
005100     05  LINE 20 COLUMN 17 PIC Z USING MENU-PICK.
005200     05  LINE 24 COLUMN  1 PIC X(79) FROM ERROR-MESSAGE.
005300
005400 01  KEY-SCREEN.
005500     05  BLANK SCREEN.
005600     05  LINE  8 COLUMN 20 VALUE "STATE CODE:".
005700     05  LINE  8 COLUMN 40 PIC XX USING STATE-CODE.
005800     05  LINE 22 COLUMN  1 PIC X(79) FROM FOOTER-FIELD.
005900     05  LINE 24 COLUMN  1 PIC X(79) FROM ERROR-MESSAGE.
006000
006100 01  ENTRY-SCREEN.
006200     05  BLANK SCREEN.
006300     05  LINE  8 COLUMN 20 VALUE "STATE CODE:".
006400     05  LINE  8 COLUMN 40 PIC XX FROM STATE-CODE.
006500     05  LINE 10 COLUMN 20 VALUE "STATE NAME: ".
006600     05  LINE 10 COLUMN 40 PIC X(20) USING STATE-NAME.
006700     05  LINE 22 COLUMN  1 PIC X(79) FROM FOOTER-FIELD.
006800     05  LINE 23 COLUMN  1 PIC X(40) FROM CONTINUE-MESSAGE.
006900     05  LINE 23 COLUMN 41 PIC X USING OK-TO-CONTINUE.
007000     05  LINE 24 COLUMN  1 PIC X(79) FROM ERROR-MESSAGE.
007100
007200 01  DISPLAY-SCREEN.
007300     05  BLANK SCREEN.
007400     05  LINE  8 COLUMN 20 VALUE "STATE CODE:".
007500     05  LINE  8 COLUMN 40 PIC XX FROM STATE-CODE.
007600     05  LINE 10 COLUMN 20 VALUE "STATE NAME: ".
007700     05  LINE 10 COLUMN 40 PIC X(20) FROM STATE-NAME.
007800     05  LINE 23 COLUMN  1 PIC X(40) FROM CONTINUE-MESSAGE.
007900     05  LINE 23 COLUMN 41 PIC X USING OK-TO-CONTINUE.
008000     05  LINE 24 COLUMN  1 PIC X(79) FROM ERROR-MESSAGE.
008100
008200 PROCEDURE DIVISION.
008300 PROGRAM-BEGIN.
008400     PERFORM OPENING-PROCEDURE.
008500     PERFORM MAIN-PROCESS.
008600     PERFORM CLOSING-PROCEDURE.
008700
008800 PROGRAM-EXIT.
008900     EXIT PROGRAM.
009000
009100 PROGRAM-DONE.
009200     STOP RUN.
009300
009400 OPENING-PROCEDURE.
009500     OPEN I-O STATE-FILE.
009600
009700 CLOSING-PROCEDURE.
009800     CLOSE STATE-FILE.
009900
010000 MAIN-PROCESS.
010100     PERFORM GET-MENU-PICK.
010200     PERFORM MAINTAIN-THE-FILE
010300         UNTIL MENU-PICK = 0.
010400
010500*---------------------------------
010600* MENU
010700*---------------------------------
010800 GET-MENU-PICK.
010900     PERFORM INITIALIZE-MENU-PICK.
011000     PERFORM DISPLAY-ACCEPT-MENU.
011100     PERFORM RE-DISPLAY-ACCEPT-MENU
011200         UNTIL MENU-PICK-IS-VALID.
011300
011400 INITIALIZE-MENU-PICK.
011500     MOVE 0 TO MENU-PICK.
011600
011700 DISPLAY-ACCEPT-MENU.
011800     DISPLAY MENU-SCREEN.
011900     ACCEPT MENU-SCREEN.
012000     MOVE SPACE TO ERROR-MESSAGE.
012100
012200 RE-DISPLAY-ACCEPT-MENU.
012300     MOVE "INVALID SELECTION - PLEASE RE-TRY."
012400           TO ERROR-MESSAGE.
012500     PERFORM DISPLAY-ACCEPT-MENU.
012600
012700 MAINTAIN-THE-FILE.
012800     PERFORM DO-THE-PICK.
012900     PERFORM GET-MENU-PICK.
013000
013100 DO-THE-PICK.
013200     IF MENU-PICK = 1
013300         PERFORM ADD-MODE
013400     ELSE
013500     IF MENU-PICK = 2
013600         PERFORM CHANGE-MODE
013700     ELSE
013800     IF MENU-PICK = 3
013900         PERFORM INQUIRE-MODE
014000     ELSE
014100     IF MENU-PICK = 4
014200         PERFORM DELETE-MODE
014300     ELSE
014400     IF MENU-PICK = 5
014500         PERFORM PRINT-STATE-REPORT.
014600
014700*---------------------------------
014800* ADD
014900*---------------------------------
015000 ADD-MODE.
015100     PERFORM INITIALIZE-ADD-MODE.
015200     PERFORM GET-NEW-RECORD-KEY.
015300     PERFORM ADD-RECORDS
015400        UNTIL STATE-CODE = "ZZ".
015500
015600 INITIALIZE-ADD-MODE.
015700     MOVE "ENTER THE STATE CODE TO ADD"
015800       TO FOOTER-1-FIELD.
015900
016000 GET-NEW-RECORD-KEY.
016100     PERFORM ACCEPT-NEW-RECORD-KEY.
016200     PERFORM RE-ACCEPT-NEW-RECORD-KEY
016300        UNTIL STATE-CODE = "ZZ"
016400           OR STATE-RECORD-FOUND = "N".
016500
016600 ACCEPT-NEW-RECORD-KEY.
016700     PERFORM INITIALIZE-STATE-FIELDS.
016800     PERFORM ENTER-STATE-CODE.
016900     PERFORM ENTER-STATE-CODE
017000         UNTIL STATE-CODE NOT = SPACE.
017100     IF STATE-CODE NOT = "ZZ"
017200         PERFORM READ-STATE-RECORD.
017300
017400 RE-ACCEPT-NEW-RECORD-KEY.
017500     MOVE "RECORD ALREADY ON FILE" TO ERROR-MESSAGE.
017600     PERFORM ACCEPT-NEW-RECORD-KEY.
017700
017800 ADD-RECORDS.
017900     PERFORM INITIALIZE-TO-ADD-FIELDS.
018000     PERFORM ENTER-REMAINING-FIELDS.
018100     IF OK-TO-CONTINUE = "Y"
018200         PERFORM WRITE-STATE-RECORD.
018300     PERFORM GET-NEW-RECORD-KEY.
018400
018500 INITIALIZE-TO-ADD-FIELDS.
018600     MOVE "ADD NEW FIELDS" TO FOOTER-FIELD.
018700     MOVE "CONTINUE WITH ADDITIONS (Y/N)?"
018800         TO CONTINUE-MESSAGE.
018900     MOVE "Y" TO OK-TO-CONTINUE.
019000
019100*---------------------------------
019200* CHANGE
019300*---------------------------------
019400 CHANGE-MODE.
019500     PERFORM INITIALIZE-CHANGE-MODE.
019600     PERFORM GET-EXISTING-RECORD.
019700     PERFORM CHANGE-RECORDS
019800        UNTIL STATE-CODE = "ZZ".
019900
020000 INITIALIZE-CHANGE-MODE.
020100     MOVE "ENTER THE STATE CODE TO CHANGE"
020200        TO FOOTER-1-FIELD.
020300
020400 CHANGE-RECORDS.
020500     PERFORM INITIALIZE-TO-CHANGE-FIELDS.
020600     PERFORM ENTER-REMAINING-FIELDS.
020700     IF OK-TO-CONTINUE = "Y"
020800         PERFORM REWRITE-STATE-RECORD.
020900     PERFORM GET-EXISTING-RECORD.
021000
021100 INITIALIZE-TO-CHANGE-FIELDS.
021200     MOVE "CHANGE FIELDS" TO FOOTER-FIELD.
021300     MOVE "CONTINUE WITH CHANGES (Y/N)?"
021400        TO CONTINUE-MESSAGE.
021500     MOVE "Y" TO OK-TO-CONTINUE.
021600
021700*---------------------------------
021800* INQUIRE
021900*---------------------------------
022000 INQUIRE-MODE.
022100     PERFORM INITIALIZE-INQUIRE-MODE.
022200     PERFORM GET-EXISTING-RECORD.
022300     PERFORM INQUIRE-RECORDS
022400        UNTIL STATE-CODE = "ZZ".
022500
022600 INITIALIZE-INQUIRE-MODE.
022700     MOVE "ENTER THE STATE CODE TO DISPLAY"
022800        TO FOOTER-1-FIELD.
022900
023000 INQUIRE-RECORDS.
023100     PERFORM INITIALIZE-TO-INQUIRE.
023200     PERFORM DISPLAY-ACCEPT-ALL-FIELDS.
023300     PERFORM GET-EXISTING-RECORD.
023400
023500 INITIALIZE-TO-INQUIRE.
023600     MOVE "PRESS ENTER TO CONTINUE" TO CONTINUE-MESSAGE.
023700     MOVE SPACE TO OK-TO-CONTINUE.
023800
023900*---------------------------------
024000* DELETE
024100*---------------------------------
024200 DELETE-MODE.
024300     PERFORM INITIALIZE-DELETE-MODE.
024400     PERFORM GET-EXISTING-RECORD.
024500     PERFORM DELETE-RECORDS
024600        UNTIL STATE-CODE = "ZZ".
024700
024800 INITIALIZE-DELETE-MODE.
024900     MOVE "ENTER THE STATE CODE TO DELETE"
025000       TO FOOTER-1-FIELD.
025100
025200 DELETE-RECORDS.
025300     PERFORM INITIALIZE-TO-DELETE-RECORD.
025400     PERFORM ASK-OK-TO-DELETE.
025500     IF OK-TO-CONTINUE = "Y"
025600         PERFORM DELETE-STATE-RECORD.
025700     PERFORM GET-EXISTING-RECORD.
025800
025900 INITIALIZE-TO-DELETE-RECORD.
026000     MOVE "OK TO DELETE(Y/N)?" TO CONTINUE-MESSAGE.
026100     MOVE "N" TO OK-TO-CONTINUE.
026200
026300 ASK-OK-TO-DELETE.
026400     PERFORM DISPLAY-ACCEPT-ALL-FIELDS.
026500     PERFORM RE-DISPLAY-ACCEPT-ALL-FIELDS
026600        UNTIL OK-TO-CONTINUE = "Y" OR "N".
026700
026800 RE-DISPLAY-ACCEPT-ALL-FIELDS.
026900     MOVE "YOU MUST ENTER YES OR NO"
027000         TO ERROR-MESSAGE.
027100     PERFORM DISPLAY-ACCEPT-ALL-FIELDS.
027200
027300*---------------------------------
027400* Routines shared by all modes
027500*---------------------------------
027600 INITIALIZE-STATE-FIELDS.
027700     MOVE SPACE TO STATE-RECORD.
027800
027900 ENTER-STATE-CODE.
028000     MOVE "ENTER 'ZZ' TO QUIT" TO FOOTER-2-FIELD.
028100     DISPLAY KEY-SCREEN.
028200     ACCEPT KEY-SCREEN.
028300     MOVE SPACE TO ERROR-MESSAGE.
028400
028500     INSPECT STATE-CODE
028600         CONVERTING LOWER-ALPHA
028700         TO         UPPER-ALPHA.
028800
028900     IF STATE-CODE = SPACE
029000         MOVE "YOU MUST ENTER STATE CODE"
029100           TO ERROR-MESSAGE.
029200
029300*---------------------------------
029400* Routines shared Add and Change
029500*---------------------------------
029600 ENTER-REMAINING-FIELDS.
029700     PERFORM DISPLAY-ACCEPT-ENTRY-SCREEN.
029800     PERFORM DISPLAY-ACCEPT-ENTRY-SCREEN
029900         UNTIL SCREEN-ERROR = "N"
030000            OR OK-TO-CONTINUE = "N".
030100
030200 DISPLAY-ACCEPT-ENTRY-SCREEN.
030300     DISPLAY ENTRY-SCREEN.
030400     ACCEPT ENTRY-SCREEN.
030500     MOVE SPACE TO ERROR-MESSAGE.
030600
030700     INSPECT OK-TO-CONTINUE
030800      CONVERTING LOWER-ALPHA TO UPPER-ALPHA.
030900
031000     IF OK-TO-CONTINUE = "Y"
031100         PERFORM EDIT-CHECK-FIELDS.
031200
031300 EDIT-CHECK-FIELDS.
031400     MOVE "N" TO SCREEN-ERROR.
031500     PERFORM EDIT-CHECK-STATE-NAME.
031600
031700 EDIT-CHECK-STATE-NAME.
031800     INSPECT STATE-NAME
031900         CONVERTING LOWER-ALPHA
032000         TO         UPPER-ALPHA.
032100
032200     IF STATE-NAME = SPACES
032300         MOVE "Y" TO SCREEN-ERROR
032400         MOVE "STATE NAME MUST BE ENTERED"
032500            TO ERROR-MESSAGE.
032600
032700*---------------------------------
032800* Routines shared by Change,
032900* Inquire and Delete
033000*---------------------------------
033100 GET-EXISTING-RECORD.
033200     PERFORM INITIALIZE-STATE-FIELDS.
033300     PERFORM ACCEPT-EXISTING-KEY.
033400     PERFORM RE-ACCEPT-EXISTING-KEY
033500         UNTIL STATE-RECORD-FOUND = "Y" OR
033600               STATE-CODE = "ZZ".
033700
033800 ACCEPT-EXISTING-KEY.
033900     PERFORM ENTER-STATE-CODE.
034000     PERFORM ENTER-STATE-CODE
034100         UNTIL STATE-CODE NOT = SPACE.
034200     IF STATE-CODE NOT = "ZZ"
034300         PERFORM READ-STATE-RECORD.
034400
034500 RE-ACCEPT-EXISTING-KEY.
034600     MOVE "RECORD NOT FOUND" TO ERROR-MESSAGE.
034700     PERFORM ACCEPT-EXISTING-KEY.
034800
034900*---------------------------------
035000* Routines shared by delete and inquire
035100*---------------------------------
035200 DISPLAY-ACCEPT-ALL-FIELDS.
035300     DISPLAY DISPLAY-SCREEN.
035400     ACCEPT DISPLAY-SCREEN.
035500     MOVE SPACE TO ERROR-MESSAGE.
035600     INSPECT OK-TO-CONTINUE
035700      CONVERTING LOWER-ALPHA TO UPPER-ALPHA.
035800
035900*---------------------------------
036000* File I-O Routines
036100*---------------------------------
036200 WRITE-STATE-RECORD.
036300     WRITE STATE-RECORD
036400         INVALID KEY
036500         DISPLAY "RECORD ALREADY ON FILE".
036600
036700 REWRITE-STATE-RECORD.
036800     REWRITE STATE-RECORD
036900         INVALID KEY
037000         DISPLAY "ERROR REWRITING STATE RECORD".
037100
037200 DELETE-STATE-RECORD.
037300     DELETE STATE-FILE RECORD
037400         INVALID KEY
037500         DISPLAY "ERROR DELETING STATE RECORD".
037600
037700 READ-STATE-RECORD.
037800     MOVE "Y" TO STATE-RECORD-FOUND.
037900     READ STATE-FILE RECORD
038000       INVALID KEY
038100          MOVE "N" TO STATE-RECORD-FOUND.
038200
038300*---------------------------------
038400* CALLS TO OTHER PROGRAMS
038500*---------------------------------
038600
038700*---------------------------------
038800* PRINT
038900*---------------------------------
039000 PRINT-STATE-REPORT.
039100     PERFORM CLOSING-PROCEDURE.
039200     DISPLAY "REPORT IN PROGRESS".
039300     CALL "STCRPT02".
039400     PERFORM OPENING-PROCEDURE.
039500
