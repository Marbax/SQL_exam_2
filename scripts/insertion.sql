insert into Category(Name)
values
('performance'),
('concert'),
('exhibition'),
('circus'),
('sport'),
('seminars and trainings'),
('movie'),
('humor'),
('party'),
('for cids'),
('another')
;
go


insert into Countries(Name)
values
('Ukraune'),
('Moldova'),
('Russia'),
('Belarus'),
('Australia'),
('Italy'),
('France'),
('Portugal'),
('Sweden'),
('Switzerland'),
('Poland')
;
go


insert into Cities(Name,Country_Id)
values
('Kyev',1),
('Khmelnitsky',1),
('Lviv',1),
('Odessa',1),
('Kharkiv',1),
('Kishinev',2),
('Moscov',3),
('Saints-Peterburg',3),
('Kuznecovsk',3),
('Rostov on Don',3),
('Minsk',4),
('Kanberra',5),
('Rome',6),
('Paris',7),
('Marsel',7),
('Lissabon',8),
('Stockholm',9),
('Bern',10),
('Krakov',11),
('Warsaw',11)
;
go


insert into Locations(Name,City_Id)
values
('Kiev-Pechersk Lavra',1),
('Independence Square',1),
('Golden Gates',1),
('High Castle',3),
('Town Hall',3),
('House of Scientists',3),
('Hala Koszyki',20),
('Biała – zjedz i wypij',20),
('Dom Zabawy i Kultury DZiK',20)
;
go


insert into Event(Name,Value,Start_Date,End_Date,Country_Id,City_Id,Location_Id,EvTime,Description,Age_Restriction,Title_Image,Max_Tickets,Sold_Tickets)
values
('Games of the Games',150.99,'06-11-2020','09-11-2020',1,1,1,'18:00','Great games are held with participants from different countries.',3,'/root/images/gg_01.jpg',5000,0),
('Summit of Witches',666,'06-06-2020','06-06-2020',1,1,3,'22:00','Ball of all witches.',100,'/root/images/witch_01.jpg',666,0),
('Hackaton',50,'06-11-2020','11-13-2020',1,1,3,'12:00','Ball of all nerds.',16,'/root/images/hacktn_01.jpg',200,0),
('sold event',50,'06-11-2020','11-13-2020',1,2,3,'12:00','already sold.',16,'/root/images/sold_01.jpg',200,200)
;
go

---insert into [Event_Archive](Name,Value,Start_Date,End_Date,Country_Id,City_Id,Location_Id,EvTime,Description,Age_Restriction,Title_Image,Max_Tickets,Sold_Tickets)
---values
---('archived1',220.99,'06-11-2018','09-11-2018',1,1,1,'18:00','Great games are held with participants from different countries.',3,'/root/images/tmp1.jpg',5000,90),
---('archived2',123,'06-06-2016','06-06-2016',1,1,3,'22:00','Ball of all witches.',100,'/root/images/tmp2.jpg',666,101),
---('archived3',01,'06-11-2015','11-13-2015',1,1,3,'12:00','Ball of all nerds.',16,'/root/images/tmp3.jpg',1500,333)
---;
---go


insert into Category_to_Event(Category_Id,Event_Id)
values
(1,1),
(4,1),
(8,1),
(9,2),
(11,2),
(2,2),
(5,3),
(6,3),
(9,3)
;
go


insert into Clients(FName,Email,BDate)
values
('Ivanov Ivan','ivanov_pasha@email.ua','06-11-1991'),
('Darth Mol','rainbowPony333@email.ua','12-01-2005'),
('Picachu','anatoliy_pavlovich007@email.ua','12-01-1980'),
('Sergei Igorevich','lolly_lover@gmai.ua','12-01-1972')
;
go


insert into Client_Archive(Event_Name,Ticket_Value,Tickets_Count,Client_Id)
values
('Some event',200,2,1),
('Old event',200,1,1),
('Old event',155,1,3),
('Another event',200,1,3),
('Very old event',200,1,3),
('Back to the future',500,2,2)
;
go




