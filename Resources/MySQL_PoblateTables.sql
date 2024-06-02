-- THIS SCRIPT ASUMES THAT THE DB 'BDYAPE' HAS BEEN CREATED, IS UP AND RUNNING WITH CREATED BUT EMPTY TABLES

USE DBYAPE;

/*
	MODELO PARA INSERTAR NUEVO USUARIO
    (HEADADMIN, ADMIN, CLIENTE)
*/
-- ------------------------------- DEMO -----------------------------
-- USUARIO.CLIENTE 1
-- PASO 1: INSERTAR DATOS EN LA TABLA MODELO DE USUARIOS
	INSERT INTO LOGINS.USUARIO
		(DNI_USU, TIP_USU, NOM_USU, APE_USU, TEL_USU, CON_USU)
	VALUES
		('72898111', 'Cliente', 'Diego Anderson', 'Villena Arias', '931888777', 'DIEGO123');
-- PASO 2: SI ES CLIENTE, INGRESAR SALDO, SI ES OTRO TIPO DE USUARIO AGREGAR LOS DATOS ACORDES
	INSERT INTO LOGINS.USUARIO_CLIENTE
	VALUES
		(1, 200.50);
        
-- USUARIO.CLIENTE 2
	INSERT INTO LOGINS.USUARIO
		(DNI_USU, TIP_USU, NOM_USU, APE_USU, TEL_USU, CON_USU)
	VALUES
		('72898222', 'Cliente', 'Joseph Manuel', 'Villena Arias', '912888777', 'JOSEPH123');
        
	INSERT INTO LOGINS.USUARIO_CLIENTE
	VALUES
		(2, 200.50);
        
-- USUARIO.CLIENTE 3
	INSERT INTO LOGINS.USUARIO
		(DNI_USU, TIP_USU, NOM_USU, APE_USU, TEL_USU, CON_USU)
	VALUES 
		('98329012', 'Cliente', 'Laura Camila', 'Sanchez Ruiz', '945888777', 'LAURA123');

	INSERT INTO LOGINS.USUARIO_CLIENTE
	VALUES 
		(3, 120.62);
-- PASO 3: COMPROBAR LOS DATOS INGRESADOS
	/* 
		SELECT * 
		FROM LOGINS.USUARIO AS U
			INNER JOIN LOGINS.USUARIO_CLIENTE AS C
			ON U.COD_USU = C.COD_CLI
		WHERE C.COD_CLI = 1 AND U.COD_USU = 1; 		-- ELIMNAR EL WHERE PARA LISTAR TODOS LOS USUARIOS
    */

/*
	MODELO PARA REALIZAR UNA TRANSACCION (YAPE)
*/

-- PASO 1: INSERTAR EN LA TABLA YAPE LOS DATOS DEL NUMERO RECIBIENTE, NUMERO REALIZANTE Y MONTO (ASEGURAR QUE TODOS LOS DATOS SEAN VALIDOS)
	INSERT INTO TRANSACCIONES.YAPE
		(NRC_YAP, NRT_YAP, MON_YAP)
	VALUES
		('931888777','912888777','10.5');
-- PASO 2 : ASOCIAR LA TRANSACCION CON EL NUMERO REALIZANTE/RECIBIENTE
	INSERT INTO TRANSACCIONES.DETALLE_USUYAPE
	VALUES (1,1);	-- USUARIO 1 CON YAPE 1

	INSERT INTO TRANSACCIONES.DETALLE_USUYAPE
	VALUES (2,1);	-- USUARIO 2 CON YAPE 1

-- PASO 3: COMPROBAR LA TRANSACCION
	/* 
    DISCLAIMER : LISTA CASI TODOS LOS DATOS DEL USUARIO, AGREGAR O ELIMINAR DATOS SEGUN NECESIDAD
    
	SELECT 	U.COD_USU, U.DNI_USU, U.TIP_USU, U.NOM_USU, U.APE_USU, U.TEL_USU, U.FCC_USU,
			Y.COD_YAP, Y.NRC_YAP, Y.NRT_YAP, Y.MON_YAP, Y.FEC_YAP, Y.EST_YAP
	FROM LOGINS.USUARIO 							AS U 
		INNER JOIN TRANSACCIONES.DETALLE_USUYAPE 	AS DT
			ON U.COD_USU = DT.COD_USU
		INNER JOIN TRANSACCIONES.YAPE 				AS Y
			ON DT.COD_YAP = Y.COD_YAP
	WHERE Y.COD_YAP = 1;
    */

/*
	MODELO PARA MODIFICAR UNA TRANSACCION (YAPE)
*/

-- PASO 1 : ACTUALIZAR LA TABLA YAPES
		UPDATE TRANSACCIONES.YAPE
			SET NRC_YAP = 945888777,
				MON_YAP = 30.00, 
				FEC_YAP= NOW(), 
                EST_YAP='Modificado'
		WHERE COD_YAP = 1;
-- PASO 2 : ACTUALIZAR LA TABLA DETALLE DE YAPES Y USUARIOS
		UPDATE 	TRANSACCIONES.DETALLE_USUYAPE
			SET	COD_USU = 3
		WHERE COD_USU = 1 AND COD_YAP = 1;		-- TENER ESPECIAL CUIDADO CON EL CODIGO DE USUARIO A MODIFICAR
        
/*
	MODELO PARA ELIMINAR UNA TRANSACCION (YAPE)
*/

	-- PASO 1 : CAMBIAR EL ESTADO DE LA TRANSACCION Y  ACTUALIZAR LA FECHA DEL YAPE
    UPDATE  TRANSACCIONES.YAPE
		SET EST_YAP = 'Eliminado',
			FEC_YAP = NOW()
	WHERE COD_YAP = 1;
    
    insert intO INFORMATIVOS.COMISION VALUES (20.5, NOW());
    insert intO INFORMATIVOS.COMISION VALUES (15.2, NOW());
    
-- ---------------------------------- CREAR FUNCTIONS --------------------------------
-- RETORNA EL CODIGO DEL ULTIMO USUARIO CREADO
DELIMITER $$
CREATE FUNCTION FN_GetUltimoUsuario()
	RETURNS INT
    DETERMINISTIC
BEGIN
	DECLARE TEMP_COD INT;
    
	SELECT COD_USU INTO TEMP_COD 
    FROM LOGINS.USUARIO 
		ORDER BY COD_USU DESC
		LIMIT 1;
    
    RETURN TEMP_COD;
END $$
DELIMITER ;

-- RETORNA EL ULTIMO VALOR DE COMISION
DELIMITER $$
CREATE FUNCTION FN_ValorComision()
	RETURNS INT
    DETERMINISTIC
BEGIN
	DECLARE VALOR DOUBLE;
    
    SELECT 	VAL_COM INTO VALOR 
    FROM INFORMATIVOS.COMISION 
		ORDER BY FEA_COM DESC
        LIMIT 1;
        
	RETURN VALOR;
END$$
DELIMITER ;

-- ---------------------------------  CREAR STORED PROCEDURES ----------------------------------
-- REGISTRAR CLIENTE
DELIMITER $$
CREATE PROCEDURE SP_RegistrarCliente
(
	Dni 		CHAR(8),
    Nombres 	VARCHAR(50),
    Apellidos	VARCHAR(50),
    Telefono	CHAR(9),
    Clave		VARCHAR(100),
    Saldo		DOUBLE
)
BEGIN
	DECLARE Codigo INT;

	INSERT INTO LOGINS.USUARIO
		(DNI_USU, TIP_USU, NOM_USU, APE_USU, TEL_USU, CON_USU)
	VALUES
		(Dni, 'Cliente', Nombres, Apellidos, Telefono, Clave);
	
    SET Codigo = FN_GetUltimoUsuario();
    
	INSERT INTO LOGINS.USUARIO_CLIENTE
	VALUES
		(Codigo, Saldo);
END $$
DELIMITER ;

CALL SP_RegistrarCliente('72844444', 'Julio Diego', 'Perez Sanchez', '999888777','Julio123', 1000.24);

-- REGISTRAR ADMINISTRADOR (ADMIN)
DELIMITER $$
CREATE PROCEDURE SP_RegistrarAdmin
(
	Dni 		CHAR(8),
    Nombres 	VARCHAR(50),
    Apellidos	VARCHAR(50),
    Telefono	CHAR(9),
    Clave		VARCHAR(100),
    Sueldo		DOUBLE
)
BEGIN
	DECLARE Codigo INT;

	INSERT INTO LOGINS.USUARIO
		(DNI_USU, TIP_USU, NOM_USU, APE_USU, TEL_USU, CON_USU)
	VALUES
		(Dni, 'Admin', Nombres, Apellidos, Telefono, Clave);
        
	SET CODIGO = FN_GetUltimoUsuario();
        
	INSERT INTO LOGINS.USUARIO_ADMIN
		(COD_ADM,SUB_ADM)
	VALUES
		(Codigo, Sueldo);
END $$
DELIMITER ;

CALL SP_RegistrarAdmin('72844445', 'Malcom Javier', 'Jurado Vilchez', '999888666','Malcom', 1200.10);

-- REGISTRAR ADMINISTRADOR PRINCIPAL (HEADADMIN)
DELIMITER $$
CREATE PROCEDURE SP_RegistrarHeadAdmin
(
	Dni 		CHAR(8),
    Nombres 	VARCHAR(50),
    Apellidos	VARCHAR(50),
    Telefono	CHAR(9),
    Clave		VARCHAR(100),
    Sueldo		DOUBLE
)
BEGIN
	DECLARE Codigo INT;

	INSERT INTO LOGINS.USUARIO
		(DNI_USU, TIP_USU, NOM_USU, APE_USU, TEL_USU, CON_USU)
	VALUES
		(Dni, 'Admin', Nombres, Apellidos, Telefono, Clave);
        
	SET CODIGO = FN_GetUltimoUsuario();
        
	INSERT INTO LOGINS.USUARIO_HEADADMIN
	VALUES
		(Codigo, Sueldo);
END $$
DELIMITER ;

CALL SP_RegistrarHeadAdmin('72844443', 'Julieta Laura', 'Iglesias Prieto', '999888111','Julieta', 1920.46);

SELECT * FROM LOGINS.USUARIO u Inner Join Logins.usuario_cliente c on  u.cod_usu = c.cod_cli;
SELECT * FROM LOGINS.USUARIO u Inner Join Logins.usuario_admin a on  u.cod_usu = a.COD_ADM;
SELECT * FROM LOGINS.USUARIO u Inner Join Logins.usuario_headadmin h on  u.cod_usu = h.COD_HEA;

-- ----- TO DO

-- Crear procedimientos para listar los datos de los usuarios
-- Crear Procedimientos para actualizar los campos de los usuarios
-- Crear Procedimientos para eliminar los campos usuarios (Crear tabla para almacenar Yapes/ agregar campo a clientes para habilitar/deshabilitar cuenta)

-- Crear Procedimientos para actualizar los campos de un yape
-- Crear Procedimientos para eliminar un yape (cambiar el estado de corriente/modificado a elminado y posiblemente moverlo a la tabla de yapes eliminados)

-- INSERTAR UNOS CUANTOS USUARIOS Y YAPES DE PRUEBA (USAR PROCEDIMIENTOS ALMACENADOS)

-- --------

-- CONSULTAR UN YAPE REALIZADO
DELIMITER $$
CREATE PROCEDURE SP_ConsultarYape(ID_Yape INT)
BEGIN
	SELECT 	U.COD_USU, U.DNI_USU, U.NOM_USU, U.APE_USU, U.TEL_USU,
			Y.COD_YAP, Y.NRC_YAP, Y.NRT_YAP, Y.MON_YAP, Y.FEC_YAP, Y.EST_YAP
		FROM 		LOGINS.USUARIO 					AS U 
		INNER JOIN 	TRANSACCIONES.DETALLE_USUYAPE 	AS DT
		ON 			U.COD_USU = DT.COD_USU
		INNER JOIN 	TRANSACCIONES.YAPE 				AS Y
		ON 			DT.COD_YAP = Y.COD_YAP
	WHERE Y.COD_YAP = ID_Yape;
END $$
DELIMITER ;

CALL SP_ConsultarYape(1);


-- ------------------------------ BULK DATA -------------------------------

-- ELIMINANDO CLIENTE
/*
DELETE FROM LOGINS.USUARIO_CLIENTE
WHERE COD_CLI = 1;

DELETE FROM LOGINS.USUARIO
WHERE COD_USU = 1;																

select * from logins.usuario;
*/

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