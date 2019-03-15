000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. CMPINT03.
000300*------------------------------------------------
000400* Calculates compound interest
000500*------------------------------------------------
000600 ENVIRONMENT DIVISION.
000700 DATA DIVISION.
000800 WORKING-STORAGE SECTION.
000900
001000 01  YES-NO                       PIC X.
001100 01  ENTRY-OK                     PIC X.
001200 01  THE-INTEREST                 PIC 99V9.
001300 01  INTEREST-AS-DECIMAL          PIC V999.
001400 01  THE-PRINCIPAL                PIC 9(9)V99.
001500 01  WORKING-PRINCIPAL            PIC 9(9)V99.
001600 01  THE-NEW-VALUE                PIC 9(9)V99.
001700 01  EARNED-INTEREST              PIC 9(9)V99.
001800 01  THE-PERIOD                   PIC 9999.
001900 01  NO-OF-PERIODS                PIC 999.
002000
002100 01  ENTRY-FIELD                  PIC ZZZ,ZZZ,ZZZ.ZZ.
002200
002300 01  THE-WHOLE-MESSAGE.
002400     05  DISPLAY-PRINCIPAL        PIC ZZZ,ZZZ,ZZ9.99.
002500     05  MESSAGE-PART-01          PIC X(4) VALUE " at ".
002600     05  DISPLAY-INTEREST         PIC Z9.9.
002700     05  MESSAGE-PART-02          PIC X(6) VALUE "% for ".
002800     05  DISPLAY-PERIODS          PIC ZZ9.
002900     05  MESSAGE-PART-03          PIC X(16)
003000         VALUE " periods yields ".
003100     05  DISPLAY-VALUE            PIC ZZZ,ZZZ,ZZ9.99.
003200
003300 PROCEDURE DIVISION.
003400 PROGRAM-BEGIN.
003500
003600     MOVE "Y" TO YES-NO.
003700     PERFORM GET-AND-DISPLAY-RESULT
003800         UNTIL YES-NO = "N".
003900
004000 PROGRAM-DONE.
004100     ACCEPT OMITTED. STOP RUN.
004200
004300 GET-AND-DISPLAY-RESULT.
004400     PERFORM GET-THE-PRINCIPAL.
004500     PERFORM GET-THE-INTEREST.
004600     PERFORM GET-THE-PERIODS.
004700     PERFORM CALCULATE-THE-RESULT.
004800     PERFORM DISPLAY-THE-RESULT.
004900     PERFORM GO-AGAIN.
005000
005100 GET-THE-PRINCIPAL.
005200     MOVE "N" TO ENTRY-OK.
005300     PERFORM ENTER-THE-PRINCIPAL
005400         UNTIL ENTRY-OK = "Y".
005500
005600 ENTER-THE-PRINCIPAL.
005700     DISPLAY "Principal (.01 TO 999999.99)?".
005800     ACCEPT ENTRY-FIELD WITH CONVERSION.
005900     MOVE ENTRY-FIELD TO THE-PRINCIPAL.
006000     IF THE-PRINCIPAL < .01 OR
006100        THE-PRINCIPAL > 999999.99
006200         DISPLAY "INVALID ENTRY"
006300     ELSE
006400         MOVE "Y" TO ENTRY-OK.
006500
006600 GET-THE-INTEREST.
006700     MOVE "N" TO ENTRY-OK.
006800     PERFORM ENTER-THE-INTEREST
006900         UNTIL ENTRY-OK = "Y".
007000
007100 ENTER-THE-INTEREST.
007200     DISPLAY "Interest (.1% TO 99.9%)?".
007300     ACCEPT ENTRY-FIELD WITH CONVERSION.
007400     MOVE ENTRY-FIELD TO THE-INTEREST.
007500     IF THE-INTEREST < .1 OR
007600        THE-INTEREST > 99.9
007700         DISPLAY "INVALID ENTRY"
007800     ELSE
007900         MOVE "Y" TO ENTRY-OK
008000         COMPUTE INTEREST-AS-DECIMAL =
008100                 THE-INTEREST / 100.
008200
008300 GET-THE-PERIODS.
008400     MOVE "N" TO ENTRY-OK.
008500     PERFORM ENTER-THE-PERIODS
008600         UNTIL ENTRY-OK = "Y".
008700
008800 ENTER-THE-PERIODS.
008900     DISPLAY "Number of periods (1 TO 999)?".
009000     ACCEPT ENTRY-FIELD WITH CONVERSION.
009100     MOVE ENTRY-FIELD TO NO-OF-PERIODS.
009200     IF NO-OF-PERIODS < 1 OR
009300        NO-OF-PERIODS > 999
009400         DISPLAY "INVALID ENTRY"
009500     ELSE
009600         MOVE "Y" TO ENTRY-OK.
009700
009800 CALCULATE-THE-RESULT.
009900     MOVE THE-PRINCIPAL TO WORKING-PRINCIPAL.
010000     PERFORM CALCULATE-ONE-PERIOD
010100         VARYING THE-PERIOD FROM 1 BY 1
010200          UNTIL THE-PERIOD > NO-OF-PERIODS.
010300
010400 CALCULATE-ONE-PERIOD.
010500     COMPUTE EARNED-INTEREST ROUNDED =
010600         WORKING-PRINCIPAL * INTEREST-AS-DECIMAL.
010700     COMPUTE THE-NEW-VALUE =
010800             WORKING-PRINCIPAL + EARNED-INTEREST.
010900     MOVE THE-NEW-VALUE TO WORKING-PRINCIPAL.
011000
011100 GO-AGAIN.
011200     DISPLAY "GO AGAIN?".
011300     ACCEPT YES-NO.
011400     IF YES-NO = "y"
011500         MOVE "Y" TO YES-NO.
011600     IF YES-NO NOT = "Y"
011700         MOVE "N" TO YES-NO.
011800
011900 DISPLAY-THE-RESULT.
012000     MOVE THE-PRINCIPAL TO DISPLAY-PRINCIPAL.
012100     MOVE THE-INTEREST  TO DISPLAY-INTEREST.
012200     MOVE NO-OF-PERIODS TO DISPLAY-PERIODS.
012300     MOVE THE-NEW-VALUE TO DISPLAY-VALUE.
012400     DISPLAY THE-WHOLE-MESSAGE.
012500
