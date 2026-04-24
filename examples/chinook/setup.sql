
-- Chinook Database Setup Script

-- Crear la base de datos
CREATE DATABASE chinook;

\c chinook;

DROP TABLE IF EXISTS InvoiceLine;
DROP TABLE IF EXISTS PlaylistTrack;
DROP TABLE IF EXISTS Invoice;
DROP TABLE IF EXISTS Track;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Album;
DROP TABLE IF EXISTS Playlist;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS MediaType;
DROP TABLE IF EXISTS Genre;
DROP TABLE IF EXISTS Artist;

CREATE TABLE Artist (
    ArtistId INTEGER PRIMARY KEY,
    Name VARCHAR(120)
);

CREATE TABLE Genre (
    GenreId INTEGER PRIMARY KEY,
    Name VARCHAR(120)
);

CREATE TABLE MediaType (
    MediaTypeId INTEGER PRIMARY KEY,
    Name VARCHAR(120)
);

CREATE TABLE Employee (
    EmployeeId INTEGER PRIMARY KEY,
    LastName VARCHAR(20) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    Title VARCHAR(30),
    ReportsTo INTEGER,
    BirthDate TIMESTAMP,
    HireDate TIMESTAMP,
    Address VARCHAR(70),
    City VARCHAR(40),
    State VARCHAR(40),
    Country VARCHAR(40),
    PostalCode VARCHAR(10),
    Phone VARCHAR(24),
    Fax VARCHAR(24),
    Email VARCHAR(60),
    CONSTRAINT fk_employee_reports_to
        FOREIGN KEY (ReportsTo) REFERENCES Employee(EmployeeId)
);

CREATE TABLE Playlist (
    PlaylistId INTEGER PRIMARY KEY,
    Name VARCHAR(120)
);

CREATE TABLE Album (
    AlbumId INTEGER PRIMARY KEY,
    Title VARCHAR(160) NOT NULL,
    ArtistId INTEGER NOT NULL,
    CONSTRAINT fk_album_artist
        FOREIGN KEY (ArtistId) REFERENCES Artist(ArtistId)
);

CREATE TABLE Customer (
    CustomerId INTEGER PRIMARY KEY,
    FirstName VARCHAR(40) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Company VARCHAR(80),
    Address VARCHAR(70),
    City VARCHAR(40),
    State VARCHAR(40),
    Country VARCHAR(40),
    PostalCode VARCHAR(10),
    Phone VARCHAR(24),
    Fax VARCHAR(24),
    Email VARCHAR(60) NOT NULL,
    SupportRepId INTEGER,
    CONSTRAINT fk_customer_support_rep
        FOREIGN KEY (SupportRepId) REFERENCES Employee(EmployeeId)
);

CREATE TABLE Track (
    TrackId INTEGER PRIMARY KEY,
    Name VARCHAR(200) NOT NULL,
    AlbumId INTEGER NOT NULL,
    MediaTypeId INTEGER NOT NULL,
    GenreId INTEGER,
    Composer VARCHAR(220),
    Milliseconds INTEGER NOT NULL,
    Bytes INTEGER,
    UnitPrice NUMERIC(10,2) NOT NULL,
    CONSTRAINT fk_track_album
        FOREIGN KEY (AlbumId) REFERENCES Album(AlbumId),
    CONSTRAINT fk_track_media_type
        FOREIGN KEY (MediaTypeId) REFERENCES MediaType(MediaTypeId),
    CONSTRAINT fk_track_genre
        FOREIGN KEY (GenreId) REFERENCES Genre(GenreId)
);

CREATE TABLE Invoice (
    InvoiceId INTEGER PRIMARY KEY,
    CustomerId INTEGER NOT NULL,
    InvoiceDate TIMESTAMP NOT NULL,
    BillingAddress VARCHAR(70),
    BillingCity VARCHAR(40),
    BillingState VARCHAR(40),
    BillingCountry VARCHAR(40),
    BillingPostalCode VARCHAR(10),
    Total NUMERIC(10,2) NOT NULL,
    CONSTRAINT fk_invoice_customer
        FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

CREATE TABLE PlaylistTrack (
    PlaylistId INTEGER NOT NULL,
    TrackId INTEGER NOT NULL,
    PRIMARY KEY (PlaylistId, TrackId),
    CONSTRAINT fk_playlist_track_playlist
        FOREIGN KEY (PlaylistId) REFERENCES Playlist(PlaylistId) ON DELETE CASCADE,
    CONSTRAINT fk_playlist_track_track
        FOREIGN KEY (TrackId) REFERENCES Track(TrackId) ON DELETE CASCADE
);

CREATE TABLE InvoiceLine (
    InvoiceLineId INTEGER PRIMARY KEY,
    InvoiceId INTEGER NOT NULL,
    TrackId INTEGER NOT NULL,
    UnitPrice NUMERIC(10,2) NOT NULL,
    Quantity INTEGER NOT NULL,
    CONSTRAINT fk_invoice_line_invoice
        FOREIGN KEY (InvoiceId) REFERENCES Invoice(InvoiceId) ON DELETE CASCADE,
    CONSTRAINT fk_invoice_line_track
        FOREIGN KEY (TrackId) REFERENCES Track(TrackId)
);

COPY Artist FROM '/examples/chinook/data/Artist.csv' WITH (FORMAT csv, HEADER true, NULL '');
COPY Genre FROM '/examples/chinook/data/Genre.csv' WITH (FORMAT csv, HEADER true, NULL '');
COPY MediaType FROM '/examples/chinook/data/MediaType.csv' WITH (FORMAT csv, HEADER true, NULL '');
COPY Employee FROM '/examples/chinook/data/Employee.csv' WITH (FORMAT csv, HEADER true, NULL '');
COPY Playlist FROM '/examples/chinook/data/Playlist.csv' WITH (FORMAT csv, HEADER true, NULL '');
COPY Album FROM '/examples/chinook/data/Album.csv' WITH (FORMAT csv, HEADER true, NULL '');
COPY Customer FROM '/examples/chinook/data/Customer.csv' WITH (FORMAT csv, HEADER true, NULL '');
COPY Track FROM '/examples/chinook/data/Track.csv' WITH (FORMAT csv, HEADER true, NULL '');
COPY Invoice FROM '/examples/chinook/data/Invoice.csv' WITH (FORMAT csv, HEADER true, NULL '');
COPY PlaylistTrack FROM '/examples/chinook/data/PlaylistTrack.csv' WITH (FORMAT csv, HEADER true, NULL '');
COPY InvoiceLine FROM '/examples/chinook/data/InvoiceLine.csv' WITH (FORMAT csv, HEADER true, NULL '');