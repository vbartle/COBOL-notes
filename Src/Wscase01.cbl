000100*---------------------------------
000200* Can be used for case conversion
000300* Ex:
000400*    INSPECT data-field
000500*      CONVERTING LOWER-ALPHA
000600*      TO         UPPER-ALPHA.
000700*---------------------------------
000800
000900 77  UPPER-ALPHA       PIC X(26) VALUE
001000     "ABCDEFGHIJKLMNOPQRSTUVWXYZ".
001100 77  LOWER-ALPHA       PIC X(26) VALUE
001200     "abcdefghijklmnopqrstuvwxyz".
001300
001400
