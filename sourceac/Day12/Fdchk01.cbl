000100*---------------------------------
000200* FDCHK01.CBL
000300* Primary Key - CHECK-KEY
000400*   if you use more than 1 check
000500*   account to pay bills, using
000600*   check numbers only may
000700*   cause duplicates.
000800* CHECK-INVOICE is the vendor's
000900*   invoice that this check paid
001000*   and can be blank.
001100* CHECK-CLEARED = "Y" once the
001200*   the check is reported cashed
001300*   on a bank statement. Setting
001400*   this flag is done in the
001500*   check clearance program
001600*   chkclr.cbl.
001700* CHECK-REFERENCE for any notes
001800*   about the check.
001900* CHECK-VENDOR can be zero for a
002000*   general check to someone who
002100*   is not a regular vendor, but
002200*   CHECK-REFERENCE should be
002300*   filled in with payee.
002400*---------------------------------
002500 FD  CHECK-FILE
002600     LABEL RECORDS ARE STANDARD.
002700 01  CHECK-RECORD.
002800     05  CHECK-KEY.
002900         10  CHECK-ACCOUNT        PIC 9(10).
003000         10  CHECK-NUMBER         PIC 9(6).
003100     05  CHECK-AMOUNT             PIC S9(6)V99.
003200     05  CHECK-INVOICE            PIC X(15).
003300     05  CHECK-VENDOR             PIC 9(5).
003400     05  CHECK-REFERENCE          PIC X(30).
003500     05  CHECK-CLEARED            PIC X.
003600
