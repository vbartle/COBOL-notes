000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. VNBYNM02.
000300*---------------------------------
000400* Report on the Vendor File in
000500* alphabetical name order.
000600*---------------------------------
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
007500
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
009600 PROGRAM-EXIT.
009700     EXIT PROGRAM.
009800
009900 PROGRAM-DONE.
010000     STOP RUN.
010100
010200 OPENING-PROCEDURE.
010300     OPEN I-O VENDOR-FILE.
010400
010500     OPEN I-O STATE-FILE.
010600     PERFORM LOAD-STATE-TABLE.
010700     CLOSE STATE-FILE.
010800
010900     OPEN OUTPUT PRINTER-FILE.
011000
011100 LOAD-STATE-TABLE.
011200     PERFORM CLEAR-TABLE.
011300     SET STATE-INDEX TO 1.
011400     PERFORM READ-NEXT-STATE-RECORD.
011500     PERFORM LOAD-ONE-STATE-RECORD
011600         UNTIL STATE-FILE-AT-END = "Y" OR
011700               STATE-INDEX > 50.
011800
011900 CLEAR-TABLE.
012000     PERFORM CLEAR-ONE-TABLE-ROW
012100         VARYING STATE-INDEX FROM 1 BY 1
012200          UNTIL STATE-INDEX > 50.
012300
012400 CLEAR-ONE-TABLE-ROW.
012500     MOVE SPACE TO TABLE-STATE-RECORD(STATE-INDEX).
012600
012700 LOAD-ONE-STATE-RECORD.
012800     MOVE STATE-CODE TO TABLE-STATE-CODE(STATE-INDEX).
012900     MOVE STATE-NAME TO TABLE-STATE-NAME(STATE-INDEX).
013000
013100     PERFORM READ-NEXT-STATE-RECORD.
013200
013300     IF STATE-FILE-AT-END NOT = "Y"
013400         SET STATE-INDEX UP BY 1
013500         IF STATE-INDEX > 50
013600             DISPLAY "TABLE FULL".
013700
013800 CLOSING-PROCEDURE.
013900     CLOSE VENDOR-FILE.
014000     PERFORM END-LAST-PAGE.
014100     CLOSE PRINTER-FILE.
014200
014300 PRINT-VENDOR-FIELDS.
014400     IF LINE-COUNT > MAXIMUM-LINES
014500         PERFORM START-NEXT-PAGE.
014600     PERFORM PRINT-THE-RECORD.
014700     PERFORM READ-NEXT-RECORD.
014800
014900 PRINT-THE-RECORD.
015000     PERFORM PRINT-LINE-1.
015100     PERFORM PRINT-LINE-2.
015200     PERFORM PRINT-LINE-3.
015300     PERFORM PRINT-LINE-4.
015400     PERFORM LINE-FEED.
015500
015600 PRINT-LINE-1.
015700     MOVE SPACE TO DETAIL-LINE.
015800     MOVE VENDOR-NUMBER TO PRINT-NUMBER.
015900     MOVE VENDOR-NAME TO PRINT-NAME.
016000     MOVE VENDOR-CONTACT TO PRINT-CONTACT.
016100     MOVE DETAIL-LINE TO PRINTER-RECORD.
016200     PERFORM WRITE-TO-PRINTER.
016300
016400 PRINT-LINE-2.
016500     MOVE SPACE TO DETAIL-LINE.
016600     MOVE VENDOR-ADDRESS-1 TO PRINT-NAME.
016700     MOVE VENDOR-PHONE TO PRINT-CONTACT.
016800     MOVE DETAIL-LINE TO PRINTER-RECORD.
016900     PERFORM WRITE-TO-PRINTER.
017000
017100 PRINT-LINE-3.
017200     MOVE SPACE TO DETAIL-LINE.
017300     MOVE VENDOR-ADDRESS-2 TO PRINT-NAME.
017400     IF VENDOR-ADDRESS-2 NOT = SPACE
017500         MOVE DETAIL-LINE TO PRINTER-RECORD
017600         PERFORM WRITE-TO-PRINTER.
017700
017800 PRINT-LINE-4.
017900     MOVE SPACE TO CITY-STATE-LINE.
018000     MOVE VENDOR-CITY TO PRINT-CITY.
018100     MOVE VENDOR-STATE TO PRINT-STATE.
018200
018300     PERFORM LOOK-UP-STATE-CODE.
018400
018500     MOVE VENDOR-ZIP TO PRINT-ZIP.
018600     MOVE CITY-STATE-LINE TO PRINTER-RECORD.
018700     PERFORM WRITE-TO-PRINTER.
018800
018900 LOOK-UP-STATE-CODE.
019000     SET STATE-INDEX TO 1.
019100     SEARCH TABLE-STATE-RECORD
019200         AT END
019300          MOVE "***Not Found***" TO PRINT-STATE-NAME
019400         WHEN VENDOR-STATE = TABLE-STATE-CODE(STATE-INDEX)
019500          MOVE TABLE-STATE-NAME(STATE-INDEX)
019600            TO PRINT-STATE-NAME.
019700
019800     IF STATE-NAME = SPACE
019900          MOVE "*State is Blank*" TO PRINT-STATE-NAME.
020000
020100 READ-FIRST-RECORD.
020200     MOVE "N" TO FILE-AT-END.
020300     MOVE SPACE TO VENDOR-NAME.
020400     START VENDOR-FILE
020500        KEY NOT < VENDOR-NAME
020600         INVALID KEY MOVE "Y" TO FILE-AT-END.
020700
020800     IF FILE-AT-END NOT = "Y"
020900         PERFORM READ-NEXT-RECORD.
021000
021100 READ-NEXT-RECORD.
021200     READ VENDOR-FILE NEXT RECORD
021300         AT END MOVE "Y" TO FILE-AT-END.
021400
021500 WRITE-TO-PRINTER.
021600     WRITE PRINTER-RECORD BEFORE ADVANCING 1.
021700     ADD 1 TO LINE-COUNT.
021800
021900 LINE-FEED.
022000     MOVE SPACE TO PRINTER-RECORD.
022100     PERFORM WRITE-TO-PRINTER.
022200
022300 START-NEXT-PAGE.
022400     PERFORM END-LAST-PAGE.
022500     PERFORM START-NEW-PAGE.
022600
022700 START-NEW-PAGE.
022800     ADD 1 TO PAGE-NUMBER.
022900     MOVE PAGE-NUMBER TO PRINT-PAGE-NUMBER.
023000     MOVE TITLE-LINE TO PRINTER-RECORD.
023100     PERFORM WRITE-TO-PRINTER.
023200     PERFORM LINE-FEED.
023300     MOVE COLUMN-LINE TO PRINTER-RECORD.
023400     PERFORM WRITE-TO-PRINTER.
023500     PERFORM LINE-FEED.
023600
023700 END-LAST-PAGE.
023800     PERFORM FORM-FEED.
023900     MOVE ZERO TO LINE-COUNT.
024000
024100 FORM-FEED.
024200     MOVE SPACE TO PRINTER-RECORD.
024300     WRITE PRINTER-RECORD BEFORE ADVANCING PAGE.
024400
024500 READ-NEXT-STATE-RECORD.
024600     MOVE "N" TO STATE-FILE-AT-END.
024700     READ STATE-FILE NEXT RECORD
024800         AT END
024900         MOVE "Y" TO STATE-FILE-AT-END.
025000
