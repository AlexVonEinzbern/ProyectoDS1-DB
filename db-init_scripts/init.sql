CREATE TABLE Usuarios (
	idUsuario SMALLSERIAL NOT NULL PRIMARY KEY,
	nombreUsuario VARCHAR(50) NOT NULL,
	cedulaUsuario INT NOT NULL,
	direccionUsuario VARCHAR(50),
	telefonoUsuario INT,
	fechaIngresoUsuario DATE,
	sucursalUsuario VARCHAR(50),
	rolUsuario VARCHAR(20)
);

CREATE TABLE UsuariosAdministrador() INHERITS(Usuarios);

CREATE TABLE UsuariosGerente() INHERITS(Usuarios);

CREATE TABLE UsuariosOperador() INHERITS(Usuarios);

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
	idCliente REFERENCES Cliente,
	fechaVenceFactura DATE
);

