000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. VNDNEW01.
000300*------------------------------------------------
000400* Add a record to an indexed Vendor File.
000500*------------------------------------------------
000600 ENVIRONMENT DIVISION.
000700 INPUT-OUTPUT SECTION.
000800 FILE-CONTROL.
000900
001000     SELECT VENDOR-FILE
001100         ASSIGN TO "vendor"
001200         ORGANIZATION IS INDEXED
001300         RECORD KEY IS VENDOR-NUMBER
001400         ACCESS MODE IS DYNAMIC.
001500
001600 DATA DIVISION.
001700 FILE SECTION.
001800
001900 FD  VENDOR-FILE
002000     LABEL RECORDS ARE STANDARD.
002100 01  VENDOR-RECORD.
002200     05  VENDOR-NUMBER                    PIC 9(5).
002300     05  VENDOR-NAME                      PIC X(30).
002400     05  VENDOR-ADDRESS-1                 PIC X(30).
002500     05  VENDOR-ADDRESS-2                 PIC X(30).
002600     05  VENDOR-CITY                      PIC X(20).
002700     05  VENDOR-STATE                     PIC X(2).
002800     05  VENDOR-ZIP                       PIC X(10).
002900     05  VENDOR-CONTACT                   PIC X(30).
003000     05  VENDOR-PHONE                     PIC X(15).
003100
003200 WORKING-STORAGE SECTION.
003300
003400 PROCEDURE DIVISION.
003500 PROGRAM-BEGIN.
003600     OPEN I-O VENDOR-FILE.
003700     PERFORM MAIN-PROCESS.
003800     CLOSE VENDOR-FILE.
003900
004000 PROGRAM-DONE.
004100     ACCEPT OMITTED. STOP RUN.
004200
004300 MAIN-PROCESS.
004400     PERFORM INIT-VENDOR-RECORD.
004500     PERFORM ENTER-VENDOR-FIELDS.
004600     WRITE VENDOR-RECORD.
004700
004800 INIT-VENDOR-RECORD.
004900     MOVE SPACE TO VENDOR-RECORD.
005000     MOVE ZEROES TO VENDOR-NUMBER.
005100
005200 ENTER-VENDOR-FIELDS.
005300     PERFORM ENTER-VENDOR-NUMBER.
005400     PERFORM ENTER-VENDOR-NAME.
005500     PERFORM ENTER-VENDOR-ADDRESS-1.
005600     PERFORM ENTER-VENDOR-ADDRESS-2.
005700     PERFORM ENTER-VENDOR-CITY.
005800     PERFORM ENTER-VENDOR-STATE.
005900     PERFORM ENTER-VENDOR-ZIP.
006000     PERFORM ENTER-VENDOR-CONTACT.
006100     PERFORM ENTER-VENDOR-PHONE.
006200
006300 ENTER-VENDOR-NUMBER.
006400     DISPLAY "ENTER VENDOR NUMBER (00001-99999)".
006500     ACCEPT VENDOR-NUMBER.
006600
006700 ENTER-VENDOR-NAME.
006800     DISPLAY "ENTER VENDOR NAME".
006900     ACCEPT VENDOR-NAME.
007000
007100 ENTER-VENDOR-ADDRESS-1.
007200     DISPLAY "ENTER VENDOR ADDRESS-1".
007300     ACCEPT VENDOR-ADDRESS-1.
007400
007500 ENTER-VENDOR-ADDRESS-2.
007600     DISPLAY "ENTER VENDOR ADDRESS-2".
007700     ACCEPT VENDOR-ADDRESS-2.
007800
007900 ENTER-VENDOR-CITY.
008000     DISPLAY "ENTER VENDOR CITY".
008100     ACCEPT VENDOR-CITY.
008200
008300 ENTER-VENDOR-STATE.
008400     DISPLAY "ENTER VENDOR STATE".
008500     ACCEPT VENDOR-STATE.
008600
008700 ENTER-VENDOR-ZIP.
008800     DISPLAY "ENTER VENDOR ZIP".
008900     ACCEPT VENDOR-ZIP.
009000
009100 E ,NTER-VENDOR-CONTACT.
009200     DISPLAY "ENTER VENDOR CONTACT".
009300     ACCEPT VENDOR-CONTACT.
009400
009500 ENTER-VENDOR-PHONE.
009600     DISPLAY "ENTER VENDOR PHONE".
009700     ACCEPT VENDOR-PHONE.
009800