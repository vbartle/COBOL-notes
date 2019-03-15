005100*---------------------------
005200* PLDATE.CBL
005300*---------------------------
005400 GET-A-DATE.
005500     PERFORM ACCEPT-A-DATE.
005600     PERFORM RE-ACCEPT-A-DATE
005700         UNTIL DATE-IS-OK.
005800
005900 ACCEPT-A-DATE.
006000     DISPLAY "ENTER A DATE (MM/DD/YYYY)".
006100     ACCEPT DATE-ENTRY-FIELD.
006200
006300     PERFORM EDIT-CHECK-DATE.
006400
006500 RE-ACCEPT-A-DATE.
006600     DISPLAY "INVALID DATE".
006700     PERFORM ACCEPT-A-DATE.
006800
006900 EDIT-CHECK-DATE.
007000     PERFORM EDIT-DATE.
007100     PERFORM CHECK-DATE.
007200
007300 EDIT-DATE.
007400     MOVE DATE-ENTRY-FIELD TO DATE-MMDDCCYY.
007500     COMPUTE DATE-CCYYMMDD =
007600             DATE-MMDDCCYY * 10000.0001.
007700
007800*---------------------------------
007900* Assume that the date is good, then
008000* test the date in the following
008100* steps. The routine stops if any
008200* of these conditions is true,
008300* and sets the valid date flag.
008400* Condition 1 returns the valid date
008500* flag set to "0".
008600* If any other condition is true,
008700* the valid date flag is set to "N".
008800* 1.  Is the date zeroes
008900* 2.  Month > 12 or < 1
009000* 3.  Day < 1 or  > 31
009100* 4.  Day > 30 and
009200*     Month = 2 (February)  or
009300*             4 (April)     or
009400*             6 (June)      or
009500*             9 (September) or
009600*            11 (November)
009700*     Day > 29 and
009800*     Month = 2 (February)
009900* 5.  Day = 29 and
010000*     Month = 2 and
010100*     Not a leap year
010200* ( A leap year is any year evenly
010300*   divisible by 400 or by 4 
010400*   but not by 100 ).
010500*---------------------------------
010600 CHECK-DATE.
010700     MOVE "Y" TO VALID-DATE-FLAG.
010800     IF DATE-CCYYMMDD = ZEROES
010900         MOVE "0" TO VALID-DATE-FLAG
011000     ELSE
011100     IF DATE-MM < 1 OR DATE-MM > 12
011200         MOVE "N" TO VALID-DATE-FLAG
011300     ELSE
011400     IF DATE-DD < 1 OR DATE-DD > 31
011500         MOVE "N" TO VALID-DATE-FLAG
011600     ELSE
011700     IF (DATE-DD > 30) AND
011800        (DATE-MM = 2 OR 4 OR 6 OR 9 OR 11)
011900         MOVE "N" TO VALID-DATE-FLAG
012000     ELSE
012100     IF DATE-DD > 29 AND DATE-MM = 2
012200         MOVE "N" TO VALID-DATE-FLAG
012300     ELSE
012400     IF DATE-DD = 29 AND DATE-MM = 2
012500         DIVIDE DATE-YYYY BY 400 GIVING DATE-QUOTIENT
012600                REMAINDER DATE-REMAINDER
012700         IF DATE-REMAINDER = 0
012800             MOVE "Y" TO VALID-DATE-FLAG
012900         ELSE
013000             DIVIDE DATE-YYYY BY 100 GIVING DATE-QUOTIENT
013100                    REMAINDER DATE-REMAINDER
013200             IF DATE-REMAINDER = 0
013300                 MOVE "N" TO VALID-DATE-FLAG
013400             ELSE
013500                 DIVIDE DATE-YYYY BY 4 GIVING DATE-QUOTIENT
013600                        REMAINDER DATE-REMAINDER
013700                 IF DATE-REMAINDER = 0
013800                     MOVE "Y" TO VALID-DATE-FLAG
013900                 ELSE
014000                     MOVE "N" TO VALID-DATE-FLAG.
014100
