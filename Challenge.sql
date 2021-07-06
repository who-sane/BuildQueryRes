USE BuildQueryRes

DROP TABLE IF EXISTS TOURS, Client, Events, Client;

CREATE TABLE TOURS (
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
    FOREIGN KEY(TourName) REFERENCES TOURS,
    CONSTRAINT chk_Event_months CHECK (EventMonth IN('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
    CONSTRAINT chk_Event_days CHECK (EventDay >=1 AND EventDay < 32),
    CONSTRAINT chk_year_len CHECK(LEN (EventYear) = 4),
    CONSTRAINT chk_fee CHECK (Fee > 0)
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

SELECT NAME 
FROM sys.objects 
WHERE TYPE = 'U'


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