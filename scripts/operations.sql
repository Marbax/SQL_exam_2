---     - С помощью представлений, хранимых процедур, пользовательских функций, триггеров реализуйте следующую функциональность:     ----------
-----------------------------------------------------------------------------------------------------------------------------------------------
---  - Get events
if object_id('uf_get_events')is not null
    drop function uf_get_events;
go
create function uf_get_events()
returns table
as 
    return (select ev.Id , ev.Name 'Event', ev.Value as 'Ticket cost' , ctgry.Name 'Category' , ev.Start_Date as 'Start Date' , ev.End_Date as 'End Date', cntr.Name 'Country' , cit.Name 'City' , loc.Name 'Location' , ev.EvTime 'Time', ev.Description , ev.Age_Restriction 'Age Restriction' , ev.Title_Image 'Title Image' , ev.Max_Tickets 'Tickets Count' , ev.Sold_Tickets 'Sold Tickets'
            from [Event] ev left join [Category_to_Event] cte on cte.Event_Id=ev.Id
            left join [Category] ctgry on ctgry.Id=cte.Category_Id
            left join [Countries] cntr on cntr.Id=ev.Country_Id
            left join [Cities] cit on ev.City_Id=cit.Id
            left join [Locations] loc on ev.Location_Id=loc.Id);

go
select * from uf_get_events() ;



---  - Get events with categories in one row
if object_id('uf_get_events_categories_in_one')is not null
    drop function uf_get_events_categories_in_one;
go
create function uf_get_events_categories_in_one()
returns table
as 
    return (select ev.Id , ev.Name 'Event', ev.Value as 'Ticket cost' , STRING_AGG(ctgry.Name, ' , ') as 'Category' , ev.Start_Date as 'Start Date' , ev.End_Date as 'End Date', cntr.Name 'Country' , cit.Name 'City' , loc.Name 'Location' , ev.EvTime 'Time', ev.Description , ev.Age_Restriction 'Age Restriction' , ev.Title_Image 'Title Image' , ev.Max_Tickets 'Tickets Count' , ev.Sold_Tickets 'Sold Tickets'
            from [Event] ev left join [Category_to_Event] cte on cte.Event_Id=ev.Id
            left join [Category] ctgry on ctgry.Id=cte.Category_Id
            left join [Countries] cntr on cntr.Id=ev.Country_Id
            left join [Cities] cit on ev.City_Id=cit.Id
            left join [Locations] loc on ev.Location_Id=loc.Id
            group by ev.Id , ev.Name, ev.Value , ev.Start_Date , ev.End_Date, cntr.Name  , cit.Name  , loc.Name , ev.EvTime , ev.Description , ev.Age_Restriction  , ev.Title_Image  , ev.Max_Tickets  , ev.Sold_Tickets );

go
select * from uf_get_events_categories_in_one() ;



---  - Get archived events
if object_id('uf_get_archived_events')is not null
    drop function uf_get_archived_events;
go
create function uf_get_archived_events()
returns table
as 
    return (select ev.Id , ev.Name 'Event', ev.Value as 'Ticket cost' , ctgry.Name 'Category' , ev.Start_Date as 'Start Date' , ev.End_Date as 'End Date', cntr.Name 'Country' , cit.Name 'City' , loc.Name 'Location' , ev.EvTime 'Time', ev.Description , ev.Age_Restriction 'Age Restriction' , ev.Title_Image 'Title Image' , ev.Max_Tickets 'Tickets Count' , ev.Sold_Tickets 'Sold Tickets'
            from [Event_Archive] ev left join [Category_to_Event_Arch] cte on cte.Event_Id=ev.Id
            left join [Category] ctgry on ctgry.Id=cte.Category_Id
            left join [Countries] cntr on cntr.Id=ev.Country_Id
            left join [Cities] cit on ev.City_Id=cit.Id
            left join [Locations] loc on ev.Location_Id=loc.Id);

go
select * from uf_get_archived_events() ;



---  - Get archived events with categories in one row
if object_id('uf_get_archived_events_categories_in_one')is not null
    drop function uf_get_archived_events_categories_in_one;
go
create function uf_get_archived_events_categories_in_one()
returns table
as 
    return (select ev.Id , ev.Name 'Event', ev.Value as 'Ticket cost' , STRING_AGG(ctgry.Name, ' , ') as 'Category' , ev.Start_Date as 'Start Date' , ev.End_Date as 'End Date', cntr.Name 'Country' , cit.Name 'City' , loc.Name 'Location' , ev.EvTime 'Time', ev.Description , ev.Age_Restriction 'Age Restriction' , ev.Title_Image 'Title Image' , ev.Max_Tickets 'Tickets Count' , ev.Sold_Tickets 'Sold Tickets'
            from [Event_Archive] ev left join [Category_to_Event_Arch] cte on cte.Event_Id=ev.Id
            left join [Category] ctgry on ctgry.Id=cte.Category_Id
            left join [Countries] cntr on cntr.Id=ev.Country_Id
            left join [Cities] cit on ev.City_Id=cit.Id
            left join [Locations] loc on ev.Location_Id=loc.Id
            group by ev.Id , ev.Name, ev.Value , ev.Start_Date , ev.End_Date, cntr.Name  , cit.Name  , loc.Name , ev.EvTime , ev.Description , ev.Age_Restriction  , ev.Title_Image  , ev.Max_Tickets  , ev.Sold_Tickets );

go
select * from uf_get_archived_events_categories_in_one() ;



---  - Get all events
if object_id('uf_get_all_events')is not null
    drop function uf_get_all_events;
go
create function uf_get_all_events()
returns table
as 
    return (select * from uf_get_events()
            union all
            select * from uf_get_archived_events());

go
select * from uf_get_all_events() ;



---  - Get all events with categories in one row(can get simmilar ids)
if object_id('uf_get_all_events_categories_in_one')is not null
    drop function uf_get_all_events_categories_in_one;
go
create function uf_get_all_events_categories_in_one()
returns table
as 
    return (select * from uf_get_events_categories_in_one()
            union all
            select * from uf_get_archived_events_categories_in_one());

go
select * from uf_get_all_events_categories_in_one() ;



--- Get clients
if object_id('uf_get_clients')is not null
    drop function uf_get_clients;
go
create function uf_get_clients()
returns table
as 
    return (select c.Id , c.FName 'Full Name' , c.Email , c.BDate 'Birthday date' from Clients c);

go
select * from uf_get_clients() ;



--- Get clients with archives
if object_id('uf_get_clients_with_archives')is not null
    drop function uf_get_clients_with_archives;
go
create function uf_get_clients_with_archives()
returns table
as 
    return (select c.Id , c.FName 'Full Name' , c.Email , c.BDate 'Birthday date' , ca.Event_Name 'Visited Event' , ca.Ticket_Value 'Ticket Value' , ca.Tickets_Count 'Tickets Count' , ca.Bought_Date 'Bought Date'
    from Clients c left join Client_Archive ca on ca.Client_Id=c.Id);

go
select * from uf_get_clients_with_archives() ;


--- Buy ticket procedure
if object_id('sp_buy_ticket')is not null
    drop procedure sp_buy_ticket;
go
create procedure sp_buy_ticket @client_Id_input int , @event_Id_input int , @tickets_count_input int
as 
begin
    if exists (select Id from Clients where Id=@client_Id_input )
    begin 
        if exists(select Id from [Event] where Id=@event_Id_input)
        begin
            insert into Client_Archive(Event_Name,Ticket_Value,Tickets_Count,Client_Id)
            values
            ((select Name from [Event] where Id=@event_Id_input),(select Value from [Event] where Id=@event_Id_input), @tickets_count_input,@client_Id_input)

            update [Event] 
            set Sold_Tickets=Sold_Tickets+@tickets_count_input
            where Id=@event_Id_input
        end
        else
        begin
            set nocount on
            raiserror ('Wrong Event Id!',0,1) 
        end
    end
    else
    begin
        set nocount on
        raiserror ('Wrong Client Id!',0,1) 
    end
end;


go
exec sp_buy_ticket 1,1,2



---    - Отобразите все актуальные события на конкретную дату. Дата указывается в качестве параметра
if object_id('uf_get_events_by_date')is not null
    drop function uf_get_events_by_date;
go
create function uf_get_events_by_date(@date_input date)
returns table
as 
    return (select uf.* from uf_get_events_categories_in_one() uf where uf.[End Date]>getdate() and uf.Id in (select Id from [Event] where @date_input between [Start_Date] and [End_Date] or @date_input=[Start_Date]));

go
select * from uf_get_events_by_date('06-06-2020') ;



---    - Отобразите все актуальные события из конкретной категории. Категория указывается в качестве параметра 
if object_id('uf_get_events_by_category')is not null
    drop function uf_get_events_by_category;
go
create function uf_get_events_by_category(@category_input nvarchar(255))
returns table
as 
    return (select uf.* from uf_get_events_categories_in_one() uf where uf.[End Date]>getdate() and uf.Id in (select e.Id from [Category] c join [Category_to_Event] ce on c.Id=ce.Category_Id and c.Name=@category_input
        join [Event] e on ce.Event_Id=e.Id));

go
select * from uf_get_events_by_category('circus') ;



---    - Отобразите все актуальные события со стопроцентной продажей билетов 
if object_id('uf_get_events_with_all_tickets_sold')is not null
    drop function uf_get_events_with_all_tickets_sold;
go
create function uf_get_events_with_all_tickets_sold()
returns table
as 
    return (select uf.* from uf_get_events_categories_in_one() uf where uf.[Tickets Count]=uf.[Sold Tickets] and uf.[End Date]>getdate());

go
select * from uf_get_events_with_all_tickets_sold() ;



---    - Отобразите топ-3 самых популярных актуальных событий (по количеству приобретенных билетов) 
if object_id('uf_get_top3_events_by_tickets_sold')is not null
    drop function uf_get_top3_events_by_tickets_sold;
go
create function uf_get_top3_events_by_tickets_sold()
returns table
as 
    return (select top 3 uf.* from uf_get_events_categories_in_one() uf where uf.[End Date]>getdate() order by uf.[Sold Tickets] desc);

go
select * from uf_get_top3_events_by_tickets_sold() ;



---    - Отобразите топ-3 самых популярных АРХИВНЫХ событий (по количеству приобретенных билетов) 
if object_id('uf_get_top3_archived_events')is not null
    drop function uf_get_top3_archived_events;
go
create function uf_get_top3_archived_events()
returns table
as 
    return (select top 3 uf.* from uf_get_archived_events_categories_in_one() uf order by uf.[Sold Tickets] desc);

go
select * from uf_get_top3_archived_events() ;



---    - Отобразите топ-3 самых популярных КАТЕГОРИЙ событий (по количеству всех приобретенных билетов). Архив событий учитывается 
if object_id('uf_get_top3_categories')is not null
    drop function uf_get_top3_categories;
go
create function uf_get_top3_categories()
returns table
as 
    return (select top 3 uf.Category , sum(uf.[Sold Tickets]) as 'Sold Tickets' 
    from uf_get_all_events() uf group by uf.Category order by sum(uf.[Sold Tickets]) desc);

go
select * from uf_get_top3_categories() ;



---    - Отобразите самое популярное событие в конкретном городе. Город указывается в качестве параметра 
if object_id('uf_get_top_event_in_the_city')is not null
    drop function uf_get_top_event_in_the_city;
go
create function uf_get_top_event_in_the_city(@city_input nvarchar(100))
returns table
as 
    return (select top 1 uf.* from uf_get_all_events_categories_in_one() uf where uf.[City]=@city_input order by uf.[Sold Tickets] desc);

go
select * from uf_get_top_event_in_the_city('Kyev') ;



---    - Покажите информацию о самом активном клиенте (по количеству купленных билетов) 
if object_id('uf_best_customer')is not null
    drop function uf_best_customer;
go
create function uf_best_customer()
returns table
as 
    return (select top 1 uf.Id , uf.[Full Name] , uf.Email , uf.[Birthday date] , sum(uf.[Tickets Count]) as 'Tickets bought' 
    from uf_get_clients_with_archives() uf group by uf.Id , uf.[Full Name] , uf.Email , uf.[Birthday date] order by sum(uf.[Tickets Count]) desc);

go
select * from uf_best_customer() ;



---    - Покажите информацию о самой непопулярной категории (по количеству событий). Архив событий учитывается. 
if object_id('uf_the_worst_cattegory')is not null
    drop function uf_the_worst_cattegory;
go
create function uf_the_worst_cattegory()
returns table
as 
    return (select top 1 uf.Category , count(uf.[Category]) as 'Events with category' 
    from uf_get_all_events() uf where uf.Category!='' group by uf.Category order by count(uf.[Category]));

go
select * from uf_the_worst_cattegory() ;



---    - Отобразите топ-3 набирающих популярность событий (по количеству проданных билетов за 5 дней) !(как обычно никто не говорил что неужна дата покупки билета)
if object_id('uf_get_top3_events_for_last_5days')is not null
    drop function uf_get_top3_events_for_last_5days;
go
create function uf_get_top3_events_for_last_5days()
returns table
as 
    return (select top 3 ca.Event_Name 'Event' , sum(ca.Tickets_Count) as 'Sold Tickets' 
    from Client_Archive ca 
    where ca.Bought_date between dateadd(day,-5,CONVERT(DATE,GETDATE())) and CONVERT(DATE,GETDATE())
    group by ca.Event_Name order by sum(ca.Tickets_Count) desc);

go
select * from uf_get_top3_events_for_last_5days() ;



---    - Покажите все события, которые пройдут сегодня в указанное время. Время передаётся в качестве параметра  
if object_id('uf_get_today_events_by_time')is not null
    drop function uf_get_today_events_by_time;
go
create function uf_get_today_events_by_time(@time_input time)
returns table
as 
    return (select uf.* from uf_get_events_categories_in_one() uf 
    where CONVERT(DATE,GETDATE()) between uf.[Start Date] and uf.[End Date] and uf.Time = @time_input );

go
select * from uf_get_today_events_by_time('18:00') ;



---    - Покажите название городов, в которых сегодня пройдут события  
if object_id('uf_get_ciries_in_which_event_today')is not null
    drop function uf_get_ciries_in_which_event_today;
go
create function uf_get_ciries_in_which_event_today()
returns table
as 
    return (select uf.[City] from uf_get_events_categories_in_one() uf 
    where CONVERT(DATE,GETDATE()) between uf.[Start Date] and uf.[End Date]);

go
select * from uf_get_ciries_in_which_event_today() ;



---    - При вставке нового клиента нужно проверять, нет ли его уже в базе данных. Если такой клиент есть, генерировать ошибку с описанием возникшей проблемы (и так нельзя вставить потвор ,т.к. эмейл уникален )
if object_id('ins_cant_add_same_client')is not null
    drop trigger ins_cant_add_same_client;
go
create trigger ins_cant_add_same_client
on Clients instead of insert
as
begin
    if not exists (select i.Email from inserted i where i.Email in (select c.Email from Clients c) )
            begin
            insert into Clients
            select i.FName, i.Email, i.BDate from inserted i
            end
    else 
        begin
            set nocount on
            raiserror ('This email already exists!',0,1) 
        end
end;

insert into Clients(FName,Email,BDate)
values
('Zhukov Ivan','ivanov_pasha@email.ua','02-01-1991')
;



---    - При вставке нового события нужно проверять, нет ли его уже в базе данных. Если такое событие есть, генерировать ошибку с описанием возникшей проблемы
if object_id('ins_cant_add_same_event')is not null
    drop trigger ins_cant_add_same_event;
go
create trigger ins_cant_add_same_event
on [Event] instead of insert
as
begin
    if not exists (select i.Name , i.Start_Date , i.End_Date , i.City_Id , i.Location_Id 
        from inserted i join [Event] ev on i.Name=ev.Name and i.Start_Date=ev.Start_Date and i.End_Date=ev.End_Date and i.City_Id=ev.City_Id and i.Location_Id=ev.Location_Id )
            begin
            insert into [Event]
            select i.Name , i.Value , i.Start_Date , i.End_Date , i.Country_Id , i.City_Id , i.Location_Id , i.EvTime , i.Description , i.Age_Restriction , i.Title_Image , i.Max_Tickets , i.Sold_Tickets 
            from inserted i
            end
    else 
        begin
            set nocount on
            raiserror ('This event already exists!',0,1) 
        end
end;

---- CHECK
insert into Event(Name,Value,Start_Date,End_Date,Country_Id,City_Id,Location_Id,EvTime,Description,Age_Restriction,Title_Image,Max_Tickets,Sold_Tickets)
values
('Games of the Games',222.99,'06-11-2020','09-11-2020',1,1,1,'21:00','NOthin.',3,'/root/images/gsg_01.jpg',111,10)
;



---    - При удалении прошедших событий необходимо их переносить в архив событий 
if object_id('del_category_to_event_move_to_archive')is not null
    drop trigger del_category_to_event_move_to_archive;
go
create trigger del_category_to_event_move_to_archive
on [Category_to_Event] after delete
as
begin
    insert into [Category_to_Event_Arch]
    select d.Category_Id , d.Event_Id
    from deleted d
end;

if object_id('del_move_event_to_archive')is not null
    drop trigger del_move_event_to_archive;
go
create trigger del_move_event_to_archive
on [Event] after delete
as
begin
    insert into [Event_Archive]
    select d.Name , d.Value , d.Start_Date , d.End_Date , d.Country_Id , d.City_Id , d.Location_Id , d.EvTime , d.Description , d.Age_Restriction , d.Title_Image , d.Max_Tickets , d.Sold_Tickets
    from deleted d
end;

---- CHECK
delete from Category_to_Event where Event_Id=3;
go
delete from Event where Id=3;
go
select * from uf_get_events_categories_in_one();
go



---    - При попытке покупки билета проверять не достигнуто ли уже максимальное количество билетов. Если максимальное количество достигнуто, генерировать ошибку с информацией о возникшей проблеме 
if object_id('sp_buy_ticket_if_enough_tickets')is not null
    drop procedure sp_buy_ticket_if_enough_tickets;
go
create procedure sp_buy_ticket_if_enough_tickets @client_Id_input int , @event_Id_input int , @tickets_count_input int
as
begin
    if ((select Max_Tickets-Sold_Tickets from Event where Id=@event_Id_input)>=@tickets_count_input and @tickets_count_input>0 )
        begin
            exec sp_buy_ticket @client_Id_input , @event_Id_input , @tickets_count_input 
        end
    else 
        begin
            set nocount on
            raiserror ('Not enough tickets left or wrong input!',0,1) 
        end
end;

exec sp_buy_ticket_if_enough_tickets 1,1,2



---    - При попытке покупки билета проверять возрастные ограничения. Если возрастное ограничение нарушено, генерировать ошибку с информацией о возникшей проблеме 
if object_id('sp_buy_ticket_if_old_enough')is not null
    drop procedure sp_buy_ticket_if_old_enough;
go
create procedure sp_buy_ticket_if_old_enough @client_Id_input int , @event_Id_input int , @tickets_count_input int
as
begin
    if ((select (datepart(year,convert(date,getdate())) - datepart(year,(select BDate from Clients where Id=@client_Id_input))))>=(select Age_Restriction from [Event] where Id=@event_Id_input))
        begin
            exec sp_buy_ticket_if_enough_tickets @client_Id_input , @event_Id_input , @tickets_count_input 
        end
    else 
        begin
            set nocount on
            raiserror ('To young for event!',0,1) 
        end
end;

exec sp_buy_ticket_if_old_enough 1,1,2



---    - Настроить создание резервных копий с периодичностью раз в день.
if object_id('sp_backupDB')is not null
    drop procedure sp_backupDB;
go
create procedure sp_backupDB
as
begin
    backup database [EventPosterDB]
    to disk = N'D:\backups\EventPosterDB.bak'
end;

EXEC sp_add_schedule  
    @schedule_name = N'db_backup_every_day' ,  
    @freq_type = 4,  
    @freq_interval = 1,  
    @active_start_time = 010000 ;  
GO  
  
EXEC sp_attach_schedule  
   @job_name = N'BackupDatabase',  
   @schedule_name = N'db_backup_every_day' ;  
GO  
  






