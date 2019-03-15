000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. EIGER02.
000300 ENVIRONMENT DIVISION.
000400 DATA DIVISION.
000500
000600 WORKING-STORAGE SECTION.
000700
000800 01  THE-MESSAGE      PIC X(50).
000900 01  THE-NUMBER       PIC 9(2).
001000 01  A-SPACE          PIC X.
001100
001200 PROCEDURE DIVISION.
001300 PROGRAM-BEGIN.
001400
001500* Initialize the space variable
001600     MOVE " " TO A-SPACE.
001700
001800* Set up and display line 1
001900     MOVE 5 TO THE-NUMBER.
002000     MOVE "There once was a lady from Eiger,"
002100         TO THE-MESSAGE.
002200     DISPLAY
002300         THE-NUMBER
002400         A-SPACE
002500         THE-MESSAGE.
002600
002700* Set up and Display line 2
002800     ADD 5 TO THE-NUMBER.
002900     MOVE "Who smiled and rode forth on a tiger."
003000         TO THE-MESSAGE.
003100     DISPLAY
003200         THE-NUMBER
003300         A-SPACE
003400         THE-MESSAGE.
003500
003600* Set up and display line 3
003700     ADD 5 TO THE-NUMBER.
003800     MOVE "They returned from the ride" TO THE-MESSAGE.
003900     DISPLAY
004000         THE-NUMBER
004100         A-SPACE
004200         THE-MESSAGE.
004300
004400* Set up and display line 4
004500     ADD 5 TO THE-NUMBER.
004600     MOVE "With the lady inside," TO THE-MESSAGE.
004700     DISPLAY
004800         THE-NUMBER
004900         A-SPACE
005000         THE-MESSAGE.
005100
005200* Set up and display line 5
005300     ADD 5 TO THE-NUMBER.
005400     MOVE "And the smile on the face of the tiger."
005500         TO THE-MESSAGE.
005600     DISPLAY
005700         THE-NUMBER
005800         A-SPACE
005900         THE-MESSAGE.
006000
006100
006200 PROGRAM-DONE.
006300     ACCEPT OMITTED. STOP RUN.
006400
