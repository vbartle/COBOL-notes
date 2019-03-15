000100*---------------------------------
000200* FDBILL01.CBL
000300* Primary Key - BILL-NUMBER
000400* BILL-DATE, BILL-DUE and BILL-PAID
000500*   are all dates in CCYYMMDD format.
000600*---------------------------------
000700 FD  BILL-FILE
000800     LABEL RECORDS ARE STANDARD.
000900 01  CHECK-RECORD.
001000     05  BILL-NUMBER              PIC 9(6).
001100     05  BILL-DATE                PIC 9(8).
001200     05  BILL-DUE                 PIC 9(8).
001300     05  BILL-AMOUNT              PIC S9(6)V99.
001400     05  BILL-INVOICE             PIC X(15).
001500     05  BILL-VENDOR              PIC 9(5).
001600     05  BILL-NOTES               PIC X(30).
001700     05  BILL-PAID                PIC 9(8).
001800
