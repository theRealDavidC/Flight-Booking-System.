# Airline Booking System

A terminal-based airline booking system written in COBOL using indexed sequential (ISAM) files as the database the classic COBOL data store.

## Requirements

Install GnuCOBOL (free, runs on Linux, macOS, Windows):

```bash
# Ubuntu / Debian
sudo apt install gnucobol

# macOS
brew install gnu-cobol

# Windows
# Download installer from https://gnucobol.sourceforge.io
```

## Build & Run

```bash
chmod +x build.sh run.sh
./build.sh
./run.sh
```

## Project Structure

```
airplane-booking/
├── src/
│   ├── MAIN.cbl        Entry point and main menu
│   ├── FLIGHTMGR.cbl   Flight management
│   ├── PASSMGR.cbl     Passenger management
│   └── BOOKMGR.cbl     Booking management
├── copybooks/
│   ├── FLIGHT-REC.cpy  Flight record layout
│   ├── PASSENGER-REC.cpy  Passenger record layout
│   └── BOOKING-REC.cpy Booking record layout
├── data/               ISAM database files (auto-created on first run)
├── bin/                Compiled binary (auto-created)
├── build.sh
└── run.sh
```

## Database

Data is stored in ISAM indexed files under `data/`:

| File             | Key            | Description           |
|------------------|----------------|-----------------------|
| FLIGHTS.dat      | Flight ID      | Flight schedules      |
| PASSENGERS.dat   | Passenger ID   | Registered passengers |
| BOOKINGS.dat     | Booking Ref    | Reservations          |
| PAXSEQ.dat       | -              | Passenger ID counter  |
| BKGSEQ.dat       | -              | Booking ref counter   |

Files are created automatically on first run.

## Usage Guide

### Workflow

1. **Add flights** via Flight Management → Add Flight
2. **Register passengers** via Passenger Management → Register Passenger
3. **Create bookings** via Booking Management → Create Booking (you need a Passenger ID and Flight ID)

### Input Formats

| Field          | Format                    | Example    |
|----------------|---------------------------|------------|
| Flight ID      | 6 alphanumeric characters | ET101A     |
| Flight Number  | Up to 8 characters        | ET-0101    |
| IATA Code      | 3 uppercase letters       | ADD        |
| Date           | YYYYMMDD                  | 20250315   |
| Time           | HHMM (24h)                | 1430       |
| Price          | Decimal number            | 350.00     |
| Class          | Single letter             | E, B, or F |

### Booking Classes

- `E` - Economy
- `B` - Business
- `F` - First Class

### Status Codes

- Flight Status: `A` = Active, `C` = Cancelled
- Booking Status: `C` = Confirmed, `X` = Cancelled

## Data Record Layouts

**Flight Record** - 52 bytes
```
FLT-ID           X(6)    Unique flight identifier
FLT-NUMBER       X(8)    Airline flight number
FLT-ORIGIN       X(3)    Departure IATA airport code
FLT-DESTINATION  X(3)    Arrival IATA airport code
FLT-DEP-DATE     X(8)    Departure date YYYYMMDD
FLT-DEP-TIME     X(4)    Departure time HHMM
FLT-ARR-TIME     X(4)    Arrival time HHMM
FLT-TOTAL-SEATS  9(3)    Total seat capacity
FLT-AVAIL-SEATS  9(3)    Remaining available seats
FLT-PRICE        9(7)V99 Ticket price
FLT-STATUS       X(1)    A=Active C=Cancelled
```

**Passenger Record** - 115 bytes
```
PAX-ID           X(8)    Auto-generated (PA000001)
PAX-FIRST-NAME   X(20)   First name
PAX-LAST-NAME    X(20)   Last name
PAX-PASSPORT     X(12)   Passport number (unique key)
PAX-EMAIL        X(40)   Email address
PAX-PHONE        X(15)   Phone number
```

**Booking Record** - 45 bytes
```
BKG-REF          X(8)    Auto-generated (BK000001)
BKG-FLIGHT-ID    X(6)    Reference to flight
BKG-PAX-ID       X(8)    Reference to passenger
BKG-SEAT         X(4)    Seat assignment (e.g. E003)
BKG-DATE         X(8)    Booking date YYYYMMDD
BKG-STATUS       X(1)    C=Confirmed X=Cancelled
BKG-CLASS        X(1)    E=Economy B=Business F=First
BKG-AMOUNT       9(7)V99 Amount charged
```
