IDENTIFICATION DIVISION.
PROGRAM-ID. AIRMAIN.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-CHOICE    PIC X.
01 WS-RUNNING   PIC X VALUE 'Y'.

PROCEDURE DIVISION.
0000-START.
    PERFORM UNTIL WS-RUNNING = 'N'
        PERFORM 1000-MENU
        ACCEPT WS-CHOICE
        EVALUATE WS-CHOICE
            WHEN '1' CALL 'FLIGHTMGR'
            WHEN '2' CALL 'PASSMGR'
            WHEN '3' CALL 'BOOKMGR'
            WHEN '4' MOVE 'N' TO WS-RUNNING
            WHEN OTHER
                DISPLAY '  Invalid option.'
        END-EVALUATE
    END-PERFORM
    STOP RUN.

1000-MENU.
    DISPLAY ' '
    DISPLAY '=============================='
    DISPLAY '    AIRLINE BOOKING SYSTEM    '
    DISPLAY '=============================='
    DISPLAY '  1. Flight Management'
    DISPLAY '  2. Passenger Management'
    DISPLAY '  3. Booking Management'
    DISPLAY '  4. Exit'
    DISPLAY '=============================='
    DISPLAY 'Select: ' WITH NO ADVANCING.
