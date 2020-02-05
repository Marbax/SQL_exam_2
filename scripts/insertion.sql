insert into Category(Name)
values
('спектакль'),
('концерт'),
('выставка'),
('цирк'),
('спорт'),
('семинары и тренинги'),
('кино'),
('юмор'),
('вечеринки'),
('детям'),
('другое')
;
go


insert into Countries(Name)
values
('Украина'),
('Молдавия'),
('Россия'),
('Беларуссия'),
('Австралия'),
('Италия'),
('Франция'),
('Португалия'),
('Швеция'),
('Швейцария'),
('Польша')
;
go


insert into Cities(Name,Country_Id)
values
('Киев',1),
('Хмельницкий',1),
('Львов',1),
('Одесса',1),
('Харьков',1),
('Кишинев',2),
('Москва',3),
('Санкт-Петербург',3),
('Кузнецовск',3),
('Ростов на Дону',3),
('Минск',4),
('Канберра',5),
('Рим',6),
('Париж',7),
('Марсель',7),
('Лисабон',8),
('Стокгольм',9),
('Берн',10),
('Краков',11),
('Варшава',11)
;
go


insert into Locations(Name,City_Id)
values
('Киево-Печерская лавра',1),
('Майдан независимости',1),
('Золотые ворота',1),
('Высокий замок',3),
('Ратуша',3),
('Дом Ученых',3),
('Hala Koszyki',20),
('Biała – zjedz i wypij',20),
('Dom Zabawy i Kultury DZiK',20),
;
go


insert into Event(Name,Value,Start_Date,End_Date,Country_Id,City_Id,Location_Id,EvTime,Description,Age_Restriction,Title_Image,Max_Tickets,Sold_Tickets)
values
('Игрища иргищ',150.99,'06-11-2020','09-11-2020',1,1,1,'18:00','Проводятся великие игрища с участниками из разных стран.',3,'/root/images/gg_01.jpg',5000,0),
('Самит ведьм',666,'06-06-2020','06-06-2020',1,1,3,'22:00','Бал всех ведьм.',100,'/root/images/witch_01.jpg',666,0),
('Хаккатон',50,'06-11-2020','13-11-2020',1,1,3,'12:00','Бал всех задротов.',16,'/root/images/hacktn_01.jpg',200,0)
;
go


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


insert into Clients(FName,Email,BDate,Client_Archive_Id)
values
('Иванов Иванов','ivanov_pasha@email.ua','06-11-1991',1),
('Дарт Мол','rainbowPony333@email.ua','12-01-2005',2),
('Пикачу','anatoliy_pavlovich007@email.ua','12-01-1980'),
('Сергей Игоревич','lolly_lover@gmai.ua','12-01-1972')
;
go


insert into Client_Archive(Event_Name,Ticket_Value,Tickets_Count)
values
('Какой то ивент',200,2),
('Назад в будущее',500,2)
;
go




