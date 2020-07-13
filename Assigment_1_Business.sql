Create database Assignment_1_Business
go
use Assignment_1_Business
go


create table Cities
(
ID_City int identity primary key,
Name_City nvarchar(60),
Zip_Code nvarchar(30),
)


create table Providers
(
ID_Provider int identity primary key,
Name_Provider nvarchar(60),
Last_Name_Provider nvarchar(60),
Phone_Provider nvarchar(20),
ID_City int foreign key references Cities (ID_City)
)


create table Clients
(
ID_Client int identity primary key,
Name_Client nvarchar(60),
Last_Name_Client nvarchar(60),
Phone_Client nvarchar(15),
Address_Client nvarchar(60),
ID_City int foreign key references Cities (ID_City)
)


create table Products
(
ID_Product int identity primary key,
Description_Product nvarchar(240),
Price_Product int,
Weight_Product int,
ID_Provider int foreign key references Providers (ID_Provider)
)


create table Orders
(
ID_Order int identity primary key,
ID_Client int foreign key references Clients (ID_Client),
Date_Order date,
)


create table Orders_Products
(
ID_Order int foreign key references Orders (ID_Order),
ID_Product int foreign key references Products (ID_Product),
Amount_Product int,
)
go
insert into Cities values
('Corrientes','2320'),
('Cordoba','2200'),
('Santa Fe','2100'),
('Rosario','2000'),
('Valparaiso','4000'),
('Rio de Janeiro','1000');


insert into providers values
('Hernesto','Valdes','4569872',4),
('Jorge Humberto','Vildoso','4563214',1),
('Gastón','Ruiz','4596321',3),
('Mijail','Bleynat','4542147',3),
('Bruno', 'Diaz','4523685',5);


insert into Clients values
('Ezequiel','Alderete', '4523698', 'Zeballos 3540', 5),
('Nahuel', 'Barrutia', '4545872', 'España 6987', 6),
('Franco ', 'Zancocchia', '4575364', 'Corrientes 2587', 1),
('Lorenzo', 'Vecchia', '4524198', 'Italia 3324', 2);




insert into Products values
('El posicoanalista',1050,50,1),
('Meteorologia Regional',350,30,2),
('La Profecia',500,35,3),
('Caricias de horror',1000,70,3),
('La Historia del loco',1050,50,1),
('Harry Potter la Orden del Fenix',1150,50,5),
('Robot, Ciencia que Ladra...',100,20,2),
('Mavimientos Tacticos Básicos de Ajedrez',200,20,4),
('Animales Fantasticos',1250,50,5),
('Ajedrez Avanzado',1000,100,4),
('La Tierra',225,50,2);


insert into Orders values
(1, '2020-03-03'),
(3, '2020-04-20'),
(2, '2020-05-05'),
(1, '2020-06-10'),
(2, '2020-07-26'),
(4, '2020-08-13'),
(3, '2020-09-22');


insert into Orders_Products values
(4, 1, 1),
(4, 5, 1),
(5, 1, 1),
(6, 6, 3),
(7, 3, 1),
(10, 1, 2),
(9, 7, 4);




--Mostrar todas las localidades (sin repetir) en la que existen proveedores
select distinct Cities.Name_City from Providers
inner join Cities on Providers.ID_City = Cities.ID_City
order by Name_City


--Mostrar proveedores ordenados por localidad
select Name_Provider, Cities.Name_City from Providers
inner join Cities on Providers.ID_City = Cities.ID_City
order by Name_City


--Mostrar id_producto y peso de los productos 8 y 11 
select ID_Product, Weight_Product from Products where (ID_Product = 8 or ID_Product = 11)


--Calcular el promedio de peso de todos los productos
select avg(Weight_Product) from Products


--Contar cuantos clientes hay por ciudad
select Cities.Name_City, count(*) from Clients
inner join Cities on Clients.ID_City = Cities.ID_City
Group By Cities.Name_City


--Mostrar de todos los pedidos el id_pedido y fecha con su dirección completa de entrega
select ID_Order, Clients.Address_Client from Orders
inner join Clients on Orders.ID_Client = Clients.ID_City


--Mostrar el nombre de proveedor afectado a cada pedido
select ID_Order, Providers.Name_Provider, Providers.Last_Name_Provider from Orders_Products
inner join Products on Orders_Products.ID_Product = Products.ID_Product
inner join Providers on Products.ID_Provider = Providers.ID_Provider