000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. NEWVND01.
000300*------------------------------------------------
000400* Create an Empty Vendor File.
000500*------------------------------------------------
000600 ENVIRONMENT DIVISION.
000700 INPUT-OUTPUT SECTION.
000800 FILE-CONTROL.
000900
001000     COPY "SLOVND01.CBL".
001100
001200     COPY "SLVND02.CBL".
001300 DATA DIVISION.
001400 FILE SECTION.
001500
001600     COPY "FDOVND01.CBL".
001700
001800     COPY "FDVND04.CBL".
001900
002000 WORKING-STORAGE SECTION.
002100
002200 77  OLD-VENDOR-FILE-AT-END   PIC X VALUE "N".
002300
002400 PROCEDURE DIVISION.
002500 PROGRAM-BEGIN.
002600     PERFORM OPENING-PROCEDURE.
002700     PERFORM MAIN-PROCESS.
002800     PERFORM CLOSING-PROCEDURE.
002900
003000 PROGRAM-DONE.
003100     ACCEPT OMITTED. STOP RUN.
003200
003300 OPENING-PROCEDURE.
003400     OPEN OUTPUT VENDOR-FILE.
003500     OPEN I-O OLD-VENDOR-FILE.
003600
003700 CLOSING-PROCEDURE.
003800     CLOSE VENDOR-FILE.
003900     CLOSE OLD-VENDOR-FILE.
004000
004100 MAIN-PROCESS.
004200     PERFORM READ-NEXT-OLD-VENDOR-RECORD.
004300     PERFORM PROCESS-ONE-RECORD
004400         UNTIL OLD-VENDOR-FILE-AT-END = "Y".
004500
004600 READ-NEXT-OLD-VENDOR-RECORD.
004700     MOVE "N" TO OLD-VENDOR-FILE-AT-END.
004800     READ OLD-VENDOR-FILE NEXT RECORD
004900         AT END
005000         MOVE "Y" TO OLD-VENDOR-FILE-AT-END.
005100
005200 PROCESS-ONE-RECORD.
005300     MOVE OLD-VENDOR-RECORD TO VENDOR-RECORD.
005400     PERFORM WRITE-VENDOR-RECORD.
005500
005600     PERFORM READ-NEXT-OLD-VENDOR-RECORD.
005700
005800 WRITE-VENDOR-RECORD.
005900     WRITE VENDOR-RECORD
006000         INVALID KEY
006100         DISPLAY "ERROR WRITING VENDOR RECORD".
006200
006300
