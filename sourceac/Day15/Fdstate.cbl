000100*---------------------------------
000200* FDSTATE.CBL
000300* Primary Key - STATE-CODE
000400* NAME is required
000500* NAME and CODE should be upper case
000600*---------------------------------
000700 FD  STATE-FILE
000800     LABEL RECORDS ARE STANDARD.
000900 01  STATE-RECORD.
001000     05  STATE-CODE               PIC X(2).
001100     05  STATE-NAME               PIC X(20).
001200
