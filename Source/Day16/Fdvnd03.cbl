000100*---------------------------------
000200* FDVND03.CBL
000300* Primary Key - VENDOR-NUMBER
000400*
000500* NAME, ADDRESS-1, CITY, STATE,
000600*   and PHONE are required fields.
000700*
000800* VENDOR-STATE must be looked up
000900*   and must exist in the STATE-FILE
001000*   to be valid.
001100* VENDOR-ADDRESS-2 not always used
001200*   so may be SPACES
001300* VENDOR-PHONE is usually the
001400*   number for VENDOR-CONTACT
001500* All fields should be entered in
001600*   UPPER case.
001700*---------------------------------
001800 FD  VENDOR-FILE
001900     LABEL RECORDS ARE STANDARD.
002000 01  VENDOR-RECORD.
002100     05  VENDOR-NUMBER            PIC 9(5).
002200     05  VENDOR-NAME              PIC X(30).
002300     05  VENDOR-ADDRESS-1         PIC X(30).
002400     05  VENDOR-ADDRESS-2         PIC X(30).
002500     05  VENDOR-CITY              PIC X(20).
002600     05  VENDOR-STATE             PIC X(2).
002700     05  VENDOR-ZIP               PIC X(10).
002800     05  VENDOR-CONTACT           PIC X(30).
002900     05  VENDOR-PHONE             PIC X(15).
003000
