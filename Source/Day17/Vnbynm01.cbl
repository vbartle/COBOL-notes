000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. VNBYNM01.
000300*--------------------------------
000400* Report on the Vendor File in
000500* alphabetical name order.
000600*--------------------------------
000700 ENVIRONMENT DIVISION.
000800 INPUT-OUTPUT SECTION.
000900 FILE-CONTROL.
001000
001100     COPY "SLVND02.CBL".
001200
001300     COPY "SLSTATE.CBL".
001400
001500     SELECT PRINTER-FILE
001600         ASSIGN TO PRINTER
001700         ORGANIZATION IS LINE SEQUENTIAL.
001800
001900 DATA DIVISION.
002000 FILE SECTION.
002100
002200     COPY "FDVND04.CBL".
002300
002400     COPY "FDSTATE.CBL".
002500
002600 FD  PRINTER-FILE
002700     LABEL RECORDS ARE OMITTED.
002800 01  PRINTER-RECORD             PIC X(80).
002900
003000 WORKING-STORAGE SECTION.
003100
003200 01  DETAIL-LINE.
003300     05  PRINT-NUMBER      PIC 9(5).
003400     05  FILLER            PIC X     VALUE SPACE.
003500     05  PRINT-NAME        PIC X(30).
003600     05  FILLER            PIC X(15) VALUE SPACE.
003700     05  PRINT-CONTACT     PIC X(30).
003800
003900 01  CITY-STATE-LINE.
004000     05  FILLER            PIC X(6) VALUE SPACE.
004100     05  PRINT-CITY        PIC X(20).
004200     05  FILLER            PIC X VALUE SPACE.
004300     05  PRINT-STATE       PIC X(2).
004400     05  FILLER            PIC X VALUE SPACE.
004500     05  PRINT-STATE-NAME  PIC X(20).
004600     05  FILLER            PIC X(1) VALUE SPACE.
004700     05  PRINT-ZIP         PIC X(10).
004800
004900 01  COLUMN-LINE.
005000     05  FILLER         PIC X(2)  VALUE "NO".
005100     05  FILLER         PIC X(4) VALUE SPACE.
005200     05  FILLER         PIC X(12) VALUE "NAME-ADDRESS".
005300     05  FILLER         PIC X(33) VALUE SPACE.
005400     05  FILLER         PIC X(17) VALUE "CONTACT-PHONE-ZIP".
005500
005600 01  TITLE-LINE.
005700     05  FILLER              PIC X(20) VALUE SPACE.
005800     05  FILLER              PIC X(24)
005900         VALUE "VENDOR ALPHABETICAL LIST".
006000     05  FILLER              PIC X(11) VALUE SPACE.
006100     05  FILLER              PIC X(5) VALUE "PAGE:".
006200     05  FILLER              PIC X(1) VALUE SPACE.
006300     05  PRINT-PAGE-NUMBER PIC ZZZZ9.
006400
006500 77  FILE-AT-END             PIC X.
006600 77  STATE-FILE-AT-END       PIC X VALUE "N".
006700 77  LINE-COUNT              PIC 999 VALUE ZERO.
006800 77  PAGE-NUMBER             PIC 99999 VALUE ZERO.
006900 77  MAXIMUM-LINES           PIC 999 VALUE 55.
007000
007100 01  TABLE-STATE-RECORD OCCURS 50 TIMES
007200      INDEXED BY STATE-INDEX.
007300     05  TABLE-STATE-CODE          PIC XX.
007400     05  TABLE-STATE-NAME          PIC X(20).
007500 01  NUMBER-OF-STATES              PIC 99 VALUE 50.
007600 PROCEDURE DIVISION.
007700 PROGRAM-BEGIN.
007800
007900     PERFORM OPENING-PROCEDURE.
008000     MOVE ZEROES TO LINE-COUNT
008100                    PAGE-NUMBER.
008200
008300     PERFORM START-NEW-PAGE.
008400
008500     MOVE "N" TO FILE-AT-END.
008600     PERFORM READ-FIRST-RECORD.
008700     IF FILE-AT-END = "Y"
008800         MOVE "NO RECORDS FOUND" TO PRINTER-RECORD
008900         PERFORM WRITE-TO-PRINTER
009000     ELSE
009100         PERFORM PRINT-VENDOR-FIELDS
009200             UNTIL FILE-AT-END = "Y".
009300
009400     PERFORM CLOSING-PROCEDURE.
009500
009600 PROGRAM-DONE.
009700     STOP RUN.
009800
009900 OPENING-PROCEDURE.
010000     OPEN I-O VENDOR-FILE.
010100
010200     OPEN I-O STATE-FILE.
010300     PERFORM LOAD-STATE-TABLE.
010400     CLOSE STATE-FILE.
010500
010600     OPEN OUTPUT PRINTER-FILE.
010700
010800 LOAD-STATE-TABLE.
010900     PERFORM CLEAR-TABLE.
011000     SET STATE-INDEX TO 1.
011100     PERFORM READ-NEXT-STATE-RECORD.
011200     PERFORM LOAD-ONE-STATE-RECORD
011300         UNTIL STATE-FILE-AT-END = "Y" OR
011400               STATE-INDEX > NUMBER-OF-STATES.
011500
011600 CLEAR-TABLE.
011700     PERFORM CLEAR-ONE-TABLE-ROW
011800         VARYING STATE-INDEX FROM 1 BY 1
011900          UNTIL STATE-INDEX > NUMBER-OF-STATES.
012000
012100 CLEAR-ONE-TABLE-ROW.
012200     MOVE SPACE TO TABLE-STATE-RECORD(STATE-INDEX).
012300
012400 LOAD-ONE-STATE-RECORD.
012500     MOVE STATE-CODE TO TABLE-STATE-CODE(STATE-INDEX).
012600     MOVE STATE-NAME TO TABLE-STATE-NAME(STATE-INDEX).
012700
012800     PERFORM READ-NEXT-STATE-RECORD.
012900
013000     IF STATE-FILE-AT-END NOT = "Y"
013100         SET STATE-INDEX UP BY 1
013200         IF STATE-INDEX > NUMBER-OF-STATES
013300             DISPLAY "TABLE FULL".
013400
013500 CLOSING-PROCEDURE.
013600     CLOSE VENDOR-FILE.
013700     PERFORM END-LAST-PAGE.
013800     CLOSE PRINTER-FILE.
013900
014000 PRINT-VENDOR-FIELDS.
014100     IF LINE-COUNT > MAXIMUM-LINES
014200         PERFORM START-NEXT-PAGE.
014300     PERFORM PRINT-THE-RECORD.
014400     PERFORM READ-NEXT-RECORD.
014500
014600 PRINT-THE-RECORD.
014700     PERFORM PRINT-LINE-1.
014800     PERFORM PRINT-LINE-2.
014900     PERFORM PRINT-LINE-3.
015000     PERFORM PRINT-LINE-4.
015100     PERFORM LINE-FEED.
015200
015300 PRINT-LINE-1.
015400     MOVE SPACE TO DETAIL-LINE.
015500     MOVE VENDOR-NUMBER TO PRINT-NUMBER.
015600     MOVE VENDOR-NAME TO PRINT-NAME.
015700     MOVE VENDOR-CONTACT TO PRINT-CONTACT.
015800     MOVE DETAIL-LINE TO PRINTER-RECORD.
015900     PERFORM WRITE-TO-PRINTER.
016000
016100 PRINT-LINE-2.
016200     MOVE SPACE TO DETAIL-LINE.
016300     MOVE VENDOR-ADDRESS-1 TO PRINT-NAME.
016400     MOVE VENDOR-PHONE TO PRINT-CONTACT.
016500     MOVE DETAIL-LINE TO PRINTER-RECORD.
016600     PERFORM WRITE-TO-PRINTER.
016700
016800 PRINT-LINE-3.
016900     MOVE SPACE TO DETAIL-LINE.
017000     MOVE VENDOR-ADDRESS-2 TO PRINT-NAME.
017100     IF VENDOR-ADDRESS-2 NOT = SPACE
017200         MOVE DETAIL-LINE TO PRINTER-RECORD
017300         PERFORM WRITE-TO-PRINTER.
017400
017500 PRINT-LINE-4.
017600     MOVE SPACE TO CITY-STATE-LINE.
017700     MOVE VENDOR-CITY TO PRINT-CITY.
017800     MOVE VENDOR-STATE TO PRINT-STATE.
017900
018000     PERFORM LOOK-UP-STATE-CODE.
018100
018200     MOVE VENDOR-ZIP TO PRINT-ZIP.
018300     MOVE CITY-STATE-LINE TO PRINTER-RECORD.
018400     PERFORM WRITE-TO-PRINTER.
018500
018600 LOOK-UP-STATE-CODE.
018700     SET STATE-INDEX TO 1.
018800     SEARCH TABLE-STATE-RECORD
018900         AT END
019000          MOVE "***Not Found***" TO PRINT-STATE-NAME
019100         WHEN VENDOR-STATE = TABLE-STATE-CODE(STATE-INDEX)
019200          MOVE TABLE-STATE-NAME(STATE-INDEX)
019300            TO PRINT-STATE-NAME.
019400
019500     IF STATE-NAME = SPACE
019600          MOVE "*State is Blank*" TO PRINT-STATE-NAME.
019700
019800 READ-FIRST-RECORD.
019900     MOVE "N" TO FILE-AT-END.
020000     MOVE SPACE TO VENDOR-NAME.
020100     START VENDOR-FILE
020200        KEY NOT < VENDOR-NAME
020300         INVALID KEY MOVE "Y" TO FILE-AT-END.
020400
020500     IF FILE-AT-END NOT = "Y"
020600         PERFORM READ-NEXT-RECORD.
020700
020800 READ-NEXT-RECORD.
020900     READ VENDOR-FILE NEXT RECORD
021000         AT END MOVE "Y" TO FILE-AT-END.
021100
021200 WRITE-TO-PRINTER.
021300     WRITE PRINTER-RECORD BEFORE ADVANCING 1.
021400     ADD 1 TO LINE-COUNT.
021500
021600 LINE-FEED.
021700     MOVE SPACE TO PRINTER-RECORD.
021800     PERFORM WRITE-TO-PRINTER.
021900
022000 START-NEXT-PAGE.
022100     PERFORM END-LAST-PAGE.
022200     PERFORM START-NEW-PAGE.
022300
022400 START-NEW-PAGE.
022500     ADD 1 TO PAGE-NUMBER.
022600     MOVE PAGE-NUMBER TO PRINT-PAGE-NUMBER.
022700     MOVE TITLE-LINE TO PRINTER-RECORD.
022800     PERFORM WRITE-TO-PRINTER.
022900     PERFORM LINE-FEED.
023000     MOVE COLUMN-LINE TO PRINTER-RECORD.
023100     PERFORM WRITE-TO-PRINTER.
023200     PERFORM LINE-FEED.
023300
023400 END-LAST-PAGE.
023500     PERFORM FORM-FEED.
023600     MOVE ZERO TO LINE-COUNT.
023700
023800 FORM-FEED.
023900     MOVE SPACE TO PRINTER-RECORD.
024000     WRITE PRINTER-RECORD BEFORE ADVANCING PAGE.
024100
024200 READ-NEXT-STATE-RECORD.
024300     MOVE "N" TO STATE-FILE-AT-END.
024400     READ STATE-FILE NEXT RECORD
024500         AT END
024600         MOVE "Y" TO STATE-FILE-AT-END.
024700
