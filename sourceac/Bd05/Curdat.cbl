000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. CURDAT.
000300 AUTHOR. MO BUDLONG.
000400 INSTALLATION.
000500 DATE-WRITTEN. 09/07/96.
000600 DATE-COMPILED.
000700 SECURITY. NONE
000800 ENVIRONMENT DIVISION.
000900 INPUT-OUTPUT SECTION.
001000 FILE-CONTROL.
001100 DATA DIVISION.
001200 FILE SECTION.
001300 WORKING-STORAGE SECTION.
001400
001500 01  CD-DATE                  PIC X(21).
001600 01  FILLER REDEFINES CD-DATE.
001700     05  CD-CYMD              PIC 9(8).
001800     05  CD-HMSD              PIC 9(8).
001900     05  CD-GMT-OFF           PIC S9(4) SIGN LEADING SEPARATE.
002000     05  FILLER REDEFINES CD-GMT-OFF.
002100         10  CD-GMT-OFF-SIGN  PIC X.
002200         10  CD-GMT-OFF-HM    PIC 9(4).
002300
002400 01  CD-MDCY                     PIC 9(8).
002500 01  CD-FORMATTED-MDCY           PIC Z9/99/9999.
002600 01  CD-FORMATTED-HMSD           PIC Z9/99/99/99.
002700 01  CD-FORMATTED-GMT-OFF        PIC 99/99.
002800
002900 01  DUMMY     PIC X.
003000
003100 PROCEDURE DIVISION.
003200 MAIN-LOGIC SECTION.
003300 PROGRAM-BEGIN.
003400
003500     PERFORM OPENING-PROCEDURE.
003600     PERFORM MAIN-PROCESS.
003700     PERFORM CLOSING-PROCEDURE.
003800
003900 EXIT-PROGRAM.
004000     EXIT PROGRAM.
004100 STOP-RUN.
004200     ACCEPT OMITTED. STOP RUN.
004300
004400
004500 THE-OTHER SECTION.
004600
004700 OPENING-PROCEDURE.
004800 CLOSING-PROCEDURE.
004900 MAIN-PROCESS.
005000
005100     MOVE FUNCTION CURRENT-DATE TO CD-DATE.
005200
005300     DISPLAY CD-DATE.
005400     COMPUTE CD-MDCY = CD-CYMD * 10000.0001.
005500     MOVE CD-MDCY TO CD-FORMATTED-MDCY.
005600     MOVE CD-HMSD TO CD-FORMATTED-HMSD.
005700     INSPECT CD-FORMATTED-HMSD REPLACING ALL '/' BY ':'.
005800     MOVE CD-GMT-OFF-HM TO CD-FORMATTED-GMT-OFF.
005900     INSPECT CD-FORMATTED-GMT-OFF REPLACING ALL '/' BY ':'.
006000     DISPLAY "DATE       = " CD-FORMATTED-MDCY.
006100     DISPLAY "TIME       = " CD-FORMATTED-HMSD.
006200     DISPLAY "GMT OFFSET = " CD-GMT-OFF-SIGN CD-FORMATTED-GMT-OFF.
006300     ACCEPT DUMMY.
006400
