000100*---------------------------------
000200* USAGE:
000300*   MOVE TIME(hhmmss) TO TIME-HHMMSS.
000400*   PERFORM CHECK-TIME.
000500*
000600* RETURNS:
000700*   TIME-IS-VALID   (VALID)
000800*   TIME-IS-INVALID (BAD TIME )
000900*
001000* Assume that the time is good, then
001100* test the time in the following
001200* steps. The routine stops if any
001300* of these conditions is true,
001400* and sets the valid time flag to "N".
001500* 1.  Hours > 23
001600* 2.  Minutes > 59
001700* 3.  Seconds > 59
001800*---------------------------------
001900 CHECK-TIME.
002000     MOVE "Y" TO VALID-TIME-FLAG.
002100     IF TIME-HH > 23
002200         MOVE "N" TO VALID-TIME-FLAG
002300     ELSE
002400     IF TIME-MM > 59
002500         MOVE "N" TO VALID-TIME-FLAG
002600     ELSE
002700     IF TIME-SS > 59
002800         MOVE "N" TO VALID-TIME-FLAG.
002900
