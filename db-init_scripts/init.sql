CREATE EXTENSION pgcrypto;

CREATE TABLE Usuarios (
	idUsuario SMALLSERIAL NOT NULL PRIMARY KEY,
	nombreUsuario VARCHAR(50) NOT NULL,
	cedulaUsuario INT NOT NULL,
	direccionUsuario VARCHAR(50),
	telefonoUsuario INT,
	fechaIngresoUsuario DATE,
	sucursalUsuario VARCHAR(50),
	rolUsuario VARCHAR(20),
	estadoUsuario BOOLEAN,
	emailUsuario VARCHAR(50),
	password TEXT NOT NULL
);

CREATE TABLE Cliente(
	idCliente SMALLSERIAL NOT NULL PRIMARY KEY,
	nombreCliente VARCHAR(50) NOT NULL,
	cedulaCliente INT NOT NULL,
	direccionCliente VARCHAR(50),
	telefonoCLiente INT,
	fechaAfiliacionCliente DATE,
	estadoCliente BOOLEAN,
	emailCliente VARCHAR(50) NOT NULL
);

CREATE TABLE Factura(
	idFactura SMALLSERIAL NOT NULL PRIMARY KEY,
	idCliente SMALLSERIAL REFERENCES Cliente,
	fechaVenceFactura DATE,
	estadoFactura Boolean default false
);

CREATE TABLE Activos(
	idActivo INT NOT NULL PRIMARY KEY,
	nombreActivo VARCHAR(50),
	ubicacionActivo VARCHAR(50)
);

CREATE TABLE Medida(
	idMedida SMALLSERIAL NOT NULL PRIMARY KEY,
	idCliente SMALLSERIAL REFERENCES Cliente,
	idUsuario SMALLSERIAL REFERENCES Usuarios,
	fechaMedida DATE,
	medida DECIMAL
);

CREATE TABLE RegistroPago(
	idPago SMALLSERIAL NOT NULL PRIMARY KEY,
	idUsuario SMALLSERIAL REFERENCES Usuarios,
	idFactura SMALLSERIAL REFERENCES Factura,
	pago DECIMAL,
	fechaPago DATE
);

CREATE TABLE ConfigurarSistema(
	idConfiguracion SMALLSERIAL NOT NULL PRIMARY KEY,
	idUsuario SMALLSERIAL REFERENCES Usuarios,
	fechaConfiguracion DATE,
	interesMora DECIMAL,
	reconexion DECIMAL,
	unidadEnergia DECIMAL
);

CREATE TABLE DetalleFactura(
	idDetalle SMALLSERIAL NOT NULL PRIMARY KEY,
	idFactura SMALLSERIAL REFERENCES Factura,
	idMedida SMALLSERIAL REFERENCES Medida,
	idConfiguracion SMALLSERIAL REFERENCES ConfigurarSistema
);
-- Trigger para llenar factura y detallefactura
CREATE or replace  FUNCTION oninsertMedida() RETURNS TRIGGER AS $$
BEGIN
insert into DetalleFactura (idDetalle, idFactura, idMedida, idConfiguracion) values (new.idmedida,new.idmedida,new.idmedida,(select idConfiguracion from configurarsistema order by idconfiguracion desc limit 1))
insert into Factura (idFactura, idCliente, fechaVenceFactura,estadoFactura) values (new.idmedida,new.idcliente,(current_date + ' 15 day'::interval),false)
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create TRIGGER oninsertMedidaTGG after insert ON Medida FOR EACH ROW EXECUTE PROCEDURE oninsertMedida();


/*Datos de la base de datos*/

/*Datos para la tabla Usuarios*/
INSERT INTO usuarios (nombreusuario, cedulausuario, direccionusuario, telefonousuario, fechaingresousuario, sucursalusuario, rolusuario, estadousuario, emailusuario, password) VALUES ('TOMAS GINES CRUZ', 16130812, '8987 Enim. Rd.', 0224773, '2010-06-12', 'Norte', 'Operador', true, 'TOMAS.GINES.CRUZ@ergy.com', 'eMuHrfNHP');
INSERT INTO usuarios (nombreusuario, cedulausuario, direccionusuario, telefonousuario, fechaingresousuario, sucursalusuario, rolusuario, estadousuario, emailusuario, password) VALUES ('JAVIER ESPINO PARRADO', 16360109, '911-3717 Vestibulum Rd.', 7230547, '2015-10-10', 'Norte', 'Operador', true, 'JAVIER.ESPINO.PARRADO@ergy.com', 'kMi71gYGx');
INSERT INTO usuarios (nombreusuario, cedulausuario, direccionusuario, telefonousuario, fechaingresousuario, sucursalusuario, rolusuario, estadousuario, emailusuario, password) VALUES ('ROSA MARIA TORRICO CARBONELL', 16671018, '879-7705 Tempor St.', 8620541, '2018-02-02', 'Sur', 'Admin', true, 'ROSA.MARIA.TORRICO.CARBONELL@ergy.com', 'xdlr4sC7I');
INSERT INTO usuarios (nombreusuario, cedulausuario, direccionusuario, telefonousuario, fechaingresousuario, sucursalusuario, rolusuario, estadousuario, emailusuario, password) VALUES ('RAQUEL SALIDO CAMARA', 16890711, 'P.O. Box 363, 4794 Mauris Rd.', 6490505, '2009-11-10', 'Sur', 'Admin', true, 'RAQUEL.SALIDO.CAMARA@ergy.com', 'gAN2JBYxm');
INSERT INTO usuarios (nombreusuario, cedulausuario, direccionusuario, telefonousuario, fechaingresousuario, sucursalusuario, rolusuario, estadousuario, emailusuario, password) VALUES ('MARIA CRISTINA HENRIQUEZ FANDIÑO', 16550922, 'Ap #121-2397 Bibendum Rd.', 3190264, '2003-07-01', 'Norte', 'Gerente', true, 'MARIA.CRISTINA.HENRIQUEZ.FANDIÑO@ergy.com', 'X16DW7sww');

/*Datos para la tabla Clientes*/
INSERT INTO cliente (nombreCliente, cedulaCliente, direccionCliente, telefonoCLiente, fechaAfiliacionCliente, estadoCliente, emailCliente) VALUES ('HUGO TEJERA GARRIDO', 16791223, 'P.O. Box 588, 4063 Molestie Rd.', 9776080, '2013-12-01', true, 'HUGO.TEJERA.GARRIDO@gmail.com');
INSERT INTO cliente (nombreCliente, cedulaCliente, direccionCliente, telefonoCLiente, fechaAfiliacionCliente, estadoCliente, emailCliente) VALUES ('MARINA RECUERO NOYA', 16860319, 'P.O. Box 561, 7790 Aliquam Road', 2408606, '2018-02-10', true, 'MARINA.RECUERO.NOYA@gmail.com');
INSERT INTO cliente (nombreCliente, cedulaCliente, direccionCliente, telefonoCLiente, fechaAfiliacionCliente, estadoCliente, emailCliente) VALUES ('MANUEL CAMARERO VILLALONGA', 16230117, '140-8801 Eu, Rd.', 9603013, '2015-07-07', true, 'MANUEL.CAMARERO.VILLALONGA@gmail.com');
INSERT INTO cliente (nombreCliente, cedulaCliente, direccionCliente, telefonoCLiente, fechaAfiliacionCliente, estadoCliente, emailCliente) VALUES ('MARGARITA SOLE ESCOBEDO', 16770109, '511-1298 Velit. St.', 2471026, '2009-01-01', true, 'MARGARITA.SOLE.ESCOBEDO@gmail.com');
INSERT INTO cliente (nombreCliente, cedulaCliente, direccionCliente, telefonoCLiente, fechaAfiliacionCliente, estadoCliente, emailCliente) VALUES ('MARC TENDERO COLOMER', 16811212, 'Ap #368-9591 Metus St.', 9706173, '2019-08-05', true, 'MARC.TENDERO.COLOMER@gmail.com');

/*Datos para la tabla Activos*/
INSERT INTO activos (idActivo, nombreActivo, ubicacionActivo) VALUES (6189545532017, 'General Electric', '143-4859 Curae; St.');
INSERT INTO activos (idActivo, nombreActivo, ubicacionActivo) VALUES (8603190664469, 'Siemens', '303-9523 Non, Rd.');
INSERT INTO activos (idActivo, nombreActivo, ubicacionActivo) VALUES (2480137404144, 'General Electric', '2474 Sit Street');
INSERT INTO activos (idActivo, nombreActivo, ubicacionActivo) VALUES (1990722859279, 'Siemens', '112-926 Porta Rd.');
INSERT INTO activos (idActivo, nombreActivo, ubicacionActivo) VALUES (3461831326313, 'Mitsubishi Electric', 'P.O. Box 598, 2544 Nascetur St.');

/*Datos para la tabla Medida*/
INSERT INTO medida (idCliente, idUsuario, fechamedida, medida) VALUES (1, 1, '2020-10-29', 20.2);
INSERT INTO medida (idCliente, idUsuario, fechamedida, medida) VALUES (2, 1, '2020-10-29', 40.2);
INSERT INTO medida (idCliente, idUsuario, fechamedida, medida) VALUES (3, 2, '2020-10-29', 36.5);
INSERT INTO medida (idCliente, idUsuario, fechamedida, medida) VALUES (4, 2, '2020-10-29', 48.1);
INSERT INTO medida (idCliente, idUsuario, fechamedida, medida) VALUES (5, 2, '2020-10-29', 53.8);

/*Datos para la tabla ConfigurarSistema*/
INSERT INTO configurarsistema (idUsuario, fechaConfiguracion, interesMora, reconexion, unidadEnergia) VALUES (4, '2010-12-08', 0.01, 26000, 420);
INSERT INTO configurarsistema (idUsuario, fechaConfiguracion, interesMora, reconexion, unidadEnergia) VALUES (4, '2012-12-07', 0.01, 28000, 440);
INSERT INTO configurarsistema (idUsuario, fechaConfiguracion, interesMora, reconexion, unidadEnergia) VALUES (4, '2016-12-09', 0.01, 30000, 460);
INSERT INTO configurarsistema (idUsuario, fechaConfiguracion, interesMora, reconexion, unidadEnergia) VALUES (3, '2018-12-10', 0.01, 32000, 480);
INSERT INTO configurarsistema (idUsuario, fechaConfiguracion, interesMora, reconexion, unidadEnergia) VALUES (3, '2019-12-05', 0.01, 34000, 500);
