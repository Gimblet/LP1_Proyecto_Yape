DROP DATABASE IF EXISTS dbYape;

CREATE DATABASE dbYape;
USE dbYape;

SET lc_time_names = 'es_ES';

CREATE TABLE Logins(
	IdUsuario       INT AUTO_INCREMENT PRIMARY KEY,
    TipoUsuario     VARCHAR(10) NOT NULL,
    NombreApellidos VARCHAR(100) NOT NULL,
    Saldo			DOUBLE NOT NULL,
    Numero          INT(9) NOT NULL UNIQUE,
    Clave      		VARCHAR(100) NOT NULL
);

CREATE TABLE CurrentUsers(
	Numero          INT(9) PRIMARY KEY,
	NombreApellidos VARCHAR(100)
);

CREATE TABLE Yapes(
	IdYape INT AUTO_INCREMENT PRIMARY KEY,
    NumeroRealizante INT(9) NOT NULL,
    NumeroRecibiente INT(9) NOT NULL,
    Monto DOUBLE NOT NULL,
    Fecha DATE,
    Hora DATETIME,
    FOREIGN KEY(NumeroRealizante) REFERENCES Logins(Numero)
);

INSERT INTO Logins(TipoUsuario, NombreApellidos, Saldo, Numero, Clave) VALUES
('HeadAdmin', 'Diego Villena', 500.25, 999888777, 'mysql'),
('Admin', 'Pedro Aguilar', 720.63, 984833714, 'pedro'),
('Cliente', 'Valentina Sanchez', 170.35, 945118567, 'vale'),
('Cliente', 'Jesus Garcia', 450.64, 938474942, 'jesus'),
('Cliente', 'Yvet Morales', 912.17, 985729373, 'yvet'),
('Cliente', 'Bryan Villacorta', 345.63, 993762163, 'bryan');

INSERT INTO Yapes(NumeroRealizante, NumeroRecibiente, Monto, Fecha, Hora) VALUES
(945118567, 938474942, 50, current_date(), now()),
(985729373, 945118567, 38.23, current_date(), now()),
(993762163, 938474942, 10.80, current_date(), now());

SELECT * FROM Logins;
SELECT * FROM Yapes;