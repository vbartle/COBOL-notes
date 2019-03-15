000100*---------------------------------
000200* FDCONTRL.CBL
000300* Primary Key - CONTROL-KEY
000400* LAST-VOUCHER is used
000500* to track the last
000600* used voucher number.
000700* This is a single record file
000800* CONTROL-KEY always = 1.
000900*---------------------------------
001000 FD  CONTROL-FILE
001100     LABEL RECORDS ARE STANDARD.
001200 01  CONTROL-RECORD.
001300     05  CONTROL-KEY              PIC 9.
001400     05  CONTROL-LAST-VOUCHER     PIC 9(5).
001500
