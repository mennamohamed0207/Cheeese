;Author: Aliaa Gheis
;DATE:
;This Progam
;======================
;======================

                ;  0    1    2    3    4    5    6    7        rows
                ;  0    0    1    2    3    4    5    6    7
                ;  1    8    ............................ 15
                ;  2    16   ...............................
                ;  3    ....................................
                ;  4    ....................................   
                ;  5    ....................................
                ;  6    ....................................
                ;  7    56..............................  63

                ;       0     1    2    3    4    5    6    7        rows
                ;  0    0     25   50   75   100  125  150  175
                ;  1    320   345  370  395  420  445  470  495
                ;  2    640   .................................
                ;  3    960   .................................
                ;  4    1280  .................................  
                ;  5    1600  .................................
                ;  6    1920  .................................
                ;  7    2240  ............................ 2415
        
        .286
        .MODEL HUGE
        .STACK 256
.DATA
        color          db  15, 9
        highlightColor equ 72
        highlightPeiceMvs db ?, 64, 80
        boardWidth     equ 23
        imageWidth     equ 23
        ; ____ game peice ____ ;
        emptyCell      equ 0
        pawn           equ 1
        rook           equ 2
        knight         equ 3
        bishop         equ 4
        queen          equ 5
        king           equ 6
        ; ____ peice color ____ ;
        black          equ 8
        white          equ 0
        ; ____ peice mask ____ ;
        peice          equ 7
        ;______pawn directions_____;
        pawnDir         db ?, +8, -8
        ;____ players _____;
        player1         equ 1
        player2         equ 2
        playerMoveToChoosePeice equ 0
        playerMoveToChooseAction equ 1

        playersState db ?, playerMoveToChoosePeice, playerMoveToChoosePeice

        playerCells db ?, 0, 56
        playerRows  db ?, 0, 7
        playerCols  db ?, 0, 0
        PlayerPos   dw ?, 0, 51520

        validateMoves db 64 dup(0)
        ; ____ board ____ ;
        board          db  rook+black, knight+black, bishop+black, queen+black, king+black, bishop+black, knight+black, rook+black
                       db  8 dup(pawn+black)
                       db  4 dup(8 dup(emptyCell))
                       db  8 dup(pawn)
                       db  rook, knight, bishop, queen, king, bishop, knight, rook

Bpawn DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4 
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4



Wpawn DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 16, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 16, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4



Brook DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 4, 16, 16, 16, 16, 4, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4



Wrook DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4 
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 4, 16, 16, 16, 16, 4, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 15, 15, 16, 16, 15, 15, 15, 16, 16, 16, 15, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4



Bknight DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 4, 4, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 15, 16, 16, 16, 16, 16, 16, 16, 16, 15, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 15, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 16, 16, 4, 4, 4, 4
 DB 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 15, 16, 4, 4, 4, 4
 DB 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 16, 4, 4, 4, 4
 DB 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 16, 16, 4, 4, 4
 DB 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 16, 16, 4, 4, 4
 DB 4, 16, 16, 16, 16, 16, 16, 16, 4, 16, 16, 16, 16, 16, 16, 16, 16, 15, 16, 16, 4, 4, 4
 DB 4, 4, 16, 16, 16, 16, 16, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 15, 16, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 15, 16, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 15, 16, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 15, 16, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 15, 16, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4



Wknight DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 4, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 15, 15, 15, 15, 15, 15, 15, 16, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4
 DB 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 16, 16, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4
 DB 4, 4, 16, 15, 15, 15, 15, 15, 15, 16, 16, 16, 15, 15, 15, 15, 15, 15, 16, 4, 4, 4, 4
 DB 4, 16, 16, 16, 15, 15, 15, 15, 16, 16, 16, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4
 DB 4, 16, 16, 15, 15, 15, 15, 16, 16, 16, 16, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4
 DB 4, 16, 16, 16, 16, 16, 16, 16, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4
 DB 4, 4, 16, 16, 16, 16, 16, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4



Bbishop DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 15, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 15, 15, 15, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 15, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4
 DB 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4
 DB 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4



Wbishop DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 15, 15, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 16, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 16, 16, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4
 DB 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4
 DB 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4



Bqueen DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 4, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4
 DB 16, 16, 16, 16, 16, 16, 16, 16, 4, 16, 16, 16, 4, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4
 DB 16, 16, 16, 16, 4, 16, 16, 16, 4, 16, 16, 16, 4, 16, 16, 16, 4, 16, 16, 16, 16, 4, 4
 DB 16, 16, 16, 16, 4, 16, 16, 16, 4, 16, 16, 16, 16, 16, 16, 16, 4, 16, 16, 16, 4, 4, 4
 DB 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 16, 16, 16, 16, 16, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 15, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 15, 15, 16, 16, 16, 16, 16, 16, 16, 15, 15, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 15, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 15, 15, 15, 15, 16, 16, 16, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4



Wqueen DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 16, 16, 4, 4, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 4, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 16, 16, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 16, 16, 4, 4, 4
 DB 16, 16, 16, 16, 16, 16, 16, 16, 4, 16, 16, 16, 4, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4
 DB 16, 16, 16, 16, 4, 16, 16, 16, 4, 16, 16, 16, 4, 16, 16, 16, 4, 16, 16, 16, 16, 4, 4
 DB 16, 16, 16, 16, 4, 16, 16, 16, 4, 16, 16, 16, 4, 16, 16, 16, 4, 16, 16, 16, 16, 4, 4
 DB 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4
 DB 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 15, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 16, 16, 16, 16, 16, 15, 16, 16, 15, 16, 16, 15, 15, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 16, 16, 15, 16, 16, 15, 16, 16, 15, 15, 16, 15, 15, 16, 15, 16, 16, 4, 4, 4, 4
 DB 4, 4, 16, 16, 15, 16, 16, 15, 16, 16, 16, 16, 16, 15, 16, 16, 15, 16, 16, 4, 4, 4, 4
 DB 4, 4, 16, 16, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 15, 15, 15, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4



Bking DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 16, 16, 15, 15, 15, 16, 16, 16, 16, 16, 16, 16, 15, 15, 15, 15, 16, 4, 4, 4, 4
 DB 4, 16, 15, 15, 16, 16, 16, 15, 15, 16, 16, 16, 15, 15, 16, 16, 16, 16, 15, 16, 4, 4, 4
 DB 4, 16, 15, 16, 16, 16, 16, 16, 16, 15, 16, 15, 16, 16, 16, 16, 16, 16, 15, 16, 4, 4, 4
 DB 4, 16, 15, 16, 16, 16, 16, 16, 16, 16, 15, 15, 16, 16, 16, 16, 16, 16, 15, 16, 4, 4, 4
 DB 4, 16, 15, 16, 16, 16, 16, 16, 16, 16, 15, 16, 16, 16, 16, 16, 16, 16, 15, 16, 4, 4, 4
 DB 4, 4, 16, 15, 16, 16, 16, 16, 16, 16, 15, 16, 16, 16, 16, 16, 16, 15, 16, 16, 4, 4, 4
 DB 4, 4, 16, 16, 15, 15, 15, 15, 15, 16, 16, 16, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 15, 15, 16, 16, 16, 16, 16, 16, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 15, 15, 15, 15, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 15, 15, 16, 16, 16, 16, 16, 16, 16, 15, 15, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 15, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 15, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4



Wking DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4 
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 16, 16, 15, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 15, 15, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 16, 16, 16, 15, 15, 16, 16, 16, 15, 15, 16, 16, 16, 15, 15, 16, 16, 16, 4, 4, 4
 DB 4, 16, 16, 15, 15, 15, 15, 15, 16, 16, 15, 15, 16, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4
 DB 4, 16, 16, 15, 15, 15, 15, 15, 15, 16, 16, 16, 15, 15, 15, 15, 15, 15, 15, 16, 4, 4, 4
 DB 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 16, 15, 15, 15, 15, 15, 15, 15, 15, 16, 4, 4, 4
 DB 4, 16, 16, 15, 15, 15, 15, 15, 15, 15, 16, 15, 15, 15, 15, 15, 15, 15, 16, 16, 4, 4, 4
 DB 4, 4, 16, 16, 15, 15, 15, 15, 15, 15, 16, 15, 15, 15, 15, 15, 15, 16, 16, 16, 4, 4, 4
 DB 4, 4, 4, 16, 16, 16, 16, 16, 16, 15, 15, 15, 16, 16, 16, 15, 16, 16, 16, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 15, 15, 15, 15, 16, 15, 15, 15, 15, 16, 16, 16, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 15, 15, 16, 16, 16, 16, 16, 15, 15, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 16, 16, 16, 16, 16, 15, 15, 15, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 16, 16, 16, 16, 16, 16, 16, 16, 16, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4
 DB 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4        

.code

waitSec PROC   FAR                                                ;ax = row, cx = col =>>>> ax = current start point
                    push     ax

                    mov      ah, 07
                    int      21h

                    pop      ax
                    RET
waitSec ENDP     


;_____________________________;
;____________Graphics_________________;
;_____________________________;
DrawGrid    PROC FAR
            pusha
            mov si, 0
            mov di, 0
            mov cx, 8

;___ draw rank by rank ____;
lr:     push cx 
        mov cx, boardWidth
        ;___ draw line ____;
        lh: push cx
                mov cx, 8   
                ;___ draw square line ___; 
                lw:
                        push cx

                        mov al, color[si];color
                        mov cx, boardWidth   ;width
                        REP STOSB        ;draw a width of square
                        XOR si, 1        ;toggle color for next square
                        

                        pop cx
                loop lw
                add di, 320-8*boardWidth
                pop cx
        loop lh
        XOR si, 1        ;toggle color for next square
        pop cx
loop lr
            
            popa
            RET
DrawGrid ENDP 

DrawImg     PROC         ;bx = offset img, di = startPoint
            pusha

            mov cx, imageWidth
            

lp1:    push cx
        mov cx, imageWidth
        lp2:    mov al, [bx]
                cmp al, 4
                je skip

                mov es:[di], al

        skip:   inc di
                inc bx
        loop    lp2
        add di, 320-imageWidth
        pop cx
loop lp1
            popa
            RET
DrawImg ENDP 

DrawBoard       PROC    FAR
                pusha 
                mov si, 0 ;cell      
                mov di, 0 ;position
                mov cx, 8
        DrawBoardLoop1: push cx
                        mov cx, 8
                        DrawBoardLoop2:
                                lea bx, Bpawn
                                mov ah, 0
                                mov al, board[si]
                                cmp ax, emptyCell
                                je DONTDRAWIMG
                                mov dx, ax

                                and ax, 7;peice type
                                shl ax, 1;2*p
                                sub ax, 1;2*p-1

                                and dx, 8;peice color
                                shr dx, 3

                                sub ax, dx;

                                mov dx, boardWidth*boardWidth
                                mul dx
                                add bx, ax
                                CALL DrawImg

                        DONTDRAWIMG:    inc si
                                        add di, boardWidth
                        loop DrawBoardLoop2
                        add di, 320*boardWidth-boardWidth*8

        pop cx
        loop DrawBoardLoop1
                popa
                RET
DrawBoard       ENDP     

Available_BackGround    PROC ;di = position, al = highlight color
        pusha                
                mov cx,boardWidth            ;height
                highlightLoop: push cx
                        ;draw line 
                        mov  cx, boardWidth          ;width   
                        REP  STOSB 
                        sub  di,boardWidth           
                        add  di,320     
                        pop cx
                loop highlightLoop
        popa
        RET
Available_BackGround ENDP 


DrawHighlightedMvs      PROC    FAR
                        pusha 
                        mov si, 0 ;cell      
                        mov di, 0 ;position
                        mov cx, 8
        DrawHIGH1: push cx
                        mov cx, 8
                        DrawHIGH2:
                                mov ah, 0
                                mov al, validateMoves[si]       ;al = player
                                cmp al, 1                       ;if zero skip
                                jl DONTDRAWIMGHIGHT

                                push di
                                mov di, ax                      ;di = ax = player
                                mov al, highlightPeiceMvs[di]   ;al = highlightcolor of player
                                pop di
                                CALL Available_BackGround       ;
                        DONTDRAWIMGHIGHT:    inc si
                                        add di, boardWidth
                        loop DrawHIGH2
                        add di, 320*boardWidth-boardWidth*8

        pop cx
        loop DrawHIGH1
popa
RET
DrawHighlightedMvs      ENDP
;________ __________ ___________;
;________ __________ ___________;
;________ validators ___________;
;________ __________ ___________;
;________ __________ ___________;

ValidatePawn    Proc ;al = row cl = col si = player di = cell
                cmp si, player1
                jne cmpPlayer2
                mov validateMoves[di+8], 1
                RET
        cmpPlayer2:  
                mov validateMoves[di-8], 2   
                RET
ValidatePawn    ENDP 


ValidateRook    Proc ;al = row cl = col si = player di = cell
                mov ax, si

                mov validateMoves[19], al
                RET
ValidateRook    ENDP 


ValidateBishop  Proc ;al = row cl = col si = player di = cell
                mov validateMoves[18], 1

                RET
ValidateBishop  ENDP 


ValidateKnight  Proc ;al = row cl = col si = player di = cell
                mov validateMoves[17], 1

                RET
ValidateKnight  ENDP 


ValidateQueen   Proc ;al = row cl = col si = player di = cell
                CALL ValidateBishop
                CALL ValidateRook
                RET
ValidateQueen   ENDP 


ValidateKing    Proc ;al = row cl = col si = player di = cell
                mov validateMoves[16], 1
                RET
ValidateKing    ENDP 
;_____________________________;
;____________MOVEs_________________;
;_____________________________;
MoveLeft        PROC FAR;si = player numbers
                cmp PlayerCols[si], 0
                je EXITMOVELEFT
                sub playerCols[si], 1
                sub playerCells[si],  1
                add si, si
                sub PlayerPos[si], boardWidth
EXITMOVELEFT:   RET
MoveLeft        ENDP ;si = player numbers

MoveRight       PROC FAR;si = player numbers
                cmp playerCols[si], 7
                je EXITMOVERIGHT
                add playerCols[si], 1
                add playerCells[si],  1

                add si, si
                add PlayerPos[si], boardWidth
EXITMOVERIGHT:  RET
MoveRight       ENDP ;si = player numbers


MoveUp          PROC FAR;si = player numbers
                cmp playerRows[si], 0
                je EXITMOVEUP
                sub playerRows[si], 1
                sub playerCells[si],  8
                add si, si
                sub PlayerPos[si], 320*boardWidth
EXITMOVEUP:     RET
MoveUp          ENDP ;si = player numbers


MoveDown        PROC FAR;si = player numbers
                cmp playerRows[si], 7
                je EXITMOVEDOWN
                add playerRows[si], 1
                add playerCells[si],  8
                add si, si
                add PlayerPos[si], 320*boardWidth
EXITMOVEDOWN:   RET
MoveDown        ENDP ;si = player numbers


SelectValidationOfPeice PROC FAR ;si = player number ;
                        mov al, playerCells[si]; player on which cell
                        mov ah, 0
                        mov di, ax

                        mov al, playerRows[si]
                        mov cl, playerCols[si]

                        mov dl, board[di]
                        and dl, peice
                cmp dl, emptyCell
                jne chkPawn
                RET
                chkPawn:        cmp dl, pawn
                                jne chkRook
                                CALL ValidatePawn
                                RET
                chkRook:        cmp dl, rook
                                jne chkKnight
                                CALL ValidateRook
                                RET     
                chkKnight:      cmp dl, knight
                                jne chkBishop
                                CALL ValidateKnight
                                RET             
                chkBishop:      cmp dl, bishop
                                jne chkQueen
                                CALL ValidateBishop
                                RET             
                chkQueen:       cmp dl, queen
                                jne chkKing
                                CALL ValidateQueen
                                RET            
                chkKing:        cmp dl, king
                                jne EXITSelecttValidationOfPeice
                                CALL ValidateKing       

EXITSelecttValidationOfPeice:   RET           
ENDP    SelectValidationOfPeice



MAIN PROC FAR
        MOV      AX, @DATA
        MOV      DS, AX

        mov      ax, 0a000h                        ;for inline drawing
        mov      es, ax

        mov ax, 0003h                                  ; clear screen
        int 10H

        mov      ax, 0013h                         ; to video mode
        int      10h
        ; ____ inialize video mode ____;

        ;___ position player1 al =row    cl=col   =>di=StartPos ___;
        
MAIN_LOOP:
        CALL DrawGrid 


        mov di, PlayerPos[2]
        mov al, highlightColor
        CALL Available_BackGround
        
        mov di, PlayerPos[4]
        mov al, highlightColor
        CALL Available_BackGround

        CALL DrawHighlightedMvs

        CALL     DrawBoard

        mov ah, 01
        int 16h
        jnz MAIN_LOOP

        mov ah, 0
        int 16h

        ;or al, 00100000b ;capital letter
        mov si, 1
        cmp al, 'w'
        jne pressA
        Call MoveUp
        jmp MAIN_LOOP
        
        pressA: cmp al, 'a'
                jne pressS
                CALL MoveLeft
                shrt: jmp MAIN_LOOP

        pressS: cmp al, 's'
                jne pressD
                CALL MoveDown
                jmp MAIN_LOOP

        pressD: cmp al, 'd'         ;right
                jne pressQ
                CALL MoveRight
                jmp MAIN_LOOP

        pressQ:         cmp al, 'q'
                        jne pressUp
                        cmp playersState[1], playerMoveToChoosePeice
                        jne pressUp
                        CALL SelectValidationOfPeice
                        jmp MAIN_LOOP
                        ;_________ highlight moves _____;


        pressUp:        mov si, 2
                        cmp ah, 48h
                        jne pressLeft
                        CALL MoveUp
                        jmp MAIN_LOOP

        pressLeft:      cmp ah, 4bh
                        jne pressDown
                        Call MoveLeft
                        jmp MAIN_LOOP

        pressDown:      cmp ah, 50h  
                        jne pressRight
                        CALL MoveDown
                        jmp MAIN_LOOP

        pressRight:     cmp ah, 4dh
                        jne pressZero
                        CALL MoveRight
                        jmp shrt
                        
        pressZero:      cmp al, '0'
                        jne shrt
                        cmp playersState[2], playerMoveToChoosePeice
                        jne shrt
                        CALL SelectValidationOfPeice
                        
jmp shrt
     
        ;__end___;
        CALL     waitSec
        CALL     waitSec
        MOV      AH, 4CH
        INT      21H
MAIN ENDP
;_______ inialize board ___________;   




;________ __________ ___________;
;________ __________ ___________;
;________ utilis ___________;
;________ __________ ___________;
;________ __________ ___________;







RowColToCell    PROC ;al = row  cl = col  =>> si = CellNumber
                push ax

                shl al, 3  ; al = al*8
                add al, cl ; al = al*8 + col

                sub ah, ah
                mov si, ax


                pop ax
                RET
RowColToCell ENDP 

RowColToStartPos PROC ;al =row    cl=col   =>di=StartPos

        push ax
        push bx
        push cx
        push dx

        mov dl,al               ;dl = row
        mov al,boardWidth       ;al = width|hight
        mul cl                  ;al = width*col
        mov bx,ax               ;bx = width*col

        mov ax,320*boardWidth   ;ax=320*hight
        mul dx                  ;ax=320*hight*row

        mov di,ax               ;di=320*row*hight
        add  di,bx              ;di=320*row*hight+width*col

        pop dx       
        pop cx       
        pop bx       
        pop ax       
        RET
RowColToStartPos ENDP 




;; [move => cell] XOR validateMoves[cell], player

END MAIN
 

