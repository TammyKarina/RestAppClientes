Create database CoreFinancieroInternacional;

Use CoreFinancieroInternacional;

CREATE TABLE TipoPersona
(	
	Id_Tipo int identity (1, 1) primary key,
	Descripcion varchar(20),
	Cargo varchar(20)
);CREATE TABLE Clientes
(	
	Id_Cliente varchar (9) primary key,
	Nombre varchar (30),
	Apellido varchar (30),
	Edad int,
	Id_Tipo int,
	CONSTRAINT fk_TipoPersona FOREIGN KEY (Id_Tipo) REFERENCES TipoPersona (Id_Tipo)	
);

CREATE TABLE Cuentas
(
	Id_Cuenta int identity (1, 1) primary key,
	Numero_Cuenta varchar (11),
	Numero_Enmascarado varchar (11),
	Fecha_Creacion_Cuenta dateTime,
	Id_Cliente varchar (9),
	CONSTRAINT fk_Clientes FOREIGN KEY (Id_Cliente) REFERENCES Clientes (Id_Cliente),
);

CREATE TABLE TipoTransaccion
(	
	Id_Tipo char(1) primary key,
	Descripcion varchar(20)
);

CREATE TABLE Movimientos
(
	Id_Movimiento int identity (1, 1) primary key,
	Fecha datetime,
	Monto decimal,
	Descripcion varchar (50),
	Id_Cuenta int,
	Id_Tipo char(1),
	CONSTRAINT fk_Cuentas FOREIGN KEY (Id_Cuenta) REFERENCES Cuentas (Id_Cuenta),
	CONSTRAINT fk_TipoTransaccion FOREIGN KEY (Id_Tipo) REFERENCES TipoTransaccion (Id_Tipo),
);


Insert Into TipoPersona (Descripcion) values ('Cliente');
Insert Into TipoPersona (Descripcion, Cargo) values ('Empleado', 'Desarrollador');


Insert Into TipoTransaccion (Id_Tipo,Descripcion) values ('C','Crédito');
Insert Into TipoTransaccion (Id_Tipo,Descripcion) values ('D','Débito');

Insert Into Clientes (Id_Cliente, Nombre, Apellido, Edad, Id_Tipo) values ('001384529', 'Jaimito','Pérez',38, 1);
Insert Into Clientes (Id_Cliente, Nombre, Apellido, Edad, Id_Tipo) values ('008283819', 'Luis','Mendoza',31, 2);

Insert Into Cuentas (Numero_Cuenta,Numero_Enmascarado,Fecha_Creacion_Cuenta,Id_Cliente) values ('9558311100', '95583XXX00', GETDATE(),'001384529');
Insert Into Cuentas (Numero_Cuenta,Numero_Enmascarado,Fecha_Creacion_Cuenta,Id_Cliente) values ('1328922200', '13289XXX00', GETDATE(),'008283819');

Insert Into Movimientos(Fecha,Monto,Descripcion,Id_Cuenta,Id_Tipo) values (GETDATE(),1500,'Salario',1,'C');
Insert Into Movimientos(Fecha,Monto,Descripcion,Id_Cuenta,Id_Tipo) values (GETDATE(),10,'Compra Online',1,'D');
Insert Into Movimientos(Fecha,Monto,Descripcion,Id_Cuenta,Id_Tipo) values (GETDATE(),12,'Trasferencia a otro Banco',1,'D');
Insert Into Movimientos(Fecha,Monto,Descripcion,Id_Cuenta,Id_Tipo) values (GETDATE(),80,'Ahorrro',1,'C');

Insert Into Movimientos(Fecha,Monto,Descripcion,Id_Cuenta,Id_Tipo) values (GETDATE(),2000,'Salario',2,'C');
Insert Into Movimientos(Fecha,Monto,Descripcion,Id_Cuenta,Id_Tipo) values (GETDATE(),200,'Compra Online',2,'D');
Insert Into Movimientos(Fecha,Monto,Descripcion,Id_Cuenta,Id_Tipo) values (GETDATE(),12,'Trasferencia a otro Banco',2,'D');
Insert Into Movimientos(Fecha,Monto,Descripcion,Id_Cuenta,Id_Tipo) values (GETDATE(),80,'Ahorrro',2,'C');

GO  
CREATE PROCEDURE ConsultarMovimiento  
    @Id_Cliente varchar(9)    
AS   
    SET NOCOUNT ON;  
	Select CTA.Numero_Enmascarado as Cuenta, M.Fecha, M.Descripcion, M.Monto, T.Descripcion
	from Movimientos as M, Clientes as C, Cuentas as CTA, TipoTransaccion as T
	Where M.Id_Cuenta = CTA.Id_Cuenta and CTA.Id_Cliente = C.Id_Cliente 
	and M.Id_Tipo = T.Id_Tipo
	and C.Id_Cliente = @Id_Cliente
GO

GO  
CREATE PROCEDURE ConsultarSaldoActual  
    @Id_Cliente varchar(9)    
AS   
    SET NOCOUNT ON;  
	Select C.Nombre,C.Apellido,CTA.Numero_Enmascarado,
	Sum (M.Monto * case when T.Id_Tipo = 'C' then 1 else -1 END) as 'Saldo Actual' 
	from Movimientos as M, Clientes as C, Cuentas as CTA, TipoTransaccion as T
	Where M.Id_Cuenta = CTA.Id_Cuenta and CTA.Id_Cliente = C.Id_Cliente 
	and M.Id_Tipo = T.Id_Tipo
	and C.Id_Cliente = @Id_Cliente 
	group by  C.Nombre,C.Apellido,CTA.Numero_Enmascarado
GO

