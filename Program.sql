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
IF OBJECT_ID('TOUR') IS NOT NULL
    DROP TABLE TOUR;
IF OBJECT_ID('TOUR') IS NULL
    DROP TABLE TOUR;
IF OBJECT_ID('Client') IS NOT NULL
    DROP TABLE Client;
IF OBJECT_ID('Booking') IS NOT NULL
    DROP TABLE Booking;

GO

CREATE TABLE TOUR (
    TourName NVARCHAR(100),
    Descriotion NVARCHAR(500),
    PRIMARY KEY(TourName)
);

CREATE TABLE Client (
    ClientID INT,
    Surname NVARCHAR(100) NOT NULL,
    GivenName NVARCHAR(100) NOT NULL,
    Gender Nvarchar(1),
    PRIMARY KEY(ClientID),
    CONSTRAINT CHK_GENDER CHECK (Gender IN ('M','F','I')),
);

CREATE TABLE Events ( 
    TourName NVARCHAR(100),
    EventYear INT, 
    EventMonth Nvarchar(3) , 
    EventDay INT,
    Fee MONEY NOT NULL, 
    PRIMARY KEY (TourName, EventYear, EventMonth, EventDay),
    FOREIGN KEY(TourName) REFERENCES TOUR,
    CONSTRAINT chk_event_months CHECK (EventMonth IN('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
    CONSTRAINT chk_event_days CHECK (EventDay >=1 AND EventDay < 32),
    CONSTRAINT chk_event_year_len CHECK(LEN (EventYear) = 4),
    CONSTRAINT chk_event_fee CHECK (Fee > 0)
    );

CREATE TABLE Booking (ClientID INT,
    TourName NVARCHAR(100), 
    EventYear INT, 
    EventMonth Nvarchar(3), 
    EventDay INT, 
    Payment MONEY ,
    DateBooked DATE NOT NULL 
    PRIMARY KEY(ClientID, TourName, EventYear, EventMonth, EventDay),
    FOREIGN KEY(TourName, EventYear, EventMonth, EventDay) REFERENCES Events,
    FOREIGN KEY(ClientID) REFERENCES Client,
    CONSTRAINT chk_booking_months CHECK (EventMonth IN('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
    CONSTRAINT chk_booking_days CHECK (EventDay >=1 AND EventDay < 32),
    CONSTRAINT chk_booking_year_len CHECK(LEN (EventYear) = 4),
    CONSTRAINT chk_booking_payment CHECK (Payment > 0)
);

--Command to view all tables created
/*
SELECT NAME 
FROM sys.objects 
WHERE TYPE = 'U'
*/

-- Task 3

INSERT INTO TOUR(TourName, Descriotion) VALUES
('North', 'Tour of wineries and outlets of the Bedigo and Castlemaine region'),
('South', 'Tour of wineries and outlets of Mornington Penisula'),
('West', 'Tour of wineries and outlets of the Geelong and Otways region');

INSERT INTO Client (ClientID, Surname, GivenName, Gender) VALUES
(1,	'Price',	'Taylor',	'M'),
(2,	'Gamble',	'Ellyse',	'F'),
(3,	'Tan',	'Tilly',	'F'),
(4, 'Hussein', 'Hussein', 'M');

-- formatted dates using excel.
INSERT INTO Booking (ClientID, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES
(1,	'North','Jan',	9,	2016,	200,	'12/10/2015'),
(2,	'North','Jan',	9,	2016,	200,	'12/16/2015'),
(1,	'North','Feb',	13,	2016,	225,	'1/8/2016'),
(2,	'North','Feb',	13,	2016,	125,	'1/14/2016'),
(3,	'North','Feb',	13,	2016,	225,	'2/3/2016'),
(1,	'South','Jan',	9,	2016,	200,	'12/10/2015'),
(2,	'South','Jan',	16,	2016,	200,	'12/18/2015'),
(3,	'South','Jan',	16,	2016,	200,	'1/9/2016'),
(2,	'West',	'Jan',	29,	2016,	225,	'12/17/2015'),
(3,	'West',	'Jan',	29,	2016,	200,	'12/18/2015'),
-- i added my own data set in accordance with criteria
(4, 'North', 'Feb', 13, 2016,   125,    '12/9/2015');


-- Select * from Client

-- Task 4 

-- Query 1 
/*
Write a query that shows the client first name and surname, the tour name and description,
the tour event year, month, day and fee, the booking date and the fee paid for the booking


CREATE VIEW TASK5 AS
SELECT C.GivenName, C.Surname, T.TourName, T.Descriotion, B.EventYear, B.EventMonth, B.EventDay, B.DateBooked, B.Payment
FROM Booking B
INNER JOIN 
Client C
ON B.ClientID = C.ClientID
INNER JOIN Tour 
ON T.EventYear = B.EventYear AND T.EventMonth = B.EventMonth AND T.EventDay = B.EventDay AND T.DateBooked = B.DateBooked AND T.Payment = B.Payment



-- Query 2
SELECT (EventMonth),(TourName), COUNT(*) AS 'NUM Bookings'
FROM Event
GROUP BY EventMonth, TourName

-- Query 3 
SELECT * 
FROM Booking 
WHERE Payment > (SELECT AVG(Payment) FROM Booking);


-- TASK 5

-- above query 1

-- task 6
SELECT * FROM Booking
-- should output 9 results
-- this also proves query one as it demonstrates that there isnt more than desired booking count

Select Count (*) Booking
-- this proves that query two is credible and valid as it equals the predetermied booking amount

SELECT COUNT(*) 
From Booking B 
Where B.Payment > (SELECT AVG(Payment) FROM Booking);

*/
