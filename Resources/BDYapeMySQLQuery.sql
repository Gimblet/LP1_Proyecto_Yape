
USE SYS;

-- ELIMINANDO TODAS LA BD/TABLAS PARA EMPEZAR RAPIDAMENTE DESDE 0 EL QUERY

DROP DATABASE IF EXISTS dbYape;

SET foreign_key_checks = 0;

DROP TABLE IF EXISTS LOGINS.USUARIO;
DROP TABLE IF EXISTS LOGINS.USUARIO_CLIENTE;
DROP TABLE IF EXISTS LOGINS.USUARIO_ADMIN;
DROP TABLE IF EXISTS LOGINS.USUARIO_HEADADMIN;
DROP TABLE IF EXISTS TRANSACCIONES.DETALLE_USUYAPE;
DROP TABLE IF EXISTS TRANSACCIONES.YAPE;

-- ELIMINANDO LOS ESQUEMAS

DROP SCHEMA IF EXISTS LOGINS;
DROP SCHEMA IF EXISTS TRANSACCIONES;

SET foreign_key_checks = 1;

CREATE DATABASE DBYAPE;
USE DBYAPE;

CREATE SCHEMA LOGINS;
CREATE SCHEMA TRANSACCIONES;

CREATE TABLE LOGINS.USUARIO
(
	COD_USU       	CHAR(5) 	 	   NOT NULL, 					-- CODIGO
    DNI_USU			CHAR(8)		 	   NOT NULL,					-- DNI
    TIP_USU     	VARCHAR(10)  	   NOT NULL, 				  	-- TIPO DE USUARIO
    NOM_USU 		VARCHAR(50)  	   NOT NULL, 				  	-- NOMBRE 
    APE_USU			VARCHAR(50)  	   NOT NULL, 				  	-- APELLIDO
    TEL_USU         CHAR(9) 	 	   NOT NULL UNIQUE, 		  	-- TELEFONO
    CON_USU      	VARCHAR(100) 	   NOT NULL, 				  	-- CONTRASEÑA
    FCC_USU			DATETIME 		   NOT NULL DEFAULT NOW(),		-- FECHA DE CREACION DE CUENTA
    PRIMARY KEY (COD_USU) 
);

CREATE TABLE LOGINS.USUARIO_CLIENTE
(
	COD_CLI			CHAR(5)		 NOT NULL REFERENCES LOGINS.USUARIO,     		-- CODIGO
    SAL_CLI			DOUBLE 		 NOT NULL DEFAULT '0.0' CHECK(SAL_CLI > 0), 	-- SALDO
    PRIMARY KEY(COD_CLI)
);

CREATE TABLE LOGINS.USUARIO_ADMIN
(
	COD_ADM			CHAR(5)		 NOT NULL REFERENCES LOGINS.USUARIO, 		-- CODIGO
    COM_ADM			DOUBLE   	 NOT NULL,									-- COMISION
    PRIMARY KEY(COD_ADM)
);

CREATE TABLE LOGINS.USUARIO_HEADADMIN
(
	COD_HEA			CHAR(5)		 NOT NULL REFERENCES LOGINS.USUARIO, 		-- CODIGO
    SUE_HEA			DOUBLE		 NOT NULL CHECK(SUE_HEA > 0),
    PRIMARY KEY(COD_HEA)
);

CREATE TABLE TRANSACCIONES.DETALLE_USUYAPE
(
	COD_USU		CHAR(5) REFERENCES LOGINS.USUARIO,
    COD_YAP		CHAR(5) REFERENCES TRANSACCIONES.YAPE,
    PRIMARY KEY(COD_USU, COD_YAP)
);

CREATE TABLE TRANSACCIONES.YAPE(
	COD_YAP		CHAR(5)		PRIMARY KEY,						-- CODIGO
    NRC_YAP		CHAR(9)		NOT NULL, 							-- NUMERO RECIBIENTE
    NRT_YAP		CHAR(9)		NOT NULL, 							-- NUMERO REALIZANTE
    MON_YAP		DOUBLE		NOT NULL, 							-- MONTO
    FEC_YAP		DATETIME	NOT NULL DEFAULT NOW(), 			-- FECHA DEL YAPE
    EST_YAP		VARCHAR(20) NOT NULL DEFAULT 'Corriente',
    FOREIGN KEY(NRC_YAP) REFERENCES LOGINS.USUARIO(TEL_USU),
    FOREIGN KEY(NRT_YAP) REFERENCES LOGINS.USUARIO(TEL_USU)
);

/* PARA CORREGIR


INSERT INTO Logins(TipoUsuario, NombreApellidos, Saldo, Numero, Clave) VALUES
('HeadAdmin', 'Diego Villena',     NULL  , 999888777, 'mysql'),

('Admin',     'Pedro Aguilar',     NULL  , 984833714, 'pedro'),
('Admin',     'Maria Lopez',       NULL  , 912345678, 'maria'),
('Admin',     'Ana Rodriguez',     NULL  , 923456789, 'ana'),

('Cliente',   'Valentina Sanchez', 170.35, 945118567, 'vale'),
('Cliente',   'Jesus Garcia',      450.64, 938474942, 'jesus'),
('Cliente',   'Yvet Morales',      912.17, 985729373, 'yvet'),
('Cliente',   'Bryan Villacorta',  345.63, 993762163, 'bryan'),
('Cliente',   'Laura Martinez',    600.25, 987654321, 'laura'),
('Cliente',   'Carlos Fernandez',  400.50, 976543210, 'carlos'),
('Cliente',   'Sofia Ramirez',     300.75, 955443322, 'sofia'),
('Cliente',   'Daniel Perez',      250.20, 944332211, 'daniel'),
('Cliente',   'Monica Gomez',      700.40, 966554433, 'monica'),
('Cliente',   'Jorge Hernandez',   820.30, 978887766, 'jorge'),
('Cliente',   'Paola Castro',      350.60, 967788990, 'paola'),
('Cliente',   'Fernanda Reyes',    430.80, 988776655, 'fernanda'),
('Cliente',   'Andres Torres',     510.90, 999000111, 'andres');

INSERT INTO Yapes(NumeroRealizante, NumeroRecibiente, Monto, Fecha, Hora, Estado) VALUES
-- 1
(945118567, 976543210, 50.34, current_date(), now(), 'Corriente'),
(945118567, 987654321, 132.43, current_date(), now(), 'Corriente'),
(987654321, 945118567, 67.91, current_date(), now(), 'Corriente'),
(945118567, 978887766, 35.86, current_date(), now(), 'Corriente'),
(999000111, 945118567, 12.97, current_date(), now(), 'Corriente'),
-- 2
(938474942, 945118567, 67.91, current_date(), now(), 'Corriente'),
(967788990, 938474942, 163.72, current_date(), now(), 'Corriente'),
(967788990, 938474942, 111.36, current_date(), now(), 'Corriente'),
(938474942, 993762163, 51.62, current_date(), now(), 'Corriente'),
(966554433, 938474942, 95.68, current_date(), now(), 'Corriente'),
-- 3
(985729373, 999000111, 45.78, current_date(), now(), 'Corriente'),
(985729373, 966554433, 132.43, current_date(), now(), 'Corriente'),
(985729373, 976543210, 89.21, current_date(), now(), 'Corriente'),
(999000111, 985729373, 111.36, current_date(), now(), 'Corriente'),
(985729373, 978887766, 24.59, current_date(), now(), 'Corriente'),
-- 4
(993762163, 955443322, 163.72, current_date(), now(), 'Corriente'),
(993762163, 967788990, 70.84, current_date(), now(), 'Corriente'),
(955443322, 993762163, 12.97, current_date(), now(), 'Corriente'),
(967788990, 993762163, 154.26, current_date(), now(), 'Corriente'),
(993762163, 955443322, 38.65, current_date(), now(), 'Corriente'),
-- 5
(987654321, 999000111, 143.28, current_date(), now(), 'Corriente'),
(987654321, 944332211, 67.91, current_date(), now(), 'Corriente'),
(944332211, 987654321, 17.54, current_date(), now(), 'Corriente'),
(987654321, 955443322, 126.73, current_date(), now(), 'Corriente'),
(987654321, 978887766, 51.62, current_date(), now(), 'Corriente'),
-- 6
(976543210, 966554433, 78.49, current_date(), now(), 'Corriente'),
(978887766, 976543210, 160.15, current_date(), now(), 'Corriente'),
(976543210, 993762163, 35.86, current_date(), now(), 'Corriente'),
(976543210, 985729373, 119.37, current_date(), now(), 'Corriente'),
(976543210, 993762163, 95.68, current_date(), now(), 'Corriente'),
-- 7
(955443322, 967788990, 35.86, current_date(), now(), 'Corriente'),
(955443322, 944332211, 24.59, current_date(), now(), 'Corriente'),
(955443322, 978887766, 12.97, current_date(), now(), 'Corriente'),
(955443322, 978887766, 17.54, current_date(), now(), 'Corriente'),
(955443322, 978887766, 10.80, current_date(), now(), 'Corriente'),
(955443322, 967788990, 8.65, current_date(), now(), 'Corriente'),
-- 8
(944332211, 966554433, 132.43, current_date(), now(), 'Corriente'),
(955443322, 944332211, 111.36, current_date(), now(), 'Corriente'),
(955443322, 944332211, 163.72, current_date(), now(), 'Corriente'),
(955443322, 944332211, 154.26, current_date(), now(), 'Corriente'),
(944332211, 978887766, 126.73, current_date(), now(), 'Corriente'),
-- 9
(966554433, 978887766, 26.73, current_date(), now(), 'Corriente'),
(966554433, 967788990, 32.43, current_date(), now(), 'Corriente'),
(999000111, 966554433, 11.36, current_date(), now(), 'Corriente'),
(999000111, 966554433, 63.72, current_date(), now(), 'Corriente'),
(966554433, 993762163, 60.15, current_date(), now(), 'Corriente'),
-- 10
(978887766, 945118567, 160.15, current_date(), now(), 'Corriente'),
(978887766, 945118567, 5.86, current_date(), now(), 'Corriente'),
(985729373, 978887766, 7.91, current_date(), now(), 'Corriente'),
(945118567, 978887766, 54.26, current_date(), now(), 'Corriente'),
(985729373, 978887766, 11.36, current_date(), now(), 'Corriente'),
-- 11
(967788990, 987654321, 263.72, current_date(), now(), 'Corriente'),
(938474942, 967788990, 100.84, current_date(), now(), 'Corriente'),
(993762163, 967788990, 313.65, current_date(), now(), 'Corriente'),
(988776655, 967788990, 78.49, current_date(), now(), 'Corriente'),
(945118567, 967788990, 10.80, current_date(), now(), 'Corriente'),
-- 12
(988776655, 955443322, 8.49, current_date(), now(), 'Corriente'),
(988776655, 955443322, 6.73, current_date(), now(), 'Corriente'),
(988776655, 955443322, 17.54, current_date(), now(), 'Corriente'),
(976543210, 988776655, 12.97, current_date(), now(), 'Corriente'),
(966554433, 988776655, 70.84, current_date(), now(), 'Corriente'),
-- 13
(999000111, 938474942, 38.65, current_date(), now(), 'Corriente'),
(967788990, 999000111, 35.86, current_date(), now(), 'Corriente'),
(999000111, 988776655, 78.49, current_date(), now(), 'Corriente'),
(987654321, 999000111, 119.37, current_date(), now(), 'Corriente'),
(999000111, 985729373, 95.68, current_date(), now(), 'Corriente');

SELECT * FROM Logins;
SELECT * FROM Yapes;

*/