000100*---------------------------------
000200* FDVND04.CBL
000300* Primary Key - VENDOR-NUMBER
000400* Alternate - NAME with duplicates
000500
000600* NAME, ADDRESS-1, CITY, STATE,
000700*   and PHONE are required fields.
000800*
000900* VENDOR-STATE must be looked up
001000*   and must exist in the STATE-FILE
001100*   to be valid.
001200* VENDOR-ADDRESS-2 not always used
001300*   so may be SPACES
001400* VENDOR-PHONE is usually the
001500*   number for VENDOR-CONTACT
001600* All fields should be entered in
001700*   UPPER case.
001800*---------------------------------
001900 FD  VENDOR-FILE
002000     LABEL RECORDS ARE STANDARD.
002100 01  VENDOR-RECORD.
002200     05  VENDOR-NUMBER            PIC 9(5).
002300     05  VENDOR-NAME              PIC X(30).
002400     05  VENDOR-ADDRESS-1         PIC X(30).
002500     05  VENDOR-ADDRESS-2         PIC X(30).
002600     05  VENDOR-CITY              PIC X(20).
002700     05  VENDOR-STATE             PIC X(2).
002800     05  VENDOR-ZIP               PIC X(10).
002900     05  VENDOR-CONTACT           PIC X(30).
003000     05  VENDOR-PHONE             PIC X(15).
003100
003200
