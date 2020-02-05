--- Для веб-проекта «Афиша событий» необходимо создать базу данных. 
use [master];
go

if db_id('EventPosterDB') is not null
begin
	drop database [EventPosterDB];
end
go

create database [EventPosterDB];
go

use [EventPosterDB];
go


---  Категории событий 
CREATE TABLE [Category] 
(
	[Id] int NOT NULL identity(1, 1) CONSTRAINT [PK_CATEGORY] PRIMARY KEY,
	[Name] nvarchar(255) NOT NULL UNIQUE check ([Name] <> N'')
);
GO

/*
- Событие 
    - название события 
    - цена
    - дата проведения или диапазон дат 
    - время проведения 
    - описание события 
    - возрастные ограничения  
    - изображение для афиши события
    - максимальное количество билетов  
    - количество приобретенных билетов 
*/
CREATE TABLE [Event] 
(
	[Id] int NOT NULL  identity(1, 1) CONSTRAINT [PK_EVENT] PRIMARY KEY,
	[Name] nvarchar(255) NOT NULL check ([Name] <> N''),
	[Value] money NOT NULL DEFAULT '0',
	[Start_Date] date NOT NULL,
	[End_Date] date,
	[Country_Id] int NOT NULL,
	[City_Id] int NOT NULL,
	[Location_Id] int NOT NULL,
	[EvTime] time NOT NULL,
	[Description] nvarchar(max),
	[Age_Restriction] smallint DEFAULT '0',
	[Title_Image] nvarchar(255),
	[Max_Tickets] int NOT NULL,
	[Sold_Tickets] int NOT NULL DEFAULT '0'
);
GO

/*
- Событие 
    - место проведения 
*/
CREATE TABLE [Locations] 
(
	[Id] int NOT NULL CONSTRAINT [PK_LOCATIONS] PRIMARY KEY,
	[City_Id] int NOT NULL,
	[Name] nvarchar(255) NOT NULL
);
GO

/*
- Событие 
    - категория события и ивент - связующая, многие ко многим
*/
CREATE TABLE [Category_to_Event] 
(
	[Category_Id] int NOT NULL,
	[Event_Id] int NOT NULL
);
GO

/*
 - Клиенты  
    - ФИО клиента  
    - контактный email клиента  
    - дата рождения  
*/
CREATE TABLE [Clients]
(
	[Id] int NOT NULL CONSTRAINT [PK_CLIENTS] PRIMARY KEY,
	[FName] nvarchar(150) NOT NULL check ([FName] <> N''),
	[Email] varchar(255) NOT NULL UNIQUE,
	[BDate] date NOT NULL check ([BDate]<getdate()),
	[Client_Archive_Id] int,

);
GO


/*
 - Клиенты  
    - приобретенные клиентом билеты 
        - название события 
        - цена билета
        - кол-во билетов (по данному ивенту)
*/
CREATE TABLE [Client_Archive] (
	[Id] int NOT NULL CONSTRAINT [PK_CLIENT_ARCHIVE] PRIMARY KEY,
	[Event_Name] nvarchar(255) NOT NULL check ([Event_Name] <> N''),
	[Ticket_Value] money NOT NULL,
	[Tickets_Count] int NOT NULL DEFAULT '1'
);
GO


/*
- Событие 
    - страна проведения 
*/
CREATE TABLE [Countries] (
	[Id] int NOT NULL CONSTRAINT [PK_COUNTRIES] PRIMARY KEY,
	[Name] nvarchar(100) NOT NULL UNIQUE
);
GO

/*
- Событие 
    - город проведения 
*/
CREATE TABLE [Cities] (
	[Id] int NOT NULL CONSTRAINT [PK_CITIES] PRIMARY KEY,
	[Name] nvarchar(100) NOT NULL,
	[Country_Id] int NOT NULL
);
GO


--- - Архив событий.
CREATE TABLE [Event_Archive] 
(
	[Id] int NOT NULL  identity(1, 1) CONSTRAINT [PK_EVENT_ARCHIVE] PRIMARY KEY,
	[Name] nvarchar(255) NOT NULL check ([Name] <> N''),
	[Value] money NOT NULL DEFAULT '0',
	[Start_Date] date NOT NULL,
	[End_Date] date,
	[Country_Id] int NOT NULL,
	[City_Id] int NOT NULL,
	[Location_Id] int NOT NULL,
	[EvTime] time NOT NULL,
	[Description] nvarchar(max),
	[Age_Restriction] smallint DEFAULT '0',
	[Title_Image] nvarchar(255),
	[Max_Tickets] int NOT NULL,
	[Sold_Tickets] int NOT NULL DEFAULT '0'
);
GO

ALTER TABLE [Event] WITH CHECK 
ADD CONSTRAINT [Event_fk0] 
FOREIGN KEY ([Country_Id]) REFERENCES [Countries]([Id])
on update no action on delete no action;
GO

ALTER TABLE [Event] CHECK CONSTRAINT [Event_fk0];
GO

ALTER TABLE [Event] WITH CHECK 
ADD CONSTRAINT [Event_fk1] 
FOREIGN KEY ([City_Id]) REFERENCES [Cities]([Id])
on update no action on delete no action;
GO

ALTER TABLE [Event] CHECK CONSTRAINT [Event_fk1];
GO

ALTER TABLE [Event] WITH CHECK 
ADD CONSTRAINT [Event_fk2] 
FOREIGN KEY ([Location_Id]) REFERENCES [Locations]([Id])
on update no action on delete no action;
GO

ALTER TABLE [Event] CHECK CONSTRAINT [Event_fk2];
GO

ALTER TABLE [Locations] WITH CHECK 
ADD CONSTRAINT [Locations_fk0] 
FOREIGN KEY ([City_Id]) REFERENCES [Cities]([Id])
on update no action on delete no action;
GO

ALTER TABLE [Locations] CHECK CONSTRAINT [Locations_fk0];
GO

ALTER TABLE [Category_to_Event] WITH CHECK 
ADD CONSTRAINT [Category_to_Event_fk0] 
FOREIGN KEY ([Category_Id]) REFERENCES [Category]([Id])
on update no action on delete no action;
GO

ALTER TABLE [Category_to_Event] CHECK CONSTRAINT [Category_to_Event_fk0];
GO

ALTER TABLE [Category_to_Event] WITH CHECK 
ADD CONSTRAINT [Category_to_Event_fk1] 
FOREIGN KEY ([Event_Id]) REFERENCES [Event]([Id])
on update no action on delete no action;
GO

ALTER TABLE [Category_to_Event] CHECK CONSTRAINT [Category_to_Event_fk1];
GO

ALTER TABLE [Category_to_Event] WITH CHECK 
ADD CONSTRAINT [pf_Category_to_Event_Ids] 
primary key (Category_Id , Event_Id);
GO


ALTER TABLE [Clients] WITH CHECK 
ADD CONSTRAINT [Clients_fk0] 
FOREIGN KEY ([Client_Archive_Id]) REFERENCES [Client_Archive]([Id])
on update no action on delete no action;
GO

ALTER TABLE [Clients] CHECK CONSTRAINT [Clients_fk0];
GO

ALTER TABLE [Client_Archive] WITH CHECK 
ADD CONSTRAINT [Client_Archive_fk0] 
on update no action on delete no action;
GO

ALTER TABLE [Client_Archive] CHECK CONSTRAINT [Client_Archive_fk0];
GO

ALTER TABLE [Cities] WITH CHECK 
ADD CONSTRAINT [Cities_fk0] 
FOREIGN KEY ([Country_Id]) REFERENCES [Countries]([Id])
on update no action on delete no action;
GO

ALTER TABLE [Cities] CHECK CONSTRAINT [Cities_fk0];
GO

ALTER TABLE [Event_Archive] WITH CHECK 
ADD CONSTRAINT [Event_Archive_fk0] 
FOREIGN KEY ([Country_Id]) REFERENCES [Countries]([Id])
on update no action on delete no action;
GO

ALTER TABLE [Event_Archive] CHECK CONSTRAINT [Event_Archive_fk0];
GO

ALTER TABLE [Event_Archive] WITH CHECK 
ADD CONSTRAINT [Event_Archive_fk1] 
FOREIGN KEY ([City_Id]) REFERENCES [Cities]([Id])
on update no action on delete no action;
GO

ALTER TABLE [Event_Archive] CHECK CONSTRAINT [Event_Archive_fk1];
GO

ALTER TABLE [Event_Archive] WITH CHECK 
ADD CONSTRAINT [Event_Archive_fk2] 
FOREIGN KEY ([Location_Id]) REFERENCES [Locations]([Id])
on update no action on delete no action;
GO

ALTER TABLE [Event_Archive] CHECK CONSTRAINT [Event_Archive_fk2];
GO

