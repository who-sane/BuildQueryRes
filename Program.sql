-- Hussein Hussein 
-- 103615588

-- Task 1 

/* 

Tour(TourName, Descriotion)
PRIMARY KEY(TourName)

Client(ClientID, Surname, GivenName, Gender)
PRIMARY KEY(ClientID)

Event(TourName, EventYear, EventMonth, EventDay, Fee)
PRIMARY KEY(TourName, EventYear, EventMonth, EventDay)
FOREIGN KEY(TourName) REFERENCES Tour

Booking(ClientID, TourName, EventYear, EventMonth, EventDay, Payment, DateBooked)
PRIMARY KEY(EventYear, EventMonth, EventDay, ClientID)
FOREIGN KEY(TourName, EventYear, EventMonth, EventDay) REFERENCES Event
FOREIGN KEY(ClientID) REFERENCES Client

*/

-- Task 2 

USE BuildQueryRes

DROP TABLE IF EXISTS TOUR, Client, Event, Booking;

CREATE TABLE TOUR(
    TourName NVARCHAR(100),
    Descriotion NVARCHAR(500),
    PRIMARY KEY(TourName)
);

CREATE TABLE Client(
    ClientID INT,
    Surname NVARCHAR(100) NOT NULL,
    GivenName NVARCHAR(100) NOT NULL,
    Gender Nvarchar(1)
    PRIMARY KEY(ClientID),
    CONSTRAINT CHK_GENDER CHECK (Gender IN ('M','F','I')),
);

CREATE TABLE Event(TourName NVARCHAR(100), 
    EventYear INT, 
    EventMonth INT , 
    EventDay INT,
    Fee MONEY NOT NULL, 
    PRIMARY KEY (TourName, EventYear, EventMonth, EventDay),
    FOREIGN KEY(TourName) REFERENCES TOUR,
    CONSTRAINT chk_months CHECK (EventMonth IN('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
    CONSTRAINT chk_days CHECK (EventDay >=1 AND EventDay < 32),
    CONSTRAINT chk_year_len CHECK(LEN (EventYear) = 4),
    CONSTRAINT chk_fee CHECK (Fee > 0)
    );

CREATE TABLE Booking(ClientID INT,
    TourName NVARCHAR(100), 
    EventYear INT, 
    EventMonth INT, 
    EventDay INT, 
    Payment MONEY ,
    DateBooked DATE NOT NULL 
    PRIMARY KEY(ClientID, TourName, EventYear, EventMonth, EventDay),
    FOREIGN KEY(TourName, EventYear, EventMonth, EventDay) REFERENCES Event,
    FOREIGN KEY(ClientID) REFERENCES Client,
    CONSTRAINT chk_booking_months CHECK (EventMonth IN('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
    CONSTRAINT chk_booking_days CHECK (EventDay >=1 AND EventDay < 32),
    CONSTRAINT chk_booking_year_len CHECK(LEN (EventYear) = 4),
    CONSTRAINT chk_booking_payment CHECK (Payment > 0)
);

SELECT NAME 
FROM sys.objects 
WHERE TYPE = 'U'


