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
003400     05  DATE-YYYY      PIC 9999.
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
