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
	estado BOOLEAN,
	password TEXT NOT NULL
);

CREATE TABLE Cliente(
	idCliente SMALLSERIAL NOT NULL PRIMARY KEY,
	nombreCliente VARCHAR(50) NOT NULL,
	cedulaCliente INT NOT NULL,
	direccionCliente VARCHAR(50),
	telefonoCLiente VARCHAR(50),
	fechaAfiliacionCliente DATE
);

CREATE TABLE Factura(
	idFactura SMALLSERIAL NOT NULL PRIMARY KEY,
	idCliente SMALLSERIAL REFERENCES Cliente,
	fechaVenceFactura DATE
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
