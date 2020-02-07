---    - Пользователь с полным доступом ко всей информации 
create login "Admin" with password = '16charpass';
go
create user UserAdmin for login "Admin";
go
exec sp_addrolemember 'db_owner' , 'UserAdmin';
go

---    - Пользователь с правом только на чтение данных 
create login "Reader" with password = '16charpass';
go
create user UserReader for login "Reader";
go
exec sp_addrolemember 'db_datareader' , 'UserReader';
go


---    - Пользователь с правом резервного копирования и восстановления данных 
go
create login Backupper with password = 'Backupper';
go
create user UserBackupper for login Backupper;
go
exec sp_addrolemember 'db_backupoperator', 'UserBackupper';


---    - Пользователь с правом создания и удаления пользователей. 
go
create login Spawner with password = 'Spawner';
go
create user UserSpawner for login Spawner;
go
exec sp_addrolemember 'db_accessadmin', 'UserSpawner';

