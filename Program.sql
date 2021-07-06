-- Hussein Hussein 
-- 103615588

-- Task 1 

Tour(TourName, Descriotion)
PRIMARY KEY(TourName)

Event(TourName, EventYear, EventMonth, EventDay, Fee)
PRIMARY KEY(TourName, EventYear, EventMonth, EventDay)
FOREIGN KEY(TourName) REFERENCES Tour

Client(ClientID, Surname, GivenName, Gender)
PRIMARY KEY(ClientID)

Booking(TourName, EventYear, EventMonth, EventDay, ClientID, DateBooked, Payment)
PRIMARY KEY(EventYear, EventMonth, EventDay, ClientID)
FOREIGN KEY(TourName, EventYear, EventMonth, EventDay) REFERENCES Event
FOREIGN KEY(ClientID) REFERENCES Client