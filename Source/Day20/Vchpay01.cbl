000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. VCHPAY01.
000300*---------------------------------
000400* Change only.
000500* User can request a voucher.
000600* If the voucher is already paid,
000700* the user is asked if they
000800* would like to clear the payment
000900* and reopen the voucher.
001000* If the voucher is not paid,
001100* the user is required to enter
001200* a payment date, amount and check
001300* number.
001400* Only maintains PAID-DATE
001500* CHECK-NO and PAID-AMOUNT.
001600*---------------------------------
001700 ENVIRONMENT DIVISION.
001800 INPUT-OUTPUT SECTION.
001900 FILE-CONTROL.
002000
002100     COPY "SLVND02.CBL".
002200
002300     COPY "SLVOUCH.CBL".
002400
002500     COPY "SLCONTRL.CBL".
002600
002700 DATA DIVISION.
002800 FILE SECTION.
002900
003000     COPY "FDVND04.CBL".
003100
003200     COPY "FDVOUCH.CBL".
003300
003400     COPY "FDCONTRL.CBL".
003500
003600 WORKING-STORAGE SECTION.
003700
003800 77  WHICH-FIELD                  PIC 9.
003900 77  OK-TO-PROCESS                PIC X.
004000 77  FULL-PAYMENT                 PIC X.
004100 77  NEW-VOUCHER                  PIC X.
004200
004300 77  VOUCHER-RECORD-FOUND         PIC X.
004400 77  VENDOR-RECORD-FOUND          PIC X.
004500 77  CONTROL-RECORD-FOUND         PIC X.
004600 77  VOUCHER-NUMBER-FIELD         PIC Z(5).
004700 77  AN-AMOUNT-FIELD              PIC ZZZ,ZZ9.99-.
004800 77  CHECK-NO-FIELD               PIC Z(6).
004900
005000 77  PROCESS-MESSAGE              PIC X(79) VALUE SPACE.
005100
005200 77  SAVE-VOUCHER-RECORD          PIC X(103).
005300
005400     COPY "WSDATE01.CBL".
005500
005600     COPY "WSCASE01.CBL".
005700
005800 PROCEDURE DIVISION.
005900 PROGRAM-BEGIN.
006000     PERFORM OPENING-PROCEDURE.
006100     PERFORM MAIN-PROCESS.
006200     PERFORM CLOSING-PROCEDURE.
006300
006400 PROGRAM-EXIT.
006500     EXIT PROGRAM.
006600
006700 PROGRAM-DONE.
006800     STOP RUN.
006900
007000 OPENING-PROCEDURE.
007100     OPEN I-O VOUCHER-FILE.
007200     OPEN I-O VENDOR-FILE.
007300     OPEN I-O CONTROL-FILE.
007400
007500 CLOSING-PROCEDURE.
007600     CLOSE VOUCHER-FILE.
007700     CLOSE VENDOR-FILE.
007800     CLOSE CONTROL-FILE.
007900
008000 MAIN-PROCESS.
008100     PERFORM CHANGE-MODE.
008200
008300*---------------------------------
008400* CHANGE
008500*---------------------------------
008600 CHANGE-MODE.
008700     PERFORM GET-EXISTING-RECORD.
008800     PERFORM CHANGE-RECORDS
008900        UNTIL VOUCHER-NUMBER = ZEROES.
009000
009100 CHANGE-RECORDS.
009200     PERFORM DISPLAY-ALL-FIELDS.
009300     IF VOUCHER-PAID-DATE = ZEROES
009400         PERFORM CHANGE-TO-PAID
009500     ELSE
009600         PERFORM CHANGE-TO-UNPAID.
009700
009800     PERFORM GET-EXISTING-RECORD.
009900
010000*---------------------------------
010100* Ask if the user wants to pay this
010200* voucher and if so:
010300* Change the voucher to paid status
010400* by getting PAID-DATE, PAID-AMOUNT
010500* and CHECK-NO.
010600*---------------------------------
010700 CHANGE-TO-PAID.
010800     PERFORM ASK-OK-TO-PAY.
010900     IF OK-TO-PROCESS = "Y"
011000         PERFORM CHANGE-ALL-FIELDS.
011100
011200 ASK-OK-TO-PAY.
011300     MOVE "PROCESS THIS VOUCHER AS PAID (Y/N)?"
011400         TO PROCESS-MESSAGE.
011500     PERFORM ASK-OK-TO-PROCESS.
011600
011700 CHANGE-ALL-FIELDS.
011800     PERFORM CHANGE-THIS-FIELD
011900         VARYING WHICH-FIELD FROM 1 BY 1
012000          UNTIL WHICH-FIELD > 3.
012100
012200     PERFORM REWRITE-VOUCHER-RECORD.
012300
012400     IF NEW-VOUCHER = "Y"
012500         PERFORM GENERATE-NEW-VOUCHER.
012600
012700 CHANGE-THIS-FIELD.
012800     IF WHICH-FIELD = 1
012900         PERFORM ENTER-VOUCHER-PAID-DATE.
013000     IF WHICH-FIELD = 2
013100         PERFORM ENTER-VOUCHER-PAYMENT.
013200     IF WHICH-FIELD = 3
013300         PERFORM ENTER-VOUCHER-CHECK-NO.
013400
013500*---------------------------------
013600* Ask if the user wants to re-open
013700* this voucher and if so:
013800* Move zeroes to PAID-DATE,
013900* PAID-AMOUNT and CHECK-NO.
014000*---------------------------------
014100 CHANGE-TO-UNPAID.
014200     PERFORM ASK-OK-TO-OPEN.
014300     IF OK-TO-PROCESS = "Y"
014400         PERFORM CLEAR-PAID-AND-REWRITE
014500         DISPLAY "VOUCHER HAS BEEN RE OPENED".
014600
014700 CLEAR-PAID-AND-REWRITE.
014800     PERFORM CLEAR-PAID-FIELDS.
014900     PERFORM REWRITE-VOUCHER-RECORD.
015000
015100 CLEAR-PAID-FIELDS.
015200     MOVE ZEROES TO VOUCHER-PAID-DATE
015300                    VOUCHER-PAID-AMOUNT
015400                    VOUCHER-CHECK-NO.
015500
015600 ASK-OK-TO-OPEN.
015700     MOVE "RE-OPEN THIS VOUCHER (Y/N)?" TO PROCESS-MESSAGE.
015800     PERFORM ASK-OK-TO-PROCESS.
015900
016000*---------------------------------
016100* This routine is used by both
016200* ASK-OK-TO-PAY which is part of
016300* the CHANGE-TO-PAID logic, and
016400* ASK-OK-TO-OPEN which is part
016500* of the CHANGE-TO-UNPAID LOGIC.
016600*---------------------------------
016700 ASK-OK-TO-PROCESS.
016800     PERFORM ACCEPT-OK-TO-PROCESS.
016900
017000     PERFORM RE-ACCEPT-OK-TO-PROCESS
017100        UNTIL OK-TO-PROCESS = "Y" OR "N".
017200
017300 ACCEPT-OK-TO-PROCESS.
017400     DISPLAY PROCESS-MESSAGE.
017500     ACCEPT OK-TO-PROCESS.
017600     INSPECT OK-TO-PROCESS
017700      CONVERTING LOWER-ALPHA TO UPPER-ALPHA.
017800
017900 RE-ACCEPT-OK-TO-PROCESS.
018000     DISPLAY "YOU MUST ENTER YES OR NO".
018100     PERFORM ACCEPT-OK-TO-PROCESS.
018200
018300*---------------------------------
018400* Field entry routines.
018500*---------------------------------
018600 ENTER-VOUCHER-PAID-DATE.
018700     MOVE "N" TO ZERO-DATE-IS-OK.
018800     MOVE "ENTER PAID DATE(MM/DD/CCYY)?"
018900            TO DATE-PROMPT.
019000     MOVE "A VALID PAID DATE IS REQUIRED"
019100            TO DATE-ERROR-MESSAGE.
019200     PERFORM GET-A-DATE.
019300     MOVE DATE-CCYYMMDD TO VOUCHER-PAID-DATE.
019400
019500*---------------------------------
019600* Voucher payment is entered by
019700* asking if the payment is for the
019800* the exact amount of the voucher.
019900* If it is, VOUCHER-AMOUNT is
020000* is moved in to VOUCHER-PAID-AMOUNT.
020100* If it is not, then the user is
020200* asked to enter to enter the amount
020300* to be paid.
020400* If the paid amount is less than
020500* the voucher amount, the user
020600* is also asked if a new voucher
020700* should be generated for the
020800* the balance. This allows
020900* for partial payments.
021000*---------------------------------
021100 ENTER-VOUCHER-PAYMENT.
021200     MOVE "N" TO NEW-VOUCHER.
021300     PERFORM ASK-FULL-PAYMENT.
021400     IF FULL-PAYMENT = "Y"
021500         MOVE VOUCHER-AMOUNT TO VOUCHER-PAID-AMOUNT
021600     ELSE
021700         PERFORM ENTER-VOUCHER-PAID-AMOUNT
021800         IF VOUCHER-PAID-AMOUNT < VOUCHER-AMOUNT
021900             PERFORM ASK-NEW-VOUCHER.
022000
022100 ASK-FULL-PAYMENT.
022200     PERFORM ACCEPT-FULL-PAYMENT.
022300     PERFORM RE-ACCEPT-FULL-PAYMENT
022400        UNTIL FULL-PAYMENT = "Y" OR "N".
022500
022600 ACCEPT-FULL-PAYMENT.
022700     MOVE VOUCHER-AMOUNT TO AN-AMOUNT-FIELD.
022800     DISPLAY "PAY THE EXACT AMOUNT "
022900             AN-AMOUNT-FIELD
023000             " (Y/N)?".
023100     ACCEPT FULL-PAYMENT.
023200     INSPECT FULL-PAYMENT
023300      CONVERTING LOWER-ALPHA TO UPPER-ALPHA.
023400
023500 RE-ACCEPT-FULL-PAYMENT.
023600     DISPLAY "YOU MUST ENTER YES OR NO".
023700     PERFORM ACCEPT-FULL-PAYMENT.
023800
023900 ASK-NEW-VOUCHER.
024000     PERFORM ACCEPT-NEW-VOUCHER.
024100     PERFORM RE-ACCEPT-NEW-VOUCHER
024200        UNTIL NEW-VOUCHER = "Y" OR "N".
024300
024400 ACCEPT-NEW-VOUCHER.
024500     MOVE VOUCHER-AMOUNT TO AN-AMOUNT-FIELD.
024600     DISPLAY "GENERATE A NEW VOUCHER".
024700     DISPLAY " FOR THE BALANCE (Y/N)?".
024800     ACCEPT NEW-VOUCHER.
024900     INSPECT NEW-VOUCHER
025000      CONVERTING LOWER-ALPHA TO UPPER-ALPHA.
025100
025200 RE-ACCEPT-NEW-VOUCHER.
025300     DISPLAY "YOU MUST ENTER YES OR NO".
025400     PERFORM ACCEPT-NEW-VOUCHER.
025500
025600 ENTER-VOUCHER-PAID-AMOUNT.
025700     PERFORM ACCEPT-VOUCHER-PAID-AMOUNT.
025800     PERFORM RE-ACCEPT-VOUCHER-PAID-AMOUNT
025900         UNTIL VOUCHER-PAID-AMOUNT NOT = ZEROES
026000           AND VOUCHER-PAID-AMOUNT NOT > VOUCHER-AMOUNT.
026100
026200 ACCEPT-VOUCHER-PAID-AMOUNT.
026300     DISPLAY "ENTER AMOUNT PAID".
026400     ACCEPT AN-AMOUNT-FIELD.
026500     MOVE AN-AMOUNT-FIELD TO VOUCHER-PAID-AMOUNT.
026600
026700 RE-ACCEPT-VOUCHER-PAID-AMOUNT.
026800     MOVE VOUCHER-AMOUNT TO AN-AMOUNT-FIELD.
026900     DISPLAY "A PAYMENT MUST BE ENTERED THAT IS".
027000     DISPLAY "NOT GREATER THAN " AN-AMOUNT-FIELD.
027100     PERFORM ACCEPT-VOUCHER-PAID-AMOUNT.
027200
027300 ENTER-VOUCHER-CHECK-NO.
027400     PERFORM ACCEPT-VOUCHER-CHECK-NO.
027500
027600 ACCEPT-VOUCHER-CHECK-NO.
027700     DISPLAY "ENTER THE CHECK NUMBER".
027800     DISPLAY "ENTER 0 FOR CASH PAYMENT".
027900     ACCEPT CHECK-NO-FIELD.
028000     MOVE CHECK-NO-FIELD TO VOUCHER-CHECK-NO.
028100
028200*---------------------------------
028300* A new voucher is generated by
028400* 1. Saving the existing voucher
028500*    record.
028600* 2. Locating a new voucher number
028700*    that is not in use by using
028800*    the control file and attempting
028900*    to read a voucher with the
029000*    number offered by the control
029100*    file.
029200* 3. Restoring the saved voucher record
029300*    but using the new voucher number.
029400* 4. Setting the new voucher amount
029500*    to the original amount minus
029600*    the amount paid.
029700* 5. Resetting the paid date,
029800*    paid amount and check number
029900* 6. Setting the selected flag to "N".
030000* 7. Writing this new record.
030100*---------------------------------
030200 GENERATE-NEW-VOUCHER.
030300     MOVE VOUCHER-RECORD TO SAVE-VOUCHER-RECORD.
030400     PERFORM GET-NEW-RECORD-KEY.
030500     PERFORM CREATE-NEW-VOUCHER-RECORD.
030600     PERFORM DISPLAY-NEW-VOUCHER.
030700
030800 CREATE-NEW-VOUCHER-RECORD.
030900     MOVE SAVE-VOUCHER-RECORD TO VOUCHER-RECORD.
031000     MOVE CONTROL-LAST-VOUCHER TO VOUCHER-NUMBER.
031100     SUBTRACT VOUCHER-PAID-AMOUNT FROM VOUCHER-AMOUNT.
031200     MOVE "N" TO VOUCHER-SELECTED.
031300     PERFORM CLEAR-PAID-FIELDS.
031400     PERFORM WRITE-VOUCHER-RECORD.
031500
031600 DISPLAY-NEW-VOUCHER.
031700     MOVE VOUCHER-NUMBER TO VOUCHER-NUMBER-FIELD.
031800     MOVE VOUCHER-AMOUNT TO AN-AMOUNT-FIELD.
031900     DISPLAY "VOUCHER " VOUCHER-NUMBER-FIELD
032000             " CREATED FOR " AN-AMOUNT-FIELD.
032100
032200*---------------------------------
032300* Standard change mode routines to
032400* get a voucher number, read the
032500* voucher record.
032600*---------------------------------
032700 GET-NEW-RECORD-KEY.
032800     PERFORM ACCEPT-NEW-RECORD-KEY.
032900     PERFORM RE-ACCEPT-NEW-RECORD-KEY
033000         UNTIL VOUCHER-RECORD-FOUND = "N".
033100
033200
033300
033400 ACCEPT-NEW-RECORD-KEY.
033500     PERFORM INIT-VOUCHER-RECORD.
033600     PERFORM RETRIEVE-NEXT-VOUCHER-NUMBER.
033700
033800     PERFORM READ-VOUCHER-RECORD.
033900
034000 RE-ACCEPT-NEW-RECORD-KEY.
034100     PERFORM ACCEPT-NEW-RECORD-KEY.
034200
034300 RETRIEVE-NEXT-VOUCHER-NUMBER.
034400     PERFORM READ-CONTROL-RECORD.
034500     ADD 1 TO CONTROL-LAST-VOUCHER.
034600     MOVE CONTROL-LAST-VOUCHER TO VOUCHER-NUMBER.
034700     PERFORM REWRITE-CONTROL-RECORD.
034800
034900 GET-EXISTING-RECORD.
035000     PERFORM ACCEPT-EXISTING-KEY.
035100     PERFORM RE-ACCEPT-EXISTING-KEY
035200         UNTIL VOUCHER-RECORD-FOUND = "Y" OR
035300               VOUCHER-NUMBER = ZEROES.
035400
035500 ACCEPT-EXISTING-KEY.
035600     PERFORM INIT-VOUCHER-RECORD.
035700     PERFORM ENTER-VOUCHER-NUMBER.
035800     IF VOUCHER-NUMBER NOT = ZEROES
035900         PERFORM READ-VOUCHER-RECORD.
036000
036100 RE-ACCEPT-EXISTING-KEY.
036200     DISPLAY "RECORD NOT FOUND".
036300     PERFORM ACCEPT-EXISTING-KEY.
036400
036500 ENTER-VOUCHER-NUMBER.
036600     DISPLAY "ENTER VOUCHER NUMBER TO PROCESS".
036700     ACCEPT VOUCHER-NUMBER.
036800
036900*---------------------------------
037000* Standard routines to display
037100* voucher fields.
037200*---------------------------------
037300 DISPLAY-ALL-FIELDS.
037400     DISPLAY " ".
037500     PERFORM DISPLAY-VOUCHER-NUMBER.
037600     PERFORM DISPLAY-VOUCHER-VENDOR.
037700     PERFORM DISPLAY-VOUCHER-INVOICE.
037800     PERFORM DISPLAY-VOUCHER-FOR.
037900     PERFORM DISPLAY-VOUCHER-AMOUNT.
038000     PERFORM DISPLAY-VOUCHER-DATE.
038100     PERFORM DISPLAY-VOUCHER-DUE.
038200     PERFORM DISPLAY-VOUCHER-DEDUCTIBLE.
038300     PERFORM DISPLAY-VOUCHER-SELECTED.
038400     PERFORM DISPLAY-VOUCHER-PAID-DATE.
038500     PERFORM DISPLAY-VOUCHER-PAID-AMOUNT.
038600     PERFORM DISPLAY-VOUCHER-CHECK-NO.
038700     DISPLAY " ".
038800
038900 DISPLAY-VOUCHER-NUMBER.
039000     DISPLAY "   VOUCHER NUMBER: " VOUCHER-NUMBER.
039100
039200 DISPLAY-VOUCHER-VENDOR.
039300     PERFORM VOUCHER-VENDOR-ON-FILE.
039400     IF VENDOR-RECORD-FOUND = "N"
039500         MOVE "**Not found**" TO VENDOR-NAME.
039600     DISPLAY "   VENDOR: "
039700             VOUCHER-VENDOR " "
039800             VENDOR-NAME.
039900
040000 DISPLAY-VOUCHER-INVOICE.
040100     DISPLAY "   INVOICE: " VOUCHER-INVOICE.
040200
040300 DISPLAY-VOUCHER-FOR.
040400     DISPLAY "   FOR: " VOUCHER-FOR.
040500
040600 DISPLAY-VOUCHER-AMOUNT.
040700     MOVE VOUCHER-AMOUNT TO AN-AMOUNT-FIELD.
040800     DISPLAY "   AMOUNT: " AN-AMOUNT-FIELD.
040900
041000 DISPLAY-VOUCHER-DATE.
041100     MOVE VOUCHER-DATE TO DATE-CCYYMMDD.
041200     PERFORM FORMAT-THE-DATE.
041300     DISPLAY "   INVOICE DATE: " FORMATTED-DATE.
041400
041500 DISPLAY-VOUCHER-DUE.
041600     MOVE VOUCHER-DUE TO DATE-CCYYMMDD.
041700     PERFORM FORMAT-THE-DATE.
041800     DISPLAY "   DUE DATE: " FORMATTED-DATE.
041900
042000 DISPLAY-VOUCHER-DEDUCTIBLE.
042100     DISPLAY "   DEDUCTIBLE: " VOUCHER-DEDUCTIBLE.
042200
042300 DISPLAY-VOUCHER-SELECTED.
042400     DISPLAY "   SELECTED FOR PAYMENT: " VOUCHER-SELECTED.
042500
042600 DISPLAY-VOUCHER-PAID-DATE.
042700     MOVE VOUCHER-PAID-DATE TO DATE-CCYYMMDD.
042800     PERFORM FORMAT-THE-DATE.
042900     DISPLAY "1. PAID ON: " FORMATTED-DATE.
043000
043100 DISPLAY-VOUCHER-PAID-AMOUNT.
043200     MOVE VOUCHER-PAID-AMOUNT TO AN-AMOUNT-FIELD.
043300     DISPLAY "2. PAID: " AN-AMOUNT-FIELD.
043400
043500 DISPLAY-VOUCHER-CHECK-NO.
043600     DISPLAY "3. CHECK: " VOUCHER-CHECK-NO.
043700
043800*---------------------------------
043900* File activity Routines
044000*---------------------------------
044100 INIT-VOUCHER-RECORD.
044200     MOVE SPACE TO VOUCHER-INVOICE
044300                   VOUCHER-FOR
044400                   VOUCHER-DEDUCTIBLE
044500                   VOUCHER-SELECTED.
044600     MOVE ZEROES TO VOUCHER-NUMBER
044700                    VOUCHER-VENDOR
044800                    VOUCHER-AMOUNT
044900                    VOUCHER-DATE
045000                    VOUCHER-DUE
045100                    VOUCHER-PAID-AMOUNT
045200                    VOUCHER-PAID-DATE
045300                    VOUCHER-CHECK-NO.
045400
045500 READ-VOUCHER-RECORD.
045600     MOVE "Y" TO VOUCHER-RECORD-FOUND.
045700     READ VOUCHER-FILE RECORD
045800       INVALID KEY
045900          MOVE "N" TO VOUCHER-RECORD-FOUND.
046000
046100*or  READ VOUCHER-FILE RECORD WITH LOCK
046200*      INVALID KEY
046300*         MOVE "N" TO VOUCHER-RECORD-FOUND.
046400
046500*or  READ VOUCHER-FILE RECORD WITH HOLD
046600*      INVALID KEY
046700*         MOVE "N" TO VOUCHER-RECORD-FOUND.
046800
046900 WRITE-VOUCHER-RECORD.
047000     WRITE VOUCHER-RECORD
047100         INVALID KEY
047200         DISPLAY "RECORD ALREADY ON FILE".
047300
047400 REWRITE-VOUCHER-RECORD.
047500     REWRITE VOUCHER-RECORD
047600         INVALID KEY
047700         DISPLAY "ERROR REWRITING VENDOR RECORD".
047800
047900 VOUCHER-VENDOR-ON-FILE.
048000     MOVE VOUCHER-VENDOR TO VENDOR-NUMBER.
048100     PERFORM READ-VENDOR-RECORD.
048200
048300 READ-VENDOR-RECORD.
048400     MOVE "Y" TO VENDOR-RECORD-FOUND.
048500     READ VENDOR-FILE RECORD
048600       INVALID KEY
048700          MOVE "N" TO VENDOR-RECORD-FOUND.
048800
048900 READ-CONTROL-RECORD.
049000     MOVE 1 TO CONTROL-KEY.
049100     MOVE "Y" TO CONTROL-RECORD-FOUND.
049200     READ CONTROL-FILE RECORD
049300         INVALID KEY
049400          MOVE "N" TO CONTROL-RECORD-FOUND
049500          DISPLAY "CONTROL FILE IS INVALID".
049600
049700 REWRITE-CONTROL-RECORD.
049800     REWRITE CONTROL-RECORD
049900         INVALID KEY
050000         DISPLAY "ERROR REWRITING CONTROL RECORD".
050100
050200*---------------------------------
050300* General utility routines
050400*---------------------------------
050500     COPY "PLDATE01.CBL".
050600
