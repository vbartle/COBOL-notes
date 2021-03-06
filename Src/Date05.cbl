000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. DATE05.
000300*---------------------------------
000400* Testing Date Entry and handling
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
001500 77  ANY-DATE           PIC 9(8) VALUE ZEROES.
001600 77  REQUIRED-DATE      PIC 9(8) VALUE ZEROES.
001700
001800*---------------------------------
001900* Fields for date routines.
002000*---------------------------------
002100 77  FORMATTED-DATE     PIC Z9/99/9999.
002200 77  DATE-MMDDCCYY      PIC 9(8).
002300 77  DATE-QUOTIENT      PIC 9999.
002400 77  DATE-REMAINDER     PIC 9999.
002500
002600 77  VALID-DATE-FLAG    PIC X.
002700     88  DATE-IS-INVALID  VALUE "N".
002800     88  DATE-IS-ZERO     VALUE "0".
002900     88  DATE-IS-VALID    VALUE "Y".
003000     88  DATE-IS-OK       VALUES "Y" "0".
003100
003200 01  DATE-CCYYMMDD      PIC 9(8).
003300 01  FILLER REDEFINES DATE-CCYYMMDD.
003400     05  DATE-CCYY      PIC 99.
003500   
003600     05  DATE-MM        PIC 99.
003700     05  DATE-DD        PIC 99.
003800
003900*---------------------------------
004000* User can set these values before
004100* performing GET-A-DATE.
004200*---------------------------------
004300 77  DATE-PROMPT        PIC X(50) VALUE SPACE.
004400 77  DATE-ERROR-MESSAGE PIC X(50) VALUE SPACE.
004500*---------------------------------
004600* User can set this value before
004700* performing GET-A-DATE or CHECK-DATE.
004800*---------------------------------
004900 77  ZERO-DATE-IS-OK    PIC X VALUE "N".
005000
005100 PROCEDURE DIVISION.
005200 PROGRAM-BEGIN.
005300     PERFORM OPENING-PROCEDURE.
005400     PERFORM MAIN-PROCESS.
005500     PERFORM CLOSING-PROCEDURE.
005600
005700 PROGRAM-EXIT.
005800     EXIT PROGRAM.
005900
006000 PROGRAM-DONE.
006100     STOP RUN.
006200
006300 OPENING-PROCEDURE.
006400
006500 CLOSING-PROCEDURE.
006600
006700 MAIN-PROCESS.
006800     PERFORM GET-TWO-DATES.
006900     PERFORM DISPLAY-AND-GET-DATES
007000         UNTIL REQUIRED-DATE = 00010101.
007100
007200 GET-TWO-DATES.
007300     PERFORM GET-ANY-DATE.
007400     PERFORM GET-REQUIRED-DATE.
007500
007600 GET-ANY-DATE.
007700     MOVE "Y" TO ZERO-DATE-IS-OK.
007800     MOVE "ENTER AN OPTIONAL MM/DD/CCYY?" TO DATE-PROMPT.
007900     MOVE "MUST BE ANY VALID DATE" TO DATE-ERROR-MESSAGE.
008000     PERFORM GET-A-DATE.
008100     MOVE DATE-CCYYMMDD TO ANY-DATE.
008200
008300 GET-REQUIRED-DATE.
008400     MOVE "N" TO ZERO-DATE-IS-OK.
008500     MOVE SPACE TO DATE-PROMPT.
008600     MOVE "MUST ENTER A VALID DATE" TO DATE-ERROR-MESSAGE.
008700     PERFORM GET-A-DATE.
008800     MOVE DATE-CCYYMMDD TO REQUIRED-DATE.
008900
009000 DISPLAY-AND-GET-DATES.
009100     PERFORM DISPLAY-THE-DATES.
009200     PERFORM GET-TWO-DATES.
009300
009400 DISPLAY-THE-DATES.
009500     MOVE ANY-DATE TO DATE-CCYYMMDD.
009600     PERFORM FORMAT-THE-DATE.
009700     DISPLAY "ANY DATE IS " FORMATTED-DATE.
009800     MOVE REQUIRED-DATE TO DATE-CCYYMMDD.
009900     PERFORM FORMAT-THE-DATE.
010000     DISPLAY "REQUIRED DATE IS " FORMATTED-DATE.
010100
010200*---------------------------------
010300* USAGE:
010400*  MOVE "Y" (OR "N") TO ZERO-DATE-IS-OK. (optional)
010500*  MOVE prompt TO DATE-PROMPT.           (optional)
010600*  MOVE message TO DATE-ERROR-MESSAGE    (optional)
010700*  PERFORM GET-A-DATE
010800* RETURNS:
010900*   DATE-IS-OK (ZERO OR VALID)
011000*   DATE-IS-VALID (VALID)
011100*   DATE-IS-INVALID (BAD DATE )
011200*
011300*   IF DATE IS VALID IT IS IN
011400*      DATE-CCYYMMDD AND
011500*      DATE-MMDDCCYY AND
011600*      FORMATTED-DATE (formatted)
011700*---------------------------------
011800 GET-A-DATE.
011900     PERFORM ACCEPT-A-DATE.
012000     PERFORM RE-ACCEPT-A-DATE
012100         UNTIL DATE-IS-OK.
012200
012300 ACCEPT-A-DATE.
012400     IF DATE-PROMPT = SPACE
012500         DISPLAY "ENTER A DATE (MM/DD/CCYY)"
012600     ELSE
012700         DISPLAY DATE-PROMPT.
012800
012900     ACCEPT FORMATTED-DATE.
013000
013100     PERFORM EDIT-CHECK-DATE.
013200
013300 RE-ACCEPT-A-DATE.
013400     IF DATE-ERROR-MESSAGE = SPACE
013500         DISPLAY "INVALID DATE"
013600     ELSE
013700         DISPLAY DATE-ERROR-MESSAGE.
013800
013900     PERFORM ACCEPT-A-DATE.
014000
014100 EDIT-CHECK-DATE.
014200     PERFORM EDIT-DATE.
014300     PERFORM CHECK-DATE.
014400     MOVE DATE-MMDDCCYY TO FORMATTED-DATE.
014500
014600 EDIT-DATE.
014700     MOVE FORMATTED-DATE TO DATE-MMDDCCYY.
014800     PERFORM CONVERT-TO-CCYYMMDD.
014900
015000*---------------------------------
015100* USAGE:
015200*  MOVE date(ccyymmdd) TO DATE-CCYYMMDD.
015300*  PERFORM CONVERT-TO-MMDDCCYY.
015400*
015500* RETURNS:
015600*  DATE-MMDDCCYY.
015700*---------------------------------
015800 CONVERT-TO-MMDDCCYY.
015900     COMPUTE DATE-MMDDCCYY =
016000             DATE-CCYYMMDD * 10000.0001.
016100
016200*---------------------------------
016300* USAGE:
016400*  MOVE date(mmddccyy) TO DATE-MMDDCCYY.
016500*  PERFORM CONVERT-TO-CCYYMMDD.
016600*
016700* RETURNS:
016800*  DATE-CCYYMMDD.
016900*---------------------------------
017000 CONVERT-TO-CCYYMMDD.
017100     COMPUTE DATE-CCYYMMDD =
017200             DATE-MMDDCCYY * 10000.0001.
017300
017400*---------------------------------
017500* USAGE:
017600*   MOVE date(ccyymmdd) TO DATE-CCYYMMDD.
017700*   MOVE "Y" (OR "N") TO ZERO-DATE-IS-OK.
017800*   PERFORM CHECK-DATE.
017900*
018000* RETURNS:
018100*   DATE-IS-OK      (ZERO OR VALID)
018200*   DATE-IS-VALID   (VALID)
018300*   DATE-IS-INVALID (BAD DATE )
018400*
018500* Assume that the date is good, then
018600* test the date in the following
018700* steps. The routine stops if any
018800* of these conditions is true,
018900* and sets the valid date flag.
019000* Condition 1 returns the valid date
019100* flag set to "0" if ZERO-DATE-IS-OK
019200* is "Y", otherwise it sets the
019300* valid date flag to "N".
019400* If any other condition is true,
019500* the valid date flag is set to "N".
019600* 1.  Is the date zeroes
019700* 2.  Month > 12 or < 1
019800* 3.  Day < 1 or  > 31
019900* 4.  Day > 30 and
020000*     Month = 2 (February)  or
020100*             4 (April)     or
020200*             6 (June)      or
020300*             9 (September) or
020400*            11 (November)
020500*     Day > 29 and
020600*     Month = 2 (February)
020700* 5.  Day = 29 and
020800*     Month = 2 and
020900*     Not a leap year
021000* ( A leap year is any year evenly
021100*   divisible by 400 or by 4 
021200*   but not by 100 ).
021300*---------------------------------
021400 CHECK-DATE.
021500     MOVE "Y" TO VALID-DATE-FLAG.
021600     IF DATE-CCYYMMDD = ZEROES
021700         IF ZERO-DATE-IS-OK = "Y"
021800             MOVE "0" TO VALID-DATE-FLAG
021900         ELSE
022000             MOVE "N" TO VALID-DATE-FLAG
022100     ELSE
022200     IF DATE-MM < 1 OR DATE-MM > 12
022300         MOVE "N" TO VALID-DATE-FLAG
022400     ELSE
022500     IF DATE-DD < 1 OR DATE-DD > 31
022600         MOVE "N" TO VALID-DATE-FLAG
022700     ELSE
022800     IF (DATE-DD > 30) AND
022900        (DATE-MM = 2 OR 4 OR 6 OR 9 OR 11)
023000         MOVE "N" TO VALID-DATE-FLAG
023100     ELSE
023200     IF DATE-DD > 29 AND DATE-MM = 2
023300         MOVE "N" TO VALID-DATE-FLAG
023400     ELSE
023500     IF DATE-DD = 29 AND DATE-MM = 2
023600         DIVIDE DATE-CCYY BY 400 GIVING DATE-QUOTIENT
023700                REMAINDER DATE-REMAINDER
023800         IF DATE-REMAINDER = 0
023900             MOVE "Y" TO VALID-DATE-FLAG
024000         ELSE
024100             DIVIDE DATE-CCYY BY 100 GIVING DATE-QUOTIENT
024200                    REMAINDER DATE-REMAINDER
024300             IF DATE-REMAINDER = 0
024400                 MOVE "N" TO VALID-DATE-FLAG
024500             ELSE
024600                 DIVIDE DATE-CCYY BY 4 GIVING DATE-QUOTIENT
024700                        REMAINDER DATE-REMAINDER
024800                 IF DATE-REMAINDER = 0
024900                     MOVE "Y" TO VALID-DATE-FLAG
025000                 ELSE
025100                     MOVE "N" TO VALID-DATE-FLAG.
025200*---------------------------------
025300* USAGE:
025400*  MOVE date(ccyymmdd) TO DATE-CCYYMMDD.
025500*  PERFORM FORMAT-THE-DATE.
025600*
025700* RETURNS:
025800*  FORMATTED-DATE
025900*  DATE-MMDDCCYY.
026000*---------------------------------
026100 FORMAT-THE-DATE.
026200     PERFORM CONVERT-TO-MMDDCCYY.
026300     MOVE DATE-MMDDCCYY TO FORMATTED-DATE.
026400
