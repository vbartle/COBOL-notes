001500 77  DATE-ENTRY-FIELD   PIC Z9/99/9999.
001600 77  DATE-MMDDCCYY      PIC 9(8).
001700 77  DATE-QUOTIENT      PIC 9999.
001800 77  DATE-REMAINDER     PIC 9999.
001900
002000 77  VALID-DATE-FLAG    PIC X.
002100     88  DATE-IS-INVALID  VALUE "N".
002200     88  DATE-IS-ZERO     VALUE "0".
002300     88  DATE-IS-VALID    VALUE "Y".
002400     88  DATE-IS-OK       VALUES "Y" "0".
002500
002600 01  DATE-CCYYMMDD      PIC 9(8).
002700 01  FILLER REDEFINES DATE-CCYYMMDD.
002800     05  DATE-YYYY      PIC 99.
002900 
003000     05  DATE-MM        PIC 99.
003100     05  DATE-DD        PIC 99.
003200
