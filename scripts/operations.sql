---     - С помощью представлений, хранимых процедур, пользовательских функций, триггеров реализуйте следующую функциональность:     ----------
-----------------------------------------------------------------------------------------------------------------------------------------------
---  - Get actual events
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

---  - Get archived events
if object_id('uf_get_archived_events')is not null
    drop function uf_get_archived_events;
go
create function uf_get_archived_events()
returns table
as 
    return (select ev.Id , ev.Name 'Event', ev.Value as 'Ticket cost' , ctgry.Name 'Category' , ev.Start_Date as 'Start Date' , ev.End_Date as 'End Date', cntr.Name 'Country' , cit.Name 'City' , loc.Name 'Location' , ev.EvTime 'Time', ev.Description , ev.Age_Restriction 'Age Restriction' , ev.Title_Image 'Title Image' , ev.Max_Tickets 'Tickets Count' , ev.Sold_Tickets 'Sold Tickets'
            from [Event_Archive] ev left join [Category_to_Event] cte on cte.Event_Id=ev.Id
            left join [Category] ctgry on ctgry.Id=cte.Category_Id
            left join [Countries] cntr on cntr.Id=ev.Country_Id
            left join [Cities] cit on ev.City_Id=cit.Id
            left join [Locations] loc on ev.Location_Id=loc.Id);

go
select * from uf_get_archived_events() ;

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
    return (select c.Id , c.FName 'Full Name' , c.Email , c.BDate 'Birthday date' , ca.Event_Name 'Visited Event' , ca.Ticket_Value 'Ticket Value' , ca.Tickets_Count 'Tickets Count' 
    from Clients c left join Client_Archive ca on ca.Client_Id=c.Id);

go
select * from uf_get_clients_with_archives() ;


---  - Get event's categories by id in one row
if object_id('uf_get_events_better')is not null
    drop procedure uf_get_events_better;
go
create procedure uf_get_events_better @ev_id int , @categories nvarchar(255) output
as 
SELECT  @categories = COALESCE(@categories + ' , ', '') + c.Name
FROM   Category c join Category_to_Event ce on ce.Category_Id=c.Id
join Event ev on ev.Id=ce.Event_Id and ev.Id=@ev_id;

go 
Declare @categories Nvarchar(255)
exec uf_get_events_better 1, @categories output;
select @categories


---    - Отобразите все актуальные события на конкретную дату. Дата указывается в качестве параметра
if object_id('uf_get_events_by_date')is not null
    drop function uf_get_events_by_date;
go
create function uf_get_events_by_date(@date_input date)
returns table
as 
    return (select uf.* from uf_get_events() uf where uf.[End Date]>getdate() and uf.Id in (select Id from [Event] where @date_input between [Start_Date] and [End_Date] or @date_input=[Start_Date]));

go
select * from uf_get_events_by_date('06-06-2020') ;


---    - Отобразите все актуальные события из конкретной категории. Категория указывается в качестве параметра 
if object_id('uf_get_events_by_category')is not null
    drop function uf_get_events_by_category;
go
create function uf_get_events_by_category(@category_input nvarchar(255))
returns table
as 
    return (select uf.* from uf_get_events() uf where uf.[End Date]>getdate() and uf.Id in (select e.Id from [Category] c join [Category_to_Event] ce on c.Id=ce.Category_Id and c.Name=@category_input
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
    return (select uf.* from uf_get_events() uf where uf.[Tickets Count]=uf.[Sold Tickets] and uf.[End Date]>getdate());

go
select * from uf_get_events_with_all_tickets_sold() ;


---    - Отобразите топ-3 самых популярных актуальных событий (по количеству приобретенных билетов) 
if object_id('uf_get_top3_events_by_tickets_sold')is not null
    drop function uf_get_top3_events_by_tickets_sold;
go
create function uf_get_top3_events_by_tickets_sold()
returns table
as 
    return (select top 3 uf.* from uf_get_events() uf where uf.[End Date]>getdate() order by uf.[Sold Tickets] desc);

go
select * from uf_get_top3_events_by_tickets_sold() ;


---    - Отобразите топ-3 самых популярных АРХИВНЫХ событий (по количеству приобретенных билетов) 
if object_id('uf_get_top3_archived_events')is not null
    drop function uf_get_top3_archived_events;
go
create function uf_get_top3_archived_events()
returns table
as 
    return (select top 3 uf.* from uf_get_archived_events() uf order by uf.[Sold Tickets] desc);

go
select * from uf_get_top3_archived_events() ;



---    - Отобразите топ-3 самых популярных КАТЕГОРИЙ событий (по количеству всех приобретенных билетов). Архив событий учитывается 
if object_id('uf_get_top3_categories')is not null
    drop function uf_get_top3_categories;
go
create function uf_get_top3_categories()
returns table
as 
    return (select top 3 uf.Category , sum(uf.[Sold Tickets]) as 'Sold Tickets' from uf_get_all_events() uf group by uf.Category order by sum(uf.[Sold Tickets]) desc);

go
select * from uf_get_top3_categories() ;



---    - Отобразите самое популярное событие в конкретном городе. Город указывается в качестве параметра 
if object_id('uf_get_top_event_in_the_city')is not null
    drop function uf_get_top_event_in_the_city;
go
create function uf_get_top_event_in_the_city(@city_input nvarchar(100))
returns table
as 
    return (select top 1 uf.* from uf_get_all_events() uf where uf.[City]=@city_input order by uf.[Sold Tickets] desc);

go
select * from uf_get_top_event_in_the_city('Kyev') ;


---    - Покажите информацию о самом активном клиенте (по количеству купленных билетов) 
if object_id('uf_best_customer')is not null
    drop function uf_best_customer;
go
create function uf_best_customer()
returns table
as 
    return (select top 1 uf.* , sum(uf.[Tickets Count] as 'Tickets bought' from uf_get_clients_with_archives uf group by uf.Id order by sum(uf.[Tickets Count] desc);

go
select * from uf_best_customer() ;










---    - Покажите информацию о самой непопулярной категории (по количеству событий). Архив событий учитывается. 










---    - Отобразите топ-3 набирающих популярность событий (по количеству проданных билетов за 5 дней)   










---    - Покажите все события, которые пройдут сегодня в указанное время. Время передаётся в качестве параметра  










---    - Покажите название городов, в которых сегодня пройдут события  










---    - При вставке нового клиента нужно проверять, нет ли его уже в базе данных. Если такой клиент есть, генерировать ошибку с описанием возникшей проблемы 










---    - При вставке нового события нужно проверять, нет ли его уже в базе данных. Если такое событие есть, генерировать ошибку с описанием возникшей проблемы










---    - При удалении прошедших событий необходимо их переносить в архив событий 










---    - При попытке покупки билета проверять не достигнуто ли уже максимальное количество билетов. Если максимальное количество достигнуто, генерировать ошибку с информацией о возникшей проблеме 










---    - При попытке покупки билета проверять возрастные ограничения. Если возрастное ограничение нарушено, генерировать ошибку с информацией о возникшей проблеме 










---    - Настроить создание резервных копий с периодичностью раз в день.










