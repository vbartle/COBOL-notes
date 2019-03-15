000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. SLSRPT04.
000300*---------------------------------
000400* Print test sales data
000500*---------------------------------
000600 ENVIRONMENT DIVISION.
000700 INPUT-OUTPUT SECTION.
000800 FILE-CONTROL.
000900
001000*---------------------------------
001100* SLSALES.CBL
001200*---------------------------------
001300     SELECT SALES-FILE
001400         ASSIGN TO "SALES"
001500         ORGANIZATION IS SEQUENTIAL.
001600
001700     SELECT WORK-FILE
001800         ASSIGN TO "WORK"
001900         ORGANIZATION IS SEQUENTIAL.
002000
002100     SELECT SORT-FILE
002200         ASSIGN TO "SORT".
002300
002400     SELECT PRINTER-FILE
002500         ASSIGN TO PRINTER
002600         ORGANIZATION IS LINE SEQUENTIAL.
002700
002800 DATA DIVISION.
002900 FILE SECTION.
003000
003100*---------------------------------
003200* FDSALES.CBL
003300* Temporary daily sales file.
003400*---------------------------------
003500 FD  SALES-FILE
003600     LABEL RECORDS ARE STANDARD.
003700 01  SALES-RECORD.
003800     05  SALES-STORE              PIC 9(2).
003900     05  SALES-DIVISION           PIC 9(2).
004000     05  SALES-DEPARTMENT         PIC 9(2).
004100     05  SALES-CATEGORY           PIC 9(2).
004200     05  SALES-AMOUNT             PIC S9(6)V99.
004300
004400 FD  WORK-FILE
004500     LABEL RECORDS ARE STANDARD.
004600 01  WORK-RECORD.
004700     05  WORK-STORE              PIC 9(2).
004800     05  WORK-DIVISION           PIC 9(2).
004900     05  WORK-DEPARTMENT         PIC 9(2).
005000     05  WORK-CATEGORY           PIC 9(2).
005100     05  WORK-AMOUNT             PIC S9(6)V99.
005200
005300 SD  SORT-FILE.
005400     
005500 01  SORT-RECORD.
005600     05  SORT-STORE              PIC 9(2).
005700     05  SORT-DIVISION           PIC 9(2).
005800     05  SORT-DEPARTMENT         PIC 9(2).
005900     05  SORT-CATEGORY           PIC 9(2).
006000     05  SORT-AMOUNT             PIC S9(6)V99.
006100
006200 FD  PRINTER-FILE
006300     LABEL RECORDS ARE OMITTED.
006400 01  PRINTER-RECORD              PIC X(80).
006500
006600 WORKING-STORAGE SECTION.
006700
006800 01  THE-DIVISIONS.
006900     05  FILLER       PIC 99 VALUE 01.
007000     05  FILLER       PIC X(15) VALUE "ATHLETICS".
007100     05  FILLER       PIC 99 VALUE 02.
007200     05  FILLER       PIC X(15) VALUE "SPORTING GOODS".
007300     05  FILLER       PIC 99 VALUE 03.
007400     05  FILLER       PIC X(15) VALUE "CAMPING".
007500 01  FILLER REDEFINES THE-DIVISIONS.
007600     05  DIVISION-TABLE OCCURS 3 TIMES
007700          INDEXED BY DIVISION-INDEX.
007800         10  DIVISION-NUMBER          PIC 99.
007900         10  DIVISION-NAME            PIC X(15).
008000
008100 01  THE-DEPARTMENTS.
008200     05  FILLER       PIC 99 VALUE 01.
008300     05  FILLER       PIC X(15) VALUE "EXERCISE".
008400     05  FILLER       PIC 99 VALUE 02.
008500     05  FILLER       PIC X(15) VALUE "MISCELLANEOUS".
008600     05  FILLER       PIC 99 VALUE 03.
008700     05  FILLER       PIC X(15) VALUE "SPORT CLOTHES".
008800     05  FILLER       PIC 99 VALUE 04.
008900     05  FILLER       PIC X(15) VALUE "EQUIPMENT".
009000     05  FILLER       PIC 99 VALUE 05.
009100     05  FILLER       PIC X(15) VALUE "CAMP EQUIPMENT".
009200     05  FILLER       PIC 99 VALUE 06.
009300     05  FILLER       PIC X(15) VALUE "CAMPING CLOTHES".
009400 01  FILLER REDEFINES THE-DEPARTMENTS.
009500     05  DEPARTMENT-TABLE OCCURS 6 TIMES
009600          INDEXED BY DEPARTMENT-INDEX.
009700         10  DEPARTMENT-NUMBER          PIC 99.
009800         10  DEPARTMENT-NAME            PIC X(15).
009900
010000 01  THE-CATEGORIES.
010100     05  FILLER       PIC 99 VALUE 01.
010200     05  FILLER       PIC X(15) VALUE "WEIGHTS".
010300     05  FILLER       PIC 99 VALUE 02.
010400     05  FILLER       PIC X(15) VALUE "MACHINES".
010500     05  FILLER       PIC 99 VALUE 03.
010600     05  FILLER       PIC X(15) VALUE "SUN GLASSES".
010700     05  FILLER       PIC 99 VALUE 04.
010800     05  FILLER       PIC X(15) VALUE "VITAMINS".
010900     05  FILLER       PIC 99 VALUE 05.
011000     05  FILLER       PIC X(15) VALUE "MEN'S CLOTHES".
011100     05  FILLER       PIC 99 VALUE 06.
011200     05  FILLER       PIC X(15) VALUE "WOMEN'S CLOTHES".
011300     05  FILLER       PIC 99 VALUE 07.
011400     05  FILLER       PIC X(15) VALUE "TENNIS".
011500     05  FILLER       PIC 99 VALUE 08.
011600     05  FILLER       PIC X(15) VALUE "SOCCER".
011700     05  FILLER       PIC 99 VALUE 09.
011800     05  FILLER       PIC X(15) VALUE "TENTS".
011900     05  FILLER       PIC 99 VALUE 10.
012000     05  FILLER       PIC X(15) VALUE "SLEEPING BAGS".
012100     05  FILLER       PIC 99 VALUE 11.
012200     05  FILLER       PIC X(15) VALUE "CLOTHING".
012300     05  FILLER       PIC 99 VALUE 12.
012400     05  FILLER       PIC X(15) VALUE "HIKING BOOTS".
012500 01  FILLER REDEFINES THE-CATEGORIES.
012600     05  CATEGORY-TABLE OCCURS 12 TIMES
012700          INDEXED BY CATEGORY-INDEX.
012800         10  CATEGORY-NUMBER          PIC 99.
012900         10  CATEGORY-NAME            PIC X(15).
013000
013100 77  OK-TO-PROCESS         PIC X.
013200
013300     COPY "WSCASE01.CBL".
013400
013500 01  LEGEND-LINE.
013600     05  FILLER            PIC X(6) VALUE "STORE:".
013700     05  FILLER            PIC X(1) VALUE SPACE.
013800     05  PRINT-STORE       PIC Z9.
013900
014000 01  DETAIL-LINE.
014100     05  FILLER               PIC X(3) VALUE SPACE.
014200     05  PRINT-DIVISION       PIC Z9.
014300     05  FILLER               PIC X(4) VALUE SPACE.
014400     05  FILLER               PIC X(3) VALUE SPACE.
014500     05  PRINT-DEPARTMENT     PIC Z9.
014600     05  FILLER               PIC X(6) VALUE SPACE.
014700     05  FILLER               PIC X(3) VALUE SPACE.
014800     05  PRINT-CATEGORY       PIC Z9.
014900     05  FILLER               PIC X(4) VALUE SPACE.
015000     05  PRINT-CATEGORY-NAME  PIC X(15).
015100     05  FILLER               PIC X(1) VALUE SPACE.
015200     05  PRINT-AMOUNT         PIC ZZZ,ZZ9.99-.
015300
015400 01  COLUMN-LINE.
015500     05  FILLER         PIC X(8)  VALUE "DIVISION".
015600     05  FILLER         PIC X(1)  VALUE SPACE.
015700     05  FILLER         PIC X(10) VALUE "DEPARTMENT".
015800     05  FILLER         PIC X(1)  VALUE SPACE.
015900     05  FILLER         PIC X(8)  VALUE "CATEGORY".
016000     05  FILLER         PIC X(1)  VALUE SPACE.
016100     05  FILLER         PIC X(15)  VALUE SPACE.
016200     05  FILLER         PIC X(5)  VALUE SPACE.
016300     05  FILLER         PIC X(6)  VALUE "AMOUNT".
016400
016500 01  TITLE-LINE.
016600     05  FILLER              PIC X(4) VALUE "RUN:".
016700     05  FORMATTED-RUN-DATE  PIC X(10).
016800     05  FILLER              PIC X(4) VALUE " AT ".
016900     05  FORMATTED-RUN-TIME  PIC X(8).
017000     05  FILLER              PIC X(10) VALUE SPACE.
017100     05  FILLER              PIC X(12)
017200         VALUE "SALES REPORT".
017300     05  FILLER              PIC X(10) VALUE SPACE.
017400     05  FILLER              PIC X(5) VALUE "PAGE:".
017500     05  FILLER              PIC X(1) VALUE SPACE.
017600     05  PRINT-PAGE-NUMBER   PIC ZZZ9.
017700
017800 01  TOTAL-LINE.
017900     05  FILLER              PIC X(11) VALUE SPACE.
018000     05  TOTAL-TYPE          PIC X(8).
018100     05  FILLER              PIC X(1) VALUE SPACE.
018200     05  TOTAL-NUMBER        PIC Z9.
018300     05  FILLER              PIC X(1) VALUE SPACE.
018400     05  TOTAL-NAME          PIC X(15) VALUE SPACE.
018500     05  FILLER              PIC X(1) VALUE SPACE.
018600     05  TOTAL-LITERAL       PIC X(5) VALUE "TOTAL".
018700     05  FILLER              PIC X(1) VALUE SPACE.
018800     05  PRINT-TOTAL         PIC ZZZ,ZZ9.99-.
018900
019000 77  GRAND-TOTAL-LITERAL      PIC X(8) VALUE "   GRAND".
019100 77  STORE-TOTAL-LITERAL      PIC X(8) VALUE "   STORE".
019200 77  DIVISION-TOTAL-LITERAL   PIC X(8) VALUE "DIVISION".
019300 77  DEPARTMENT-TOTAL-LITERAL PIC X(8) VALUE "    DEPT".
019400
019500 77  WORK-FILE-AT-END        PIC X.
019600
019700 77  LINE-COUNT              PIC 999 VALUE ZERO.
019800 77  PAGE-NUMBER             PIC 9999 VALUE ZERO.
019900 77  MAXIMUM-LINES           PIC 999 VALUE 55.
020000
020100 77  RECORD-COUNT            PIC 9999 VALUE ZEROES.
020200
020300* Control break current values for store, division
020400* department.
020500 77  CURRENT-STORE          PIC 99.
020600 77  CURRENT-DIVISION       PIC 99.
020700 77  CURRENT-DEPARTMENT     PIC 99.
020800
020900* Control break accumulators
021000* GRAND TOTAL is the level 1 accumulator for the whole file
021100* STORE TOTAL is the level 2 accumulator
021200* DIVISION TOTAL is the level 3 accumulator
021300* DEPARTMENT TOTAL is the level 4 accumulator.
021400 77  GRAND-TOTAL            PIC S9(6)V99.
021500 77  STORE-TOTAL            PIC S9(6)V99.
021600 77  DIVISION-TOTAL         PIC S9(6)V99.
021700 77  DEPARTMENT-TOTAL       PIC S9(6)V99.
021800
021900* System date and time
022000 77  RUN-DATE           PIC 9(6).
022100 77  RUN-TIME           PIC 9(8).
022200
022300*---------------------------------
022400* Fields for date routines.
022500*---------------------------------
022600 77  FORMATTED-DATE     PIC Z9/99/9999.
022700 77  DATE-MMDDCCYY      PIC 9(8).
022800 01  DATE-CCYYMMDD      PIC 9(8).
022900 01  FILLER REDEFINES DATE-CCYYMMDD.
023000     05  DATE-CC        PIC 99.
023100     05  DATE-YY        PIC 99.
023200     05  DATE-MM        PIC 99.
023300     05  DATE-DD        PIC 99.
023400
023500*---------------------------------
023600* Fields for TIME routines.
023700*---------------------------------
023800 77  FORMATTED-TIME     PIC Z9/99/99.
023900
024000 01  TIME-HHMMSS      PIC 9(6).
024100 01  FILLER REDEFINES TIME-HHMMSS.
024200     05  TIME-HH        PIC 99.
024300     05  TIME-MM        PIC 99.
024400     05  TIME-SS        PIC 99.
024500
024600 PROCEDURE DIVISION.
024700 PROGRAM-BEGIN.
024800
024900     PERFORM OPENING-PROCEDURE.
025000     PERFORM MAIN-PROCESS.
025100     PERFORM CLOSING-PROCEDURE.
025200
025300 PROGRAM-EXIT.
025400     EXIT PROGRAM.
025500
025600 PROGRAM-DONE.
025700     STOP RUN.
025800
025900 OPENING-PROCEDURE.
026000
026100     OPEN OUTPUT PRINTER-FILE.
026200
026300 MAIN-PROCESS.
026400     PERFORM GET-OK-TO-PROCESS.
026500     PERFORM PROCESS-THE-FILE
026600         UNTIL OK-TO-PROCESS = "N".
026700
026800 CLOSING-PROCEDURE.
026900     CLOSE PRINTER-FILE.
027000
027100 GET-OK-TO-PROCESS.
027200     PERFORM ACCEPT-OK-TO-PROCESS.
027300     PERFORM RE-ACCEPT-OK-TO-PROCESS
027400         UNTIL OK-TO-PROCESS = "Y" OR "N".
027500
027600 ACCEPT-OK-TO-PROCESS.
027700     DISPLAY "PRINT SALES REPORT (Y/N)?".
027800     ACCEPT OK-TO-PROCESS.
027900     INSPECT OK-TO-PROCESS
028000       CONVERTING LOWER-ALPHA
028100       TO         UPPER-ALPHA.
028200
028300 RE-ACCEPT-OK-TO-PROCESS.
028400     DISPLAY "YOU MUST ENTER YES OR NO".
028500     PERFORM ACCEPT-OK-TO-PROCESS.
028600
028700 PROCESS-THE-FILE.
028800     PERFORM START-THE-FILE.
028900     PERFORM PRINT-ONE-REPORT.
029000     PERFORM END-THE-FILE.
029100
029200*    PERFORM GET-OK-TO-PROCESS.
029300     MOVE "N" TO OK-TO-PROCESS.
029400
029500 START-THE-FILE.
029600     PERFORM SORT-DATA-FILE.
029700     OPEN INPUT WORK-FILE.
029800
029900 END-THE-FILE.
030000     CLOSE WORK-FILE.
030100
030200 SORT-DATA-FILE.
030300     SORT SORT-FILE
030400         ON ASCENDING KEY SORT-STORE
030500            ASCENDING KEY SORT-DIVISION
030600            ASCENDING KEY SORT-DEPARTMENT
030700            ASCENDING KEY SORT-CATEGORY
030800          USING SALES-FILE
030900          GIVING WORK-FILE.
031000
031100* LEVEL 1 CONTROL BREAK
031200 PRINT-ONE-REPORT.
031300     PERFORM START-ONE-REPORT.
031400     PERFORM PROCESS-ALL-STORES
031500         UNTIL WORK-FILE-AT-END = "Y".
031600     PERFORM END-ONE-REPORT.
031700
031800 START-ONE-REPORT.
031900     PERFORM READ-FIRST-VALID-WORK.
032000     MOVE ZEROES TO GRAND-TOTAL.
032100
032200     PERFORM START-NEW-REPORT.
032300
032400 START-NEW-REPORT.
032500     MOVE SPACE TO DETAIL-LINE.
032600     MOVE ZEROES TO LINE-COUNT PAGE-NUMBER.
032700
032800     ACCEPT RUN-DATE FROM DATE.
032900     MOVE RUN-DATE TO DATE-CCYYMMDD.
033000     IF DATE-YY > 90
033100         MOVE 19 TO DATE-CC
033200     ELSE
033300         MOVE 20 TO DATE-CC.
033400
033500     PERFORM FORMAT-THE-DATE.
033600     MOVE FORMATTED-DATE TO FORMATTED-RUN-DATE.
033700
033800     ACCEPT RUN-TIME FROM TIME.
033900     COMPUTE TIME-HHMMSS = RUN-TIME / 100.
034000     PERFORM FORMAT-THE-TIME.
034100     MOVE FORMATTED-TIME TO FORMATTED-RUN-TIME.
034200
034300
034400 END-ONE-REPORT.
034500     IF RECORD-COUNT = ZEROES
034600         MOVE "NO RECORDS FOUND" TO PRINTER-RECORD
034700         PERFORM WRITE-TO-PRINTER
034800     ELSE
034900         PERFORM PRINT-GRAND-TOTAL.
035000
035100     PERFORM END-LAST-PAGE.
035200
035300 PRINT-GRAND-TOTAL.
035400     MOVE SPACE TO TOTAL-LINE.
035500     MOVE GRAND-TOTAL TO PRINT-TOTAL.
035600     MOVE GRAND-TOTAL-LITERAL TO TOTAL-TYPE.
035700     MOVE "TOTAL" TO TOTAL-LITERAL.
035800     MOVE TOTAL-LINE TO PRINTER-RECORD.
035900     PERFORM WRITE-TO-PRINTER.
036000     PERFORM LINE-FEED 2 TIMES.
036100     MOVE SPACE TO DETAIL-LINE.
036200
036300* LEVEL 2 CONTROL BREAK
036400 PROCESS-ALL-STORES.
036500     PERFORM START-ONE-STORE.
036600
036700     PERFORM PROCESS-ALL-DIVISIONS
036800         UNTIL WORK-FILE-AT-END = "Y"
036900            OR WORK-STORE NOT = CURRENT-STORE.
037000
037100     PERFORM END-ONE-STORE.
037200
037300 START-ONE-STORE.
037400     MOVE WORK-STORE TO CURRENT-STORE.
037500     MOVE ZEROES TO STORE-TOTAL.
037600     MOVE WORK-STORE TO PRINT-STORE.
037700
037800     PERFORM START-NEXT-PAGE.
037900
038000 END-ONE-STORE.
038100     PERFORM PRINT-STORE-TOTAL.
038200     ADD STORE-TOTAL TO GRAND-TOTAL.
038300
038400 PRINT-STORE-TOTAL.
038500     MOVE SPACE TO TOTAL-LINE.
038600     MOVE STORE-TOTAL TO PRINT-TOTAL.
038700     MOVE CURRENT-STORE TO TOTAL-NUMBER.
038800     MOVE STORE-TOTAL-LITERAL TO TOTAL-TYPE.
038900     MOVE "TOTAL" TO TOTAL-LITERAL.
039000     MOVE TOTAL-LINE TO PRINTER-RECORD.
039100     PERFORM WRITE-TO-PRINTER.
039200     PERFORM LINE-FEED.
039300     MOVE SPACE TO DETAIL-LINE.
039400
039500* LEVEL 3 CONTROL BREAK
039600 PROCESS-ALL-DIVISIONS.
039700     PERFORM START-ONE-DIVISION.
039800
039900     PERFORM PROCESS-ALL-DEPARTMENTS
040000         UNTIL WORK-FILE-AT-END = "Y"
040100            OR WORK-STORE NOT = CURRENT-STORE
040200            OR WORK-DIVISION NOT = CURRENT-DIVISION.
040300
040400     PERFORM END-ONE-DIVISION.
040500
040600 START-ONE-DIVISION.
040700     MOVE WORK-DIVISION TO CURRENT-DIVISION.
040800     MOVE ZEROES TO DIVISION-TOTAL.
040900     MOVE WORK-DIVISION TO PRINT-DIVISION.
041000
041100 END-ONE-DIVISION.
041200     PERFORM PRINT-DIVISION-TOTAL.
041300     ADD DIVISION-TOTAL TO STORE-TOTAL.
041400
041500 PRINT-DIVISION-TOTAL.
041600     MOVE SPACE TO TOTAL-LINE.
041700     MOVE DIVISION-TOTAL TO PRINT-TOTAL.
041800     MOVE CURRENT-DIVISION TO TOTAL-NUMBER.
041900     MOVE DIVISION-TOTAL-LITERAL TO TOTAL-TYPE.
042000     MOVE "TOTAL" TO TOTAL-LITERAL.
042100     PERFORM LOAD-DIVISION-NAME.
042200     MOVE TOTAL-LINE TO PRINTER-RECORD.
042300     PERFORM WRITE-TO-PRINTER.
042400     PERFORM LINE-FEED.
042500     MOVE SPACE TO DETAIL-LINE.
042600
042700 LOAD-DIVISION-NAME.
042800     SET DIVISION-INDEX TO 1.
042900     SEARCH DIVISION-TABLE
043000         AT END
043100           MOVE "NOT FOUND" TO TOTAL-NAME
043200         WHEN
043300           DIVISION-NUMBER(DIVISION-INDEX) =
043400              CURRENT-DIVISION
043500              MOVE DIVISION-NAME(DIVISION-INDEX) TO
043600                   TOTAL-NAME.
043700
043800* LEVEL 4 CONTROL BREAK
043900 PROCESS-ALL-DEPARTMENTS.
044000     PERFORM START-ONE-DEPARTMENT.
044100
044200     PERFORM PROCESS-ALL-CATEGORIES
044300         UNTIL WORK-FILE-AT-END = "Y"
044400            OR WORK-STORE NOT = CURRENT-STORE
044500            OR WORK-DIVISION NOT = CURRENT-DIVISION
044600            OR WORK-DEPARTMENT NOT = CURRENT-DEPARTMENT.
044700
044800     PERFORM END-ONE-DEPARTMENT.
044900
045000 START-ONE-DEPARTMENT.
045100     MOVE WORK-DEPARTMENT TO CURRENT-DEPARTMENT.
045200     MOVE ZEROES TO DEPARTMENT-TOTAL.
045300     MOVE WORK-DEPARTMENT TO PRINT-DEPARTMENT.
045400
045500 END-ONE-DEPARTMENT.
045600     PERFORM PRINT-DEPARTMENT-TOTAL.
045700     ADD DEPARTMENT-TOTAL TO DIVISION-TOTAL.
045800
045900 PRINT-DEPARTMENT-TOTAL.
046000     MOVE SPACE TO TOTAL-LINE.
046100     MOVE DEPARTMENT-TOTAL TO PRINT-TOTAL.
046200     MOVE CURRENT-DEPARTMENT TO TOTAL-NUMBER.
046300     MOVE DEPARTMENT-TOTAL-LITERAL TO TOTAL-TYPE.
046400     MOVE "TOTAL" TO TOTAL-LITERAL.
046500     PERFORM LOAD-DEPARTMENT-NAME.
046600     MOVE TOTAL-LINE TO PRINTER-RECORD.
046700     PERFORM WRITE-TO-PRINTER.
046800     PERFORM LINE-FEED.
046900     MOVE SPACE TO DETAIL-LINE.
047000
047100 LOAD-DEPARTMENT-NAME.
047200     SET DEPARTMENT-INDEX TO 1.
047300     SEARCH DEPARTMENT-TABLE
047400         AT END
047500           MOVE "NOT FOUND" TO TOTAL-NAME
047600         WHEN
047700           DEPARTMENT-NUMBER(DEPARTMENT-INDEX) =
047800              CURRENT-DEPARTMENT
047900              MOVE DEPARTMENT-NAME(DEPARTMENT-INDEX) TO
048000                   TOTAL-NAME.
048100
048200* PROCESS ONE RECORD LEVEL
048300 PROCESS-ALL-CATEGORIES.
048400     PERFORM PROCESS-THIS-CATEGORY.
048500     ADD WORK-AMOUNT TO DEPARTMENT-TOTAL.
048600     ADD 1 TO RECORD-COUNT.
048700     PERFORM READ-NEXT-VALID-WORK.
048800
048900 PROCESS-THIS-CATEGORY.
049000     IF LINE-COUNT > MAXIMUM-LINES
049100         PERFORM START-NEXT-PAGE.
049200     PERFORM PRINT-THE-RECORD.
049300
049400 PRINT-THE-RECORD.
049500     MOVE WORK-CATEGORY TO PRINT-CATEGORY.
049600
049700     PERFORM LOAD-CATEGORY-NAME.
049800
049900     MOVE WORK-AMOUNT TO PRINT-AMOUNT.
050000
050100     MOVE DETAIL-LINE TO PRINTER-RECORD.
050200     PERFORM WRITE-TO-PRINTER.
050300     MOVE SPACE TO DETAIL-LINE.
050400
050500 LOAD-CATEGORY-NAME.
050600     SET CATEGORY-INDEX TO 1.
050700     SEARCH CATEGORY-TABLE
050800         AT END
050900           MOVE "NOT FOUND" TO TOTAL-NAME
051000         WHEN
051100           CATEGORY-NUMBER(CATEGORY-INDEX) =
051200              WORK-CATEGORY
051300              MOVE CATEGORY-NAME(CATEGORY-INDEX) TO
051400                   PRINT-CATEGORY-NAME.
051500
051600* PRINTING ROUTINES
051700 WRITE-TO-PRINTER.
051800     WRITE PRINTER-RECORD BEFORE ADVANCING 1.
051900     ADD 1 TO LINE-COUNT.
052000
052100 LINE-FEED.
052200     MOVE SPACE TO PRINTER-RECORD.
052300     PERFORM WRITE-TO-PRINTER.
052400
052500 START-NEXT-PAGE.
052600     PERFORM END-LAST-PAGE.
052700     PERFORM START-NEW-PAGE.
052800
052900 START-NEW-PAGE.
053000     ADD 1 TO PAGE-NUMBER.
053100     MOVE PAGE-NUMBER TO PRINT-PAGE-NUMBER.
053200     MOVE TITLE-LINE TO PRINTER-RECORD.
053300     PERFORM WRITE-TO-PRINTER.
053400     PERFORM LINE-FEED.
053500     MOVE LEGEND-LINE TO PRINTER-RECORD.
053600     PERFORM WRITE-TO-PRINTER.
053700     PERFORM LINE-FEED.
053800     MOVE COLUMN-LINE TO PRINTER-RECORD.
053900     PERFORM WRITE-TO-PRINTER.
054000     PERFORM LINE-FEED.
054100
054200 END-LAST-PAGE.
054300     IF PAGE-NUMBER > 0
054400         PERFORM FORM-FEED.
054500     MOVE ZERO TO LINE-COUNT.
054600
054700 FORM-FEED.
054800     MOVE SPACE TO PRINTER-RECORD.
054900     WRITE PRINTER-RECORD BEFORE ADVANCING PAGE.
055000
055100*---------------------------------
055200* Read first, read next routines
055300*---------------------------------
055400 READ-FIRST-VALID-WORK.
055500     PERFORM READ-NEXT-VALID-WORK.
055600
055700 READ-NEXT-VALID-WORK.
055800     PERFORM READ-NEXT-WORK-RECORD.
055900
056000 READ-NEXT-WORK-RECORD.
056100     MOVE "N" TO WORK-FILE-AT-END.
056200     READ WORK-FILE NEXT RECORD
056300         AT END MOVE "Y" TO WORK-FILE-AT-END.
056400
056500* Date and time routines
056600 FORMAT-THE-DATE.
056700     PERFORM CONVERT-TO-MMDDCCYY.
056800     MOVE DATE-MMDDCCYY TO FORMATTED-DATE.
056900
057000 CONVERT-TO-MMDDCCYY.
057100     COMPUTE DATE-MMDDCCYY =
057200             DATE-CCYYMMDD * 10000.0001.
057300
057400 FORMAT-THE-TIME.
057500     MOVE TIME-HHMMSS TO FORMATTED-TIME.
057600     INSPECT FORMATTED-TIME
057700       REPLACING ALL "/" BY ":".
057800