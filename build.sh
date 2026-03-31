#!/bin/bash
set -e

mkdir -p bin data

echo ""
echo "  Building Airline Booking System..."
echo ""

cobc -free -x \
    -I copybooks \
    -o bin/airbooking \
    src/MAIN.cbl \
    src/FLIGHTMGR.cbl \
    src/PASSMGR.cbl \
    src/BOOKMGR.cbl

echo "  Build successful."
echo "  Run with: ./run.sh"
echo ""
