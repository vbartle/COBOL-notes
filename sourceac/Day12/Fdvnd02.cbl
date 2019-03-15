000100*---------------------------------
000200* FDVND02.CBL
000300* Primary Key - VENDOR-NUMBER
000400* VENDOR-ADDRESS-2 not always used
000500*   so may be SPACES
000600* VENDOR-PHONE is usually the
000700*   number for VENDOR-CONTACT
000800* All fields should be entered in
000900*   UPPER case.
001000*---------------------------------
001100 FD  VENDOR-FILE
001200     LABEL RECORDS ARE STANDARD.
001300 01  VENDOR-RECORD.
001400     05  VENDOR-NUMBER            PIC 9(5).
001500     05  VENDOR-NAME              PIC X(30).
001600     05  VENDOR-ADDRESS-1         PIC X(30).
001700     05  VENDOR-ADDRESS-2         PIC X(30).
001800     05  VENDOR-CITY              PIC X(20).
001900     05  VENDOR-STATE             PIC X(2).
002000     05  VENDOR-ZIP               PIC X(10).
002100     05  VENDOR-CONTACT           PIC X(30).
002200     05  VENDOR-PHONE             PIC X(15).
002300
