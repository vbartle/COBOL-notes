000100*---------------------------------
000200* FDSALES.CBL
000400* Temporary daily sales file.
000600*---------------------------------
000700 FD  SALES-FILE
000800     LABEL RECORDS ARE STANDARD.
000900 01  SALES-RECORD.
001000     05  SALES-STORE              PIC 9(2).
001100     05  SALES-DIVISION           PIC 9(2).
001200     05  SALES-DEPARTMENT         PIC 9(2).
001300     05  SALES-CATEGORY           PIC 9(2).
001400     05  SALES-AMOUNT             PIC S9(6)V99.
001500
