-- ----- TO DO

-- LOS NUMEROS AL COSTADO DE LOS TODOS INDICAN DIFICULTAD DE REALIZACION

-- AGREGAR VALIDACION DE Y DNI AL MOMENTO DE AGREGAR USUARIOS (MOSTRAR MENSAJE SI ES QUE LOS DATOS SON DUPLICADOS) (MODIFICAR PROCEDIMIENTO ALMACENADO) 2

-- Crear Procedimiento para actualizar la comision, sueldo y sueldo del mes de un administrador (tener en cuenta que la suma de las comisiones y el sueldo base da el sueldo final) 4
-- Crear Procedimientos para eliminar un usuario (Cambiar el estado del cliente a inactivo, no eliminar la tabla del cliente como tal) 1 

-- Crear Procedimientos para Insertar/Realizar un yape (Verificar que el saldo sea suficiente, que el numero exista y que el estado de cuenta de los clientes esten activos) 4
-- Crear Procedimientos para actualizar los campos de un yape (DEJAR ESTE PROCEDIMIENTO AL FINAL) 6
-- Crear Procedimientos para eliminar un yape (Cambiar el estado del yape a eliminado, devolver el dinero al yapero y quitar el dinero al beneficiaro del yape, no eliminar el registro del yape como tal) 5

-- --------

-- REGISTRA UN CLIENTE CON SALDO POR DEFECTO (0)
DELIMITER $$
	CREATE PROCEDURE SP_RegistrarCliente
	(
		Dni 		CHAR(8),
		Nombres 	VARCHAR(50),
		Apellidos	VARCHAR(50),
		Telefono	CHAR(9),
		Clave		VARCHAR(100)
	) Procedimiento:
	BEGIN
		DECLARE TelefonoExiste VARCHAR(10);
		DECLARE Codigo INT;
		SET 	TelefonoExiste = FN_VerificarSiTelefonoExiste(Telefono);

		IF (TelefonoExiste != 'No Existe') THEN
			SELECT 'ERROR > El telefono Ingresado ya se encuentra registrado' AS Mensaje;
			LEAVE Procedimiento;
		END IF;
		
		INSERT INTO LOGINS.USUARIO
			(DNI_USU, TIP_USU, NOM_USU, APE_USU, TEL_USU, CON_USU)
		VALUES
			(Dni, 'Cliente', Nombres, Apellidos, Telefono, Clave);
		
		SET Codigo = FN_GetCodigoUltimoUsuario();
		
		INSERT INTO LOGINS.USUARIO_CLIENTE
		(COD_CLI)
		VALUES
			(Codigo);
	END $$
DELIMITER ;

CALL SP_RegistrarCliente('72844444', 'Julio Diego', 'Perez Sanchez', '999888777','Julio123');

-- REGISTRA UN ADMINISTRADOR
DELIMITER $$
	CREATE PROCEDURE SP_RegistrarAdmin
	(
		Dni 		CHAR(8),
		Nombres 	VARCHAR(50),
		Apellidos	VARCHAR(50),
		Telefono	CHAR(9),
		Clave		VARCHAR(100),
		Sueldo		DOUBLE
	) Procedimiento:
	BEGIN
		DECLARE TelefonoExiste VARCHAR(10);
		DECLARE Codigo INT;
		SET 	TelefonoExiste = FN_VerificarSiTelefonoExiste(Telefono);

		IF (TelefonoExiste != 'No Existe') THEN
			SELECT 'ERROR > El telefono Ingresado ya se encuentra registrado' AS Mensaje;
			LEAVE Procedimiento;
		END IF;
		
		IF(Sueldo < 1050) THEN
			SET Sueldo = 1050;
			SELECT 'Advertencia > El sueldo base del Administrador no puede ser menor a 1050 soles. Se registró el administrador con 1050 soles de sueldo base ' AS Mensaje;
		END IF;
		
		INSERT INTO LOGINS.USUARIO
			(DNI_USU, TIP_USU, NOM_USU, APE_USU, TEL_USU, CON_USU)
		VALUES
			(Dni, 'Admin', Nombres, Apellidos, Telefono, Clave);
			
		SET Codigo = FN_GetCodigoUltimoUsuario();
			
		INSERT INTO LOGINS.USUARIO_ADMIN
			(COD_ADM,SUB_ADM)
		VALUES
			(Codigo, Sueldo);
	END $$
DELIMITER ;

CALL SP_RegistrarAdmin('72844445', 'Malcom Javier', 'Jurado Vilchez', '999888666','Malcom', 1200.10);

-- REGISTRA UN ADMINISTRADOR PRINCIPAL (HEADADMIN)
DELIMITER $$
	CREATE PROCEDURE SP_RegistrarHeadAdmin
	(
		Dni 		CHAR(8),
		Nombres 	VARCHAR(50),
		Apellidos	VARCHAR(50),
		Telefono	CHAR(9),
		Clave		VARCHAR(100),
		Sueldo		DOUBLE
	) Procedimiento:
	BEGIN
		DECLARE TelefonoExiste VARCHAR(10);
		DECLARE Codigo INT;
		SET 	TelefonoExiste = FN_VerificarSiTelefonoExiste(Telefono);

		IF (TelefonoExiste != 'No Existe') THEN
			SELECT 'ERROR > El telefono Ingresado ya se encuentra registrado' AS Mensaje;
			LEAVE Procedimiento;
		END IF;
		
		IF(Sueldo < 1800) THEN
			SET Sueldo = 1800;
			SELECT 'Advertencia > El sueldo base del Administrador Principal no puede ser menor a 1800 soles. Se registró a el administrador con 1800 soles de sueldo base ' AS Mensaje;
		END IF;
		
		INSERT INTO LOGINS.USUARIO
			(DNI_USU, TIP_USU, NOM_USU, APE_USU, TEL_USU, CON_USU)
		VALUES
			(Dni, 'HeadAdmin', Nombres, Apellidos, Telefono, Clave);
			
		SET Codigo = FN_GetCodigoUltimoUsuario();
			
		INSERT INTO LOGINS.USUARIO_HEADADMIN
		VALUES
			(Codigo, Sueldo);
	END $$
DELIMITER ;

CALL SP_RegistrarHeadAdmin('72844443', 'Julieta Laura', 'Iglesias Prieto', '999888111','Julieta', 1920.46);

-- CONSULTAR/LISTAR USUARIOS

DELIMITER $$
	CREATE PROCEDURE SP_ListarUsuarios()
	BEGIN
		SELECT 	* 
		FROM LOGINS.USUARIO;
	END $$
DELIMITER ;

CALL SP_ListarUsuarios();

-- CONSULTAR/BUSCAR CLIENTES
DELIMITER $$
	CREATE PROCEDURE SP_ListarClientes()
	BEGIN
		SELECT 	U.COD_USU, U.DNI_USU, U.TIP_USU, U.NOM_USU, U.APE_USU, U.TEL_USU, U.CON_USU, U.FCC_USU,
				C.SAL_CLI, C.ESC_CLI
		FROM 		LOGINS.USUARIO 			AS U
		INNER JOIN 	LOGINS.USUARIO_CLIENTE 	AS C
		ON 			C.COD_CLI = U.COD_USU;
	END $$
DELIMITER ;

CALL SP_ListarClientes();

-- CONSULTAR/BUSCAR ADMINS
DELIMITER $$
	CREATE PROCEDURE SP_ListarAdmins()
	BEGIN
		SELECT 	U.COD_USU, U.DNI_USU, U.TIP_USU, U.NOM_USU, U.APE_USU, U.TEL_USU, U.CON_USU, U.FCC_USU,
				A.SUB_ADM, A.COM_ADM, A.CAC_ADM, A.SUM_ADM
		FROM 		LOGINS.USUARIO 				AS U
		INNER JOIN 	LOGINS.USUARIO_ADMIN 		AS A
		ON 			U.COD_USU = A.COD_ADM;
	END $$
DELIMITER ;

CALL SP_ListarAdmins();

-- CONSULTAR/BUSCAR HEADADMINS
DELIMITER $$
	CREATE PROCEDURE SP_ListarHeadAdmins()
	BEGIN
		SELECT 	U.COD_USU, U.DNI_USU, U.TIP_USU, U.NOM_USU, U.APE_USU, U.TEL_USU, U.CON_USU, U.FCC_USU,
				H.SUE_HEA
		FROM 			LOGINS.USUARIO 					AS U
		INNER JOIN 		LOGINS.USUARIO_HEADADMIN 		AS H
		ON 				U.COD_USU = H.COD_HEA;
	END $$
DELIMITER ;

CALL SP_ListarHeadAdmins();

-- LISTA LOS DATOS DE UN CLIENTE (NORMALMENTE PARA RECBIR UN YAPE)
DELIMITER $$
	CREATE PROCEDURE SP_BuscarClientexNumero
	(
		Telefono CHAR(9)
	)
	BEGIN
		SELECT 	U.NOM_USU, U.APE_USU, U.TEL_USU
		FROM 			LOGINS.USUARIO 				AS U
		INNER JOIN 		LOGINS.USUARIO_CLIENTE 		AS C
		ON 				C.COD_CLI = U.COD_USU
		WHERE 	U.TEL_USU = Telefono;
	END $$
DELIMITER ;

CALL SP_BuscarClientexNumero('945888777');

-- ACTUALIZAR DATOS DE UN CLIENTE
/*
	El procedimiento valida que el telefono ingresado no exista y el codigo sea valido con la funcion VerificarCodigo y Verificar Numero
	Si Alguna de las 2 verificaciones falla se abandona el procedimiento y se imprime un mensaje acorde
    Luego se guarda el telefono original del usuario en una variable TelefonoAnterior
    Se procede a hacer un update de los campos ingresados
    Se elimina la restriccion de los foreign key de la tabla Transacciones Yape para poder modificar el telefono del usuario
    Se actualiza los campos donde concida el numero original con el numero anterior
    Se vuelve a activar las foreign keys en la tabla yape
    Se imprime un mensaje de confirmacion
*/
DELIMITER $$
	CREATE PROCEDURE SP_ActualizarCliente
	(
		Codigo 		INT,
		Dni  		CHAR(8),
		Nombres 	VARCHAR(50),
		Apellidos 	VARCHAR(50),
		Telefono 	CHAR(9),
		Clave 		VARCHAR(100),
		Saldo		DOUBLE,
		Estado		VARCHAR(15)
	) Procedimiento:
	BEGIN
		DECLARE CodigoExiste 		VARCHAR(10);
		DECLARE TelefonoExiste 		VARCHAR(10);
		DECLARE TelefonoAnterior 	CHAR(9);
		DECLARE TipoUsuario 		VARCHAR(15);
		
		SET 	CodigoExiste 	= FN_VerificarSiCodigoExiste(Codigo);
		SET 	TipoUsuario 	= FN_VerificarTipoUsuario(Codigo);
		SET 	TelefonoExiste 	= FN_VerificarSiTelefonoExiste(Telefono);
		
		IF (CodigoExiste != 'Existe') THEN
			SELECT 'ERROR > El Codigo Ingresado no Existe' AS Mensaje;
			LEAVE Procedimiento;
		END IF;
		
		IF(TipoUsuario != 'Cliente') THEN
			SELECT 'ERROR > El Codigo Ingresado No Pertenece a un Cliente' AS Mensaje;
			LEAVE Procedimiento;
		END IF;

		IF (TelefonoExiste != 'No Existe') THEN
			SELECT 'ERROR > El Telefono ingresado ya se encuentra registrado' AS Mensaje;
			LEAVE Procedimiento;
		END IF;
		
		SELECT 	TEL_USU 
		INTO 	TelefonoAnterior 
		FROM 	LOGINS.USUARIO 
		WHERE 	COD_USU = Codigo;

		UPDATE 	LOGINS.USUARIO_CLIENTE
		SET 	SAL_CLI = Saldo,
				ESC_CLI = Estado
		WHERE 	COD_CLI = Codigo;
		
		ALTER TABLE TRANSACCIONES.YAPE
			DROP FOREIGN KEY yape_ibfk_1;
		ALTER TABLE TRANSACCIONES.YAPE
			DROP FOREIGN KEY yape_ibfk_2;

		UPDATE 	LOGINS.USUARIO 
		SET 	DNI_USU = Dni, 
				NOM_USU = Nombres, 
				APE_USU = Apellidos,
				TEL_USU = Telefono,
				CON_USU = Clave
		WHERE 	COD_USU = Codigo;

		UPDATE TRANSACCIONES.YAPE
			SET NRC_YAP = Telefono
		WHERE NRC_YAP = TelefonoAnterior;

		UPDATE TRANSACCIONES.YAPE
			SET NRT_YAP = Telefono
		WHERE NRT_YAP = TelefonoAnterior;
			
		ALTER TABLE TRANSACCIONES.YAPE
		ADD CONSTRAINT yape_ibfk_1
		FOREIGN KEY (NRC_YAP) REFERENCES LOGINS.USUARIO(TEL_USU);

		ALTER TABLE TRANSACCIONES.YAPE
		ADD CONSTRAINT yape_ibfk_2
		FOREIGN KEY (NRT_YAP) REFERENCES LOGINS.USUARIO(TEL_USU);
		
		SELECT 'Datos Actualizados Correctamente' AS Mensaje;
	END $$
DELIMITER ;

CALL SP_ActualizarCliente(2, '91893044', 'Miguel Ivan', 'Rodriguez Campos', '983746222', 'Miguel032', 1837.23, 'Inactiva');

-- ACTUALIZA EL SALDO DE UN CLIENTE

DELIMITER $$
	 CREATE PROCEDURE SP_UpdateSaldoCliente
	 (
		Codigo INT,
		Saldo DOUBLE
	 ) Procedimiento :
	 BEGIN
		DECLARE EsCliente VARCHAR(15);
		SET 	EsCliente = FN_VerificarSiEsCodigoDeCliente(Codigo);
		
		IF(EsCliente != 'Cliente') THEN
			SELECT 'ERROR > El codigo Ingresado no existe o no es de un cliente' AS Mensaje;
			LEAVE Procedimiento;
		END IF;

		IF(Saldo < 0) THEN
			SELECT 'ADVERTENCIA > Se detectó un ingreso de saldo no permitido' AS Mensaje;
			LEAVE Procedimiento;
		END IF;
	 
		UPDATE LOGINS.USUARIO_CLIENTE 
		SET 	SAL_CLI = Saldo
		WHERE COD_CLI = Codigo;
		
		SELECT 'Saldo Modificado Correctamente' AS Mensaje;
	 END$$
DELIMITER ; 

-- ACTUALIZA LOS CAMPOS MAS BASICOS DE UN ADMINSTRADOR, IMPRIME MENSAJE DE ERROR SI ALGUNO DE LOS PARAMETROS INGRESADOS NO SON VALIDOS

DELIMITER $$
CREATE PROCEDURE SP_ActualizarAdminSP
(
	Codigo 		INT,
    Dni  		CHAR(8),
    Nombres 	VARCHAR(50),
    Apellidos 	VARCHAR(50),
    Telefono 	CHAR(9),
    Clave 		VARCHAR(100)
) Procedimiento:
BEGIN
	DECLARE CodigoExiste 		VARCHAR(10);
	DECLARE TelefonoExiste 		VARCHAR(10);
    DECLARE TipoUsuario 		VARCHAR(15);
    
    SET 	CodigoExiste 	= FN_VerificarSiCodigoExiste(Codigo);
    SET 	TipoUsuario 	= FN_VerificarTipoUsuario(Codigo);
    SET 	TelefonoExiste 	= FN_VerificarSiTelefonoExiste(Telefono);
    
    IF (CodigoExiste != 'Existe') THEN
		SELECT 'ERROR > El Codigo Ingresado no Existe' AS Mensaje;
		LEAVE Procedimiento;
	END IF;
    
    IF(TipoUsuario != 'Admin') THEN
		SELECT 'ERROR > El Codigo Ingresado No Pertenece a un Administrador' AS Mensaje;
        LEAVE Procedimiento;
	END IF;

	IF (TelefonoExiste != 'No Existe') THEN
		SELECT 'ERROR > El Telefono ingresado ya se encuentra registrado' AS Mensaje;
		LEAVE Procedimiento;
	END IF;
    
    UPDATE 	LOGINS.USUARIO
    SET 	DNI_USU = Dni, 
			NOM_USU = Nombres, 
			APE_USU = Apellidos,
			TEL_USU = Telefono,
			CON_USU = Clave
	WHERE 	COD_USU = Codigo;
    
    SELECT 'Datos Actualizados Correctamente' AS Mensaje;
END $$
DELIMITER ;

CALL SP_ActualizarAdminSP(4, '93847322', 'Alexa Maria', 'Mendoza Flores', '903844224', 'Alexa48h');

-- ACTUALIZA TODOS LOS CAMPOS DE UN HEADADMIN

DELIMITER $$
CREATE PROCEDURE SP_ActualizarHeadAdmin
(
	Codigo 		INT,
    Dni  		CHAR(8),
    Nombres 	VARCHAR(50),
    Apellidos 	VARCHAR(50),
    Telefono 	CHAR(9),
    Clave 		VARCHAR(100),
    Sueldo 		DOUBLE
) Procedimiento:
BEGIN
	DECLARE CodigoExiste 		VARCHAR(10);
	DECLARE TelefonoExiste 		VARCHAR(10);
    DECLARE TipoUsuario 		VARCHAR(15);
    
    SET 	CodigoExiste 	= FN_VerificarSiCodigoExiste(Codigo);
    SET 	TipoUsuario 	= FN_VerificarTipoUsuario(Codigo);
    SET 	TelefonoExiste 	= FN_VerificarSiTelefonoExiste(Telefono);
    
    IF (CodigoExiste != 'Existe') THEN
		SELECT 'ERROR > El Codigo Ingresado no Existe' AS Mensaje;
		LEAVE Procedimiento;
	END IF;
    
    IF(TipoUsuario != 'HeadAdmin') THEN
		SELECT 'ERROR > El Codigo Ingresado No Pertenece a un Administrador Principal' AS Mensaje;
        LEAVE Procedimiento;
	END IF;

	IF (TelefonoExiste != 'No Existe') THEN
		SELECT 'ERROR > El Telefono ingresado ya se encuentra registrado' AS Mensaje;
		LEAVE Procedimiento;
	END IF;
    
    UPDATE 	LOGINS.USUARIO_HEADADMIN
    SET 	SUE_HEA = Sueldo
    WHERE 	COD_HEA = Codigo;
    
    UPDATE 	LOGINS.USUARIO
    SET 	DNI_USU = Dni, 
			NOM_USU = Nombres, 
			APE_USU = Apellidos,
			TEL_USU = Telefono,
			CON_USU = Clave
	WHERE 	COD_USU = Codigo;
    
    SELECT 'Datos Actualizados Correctamente' AS Mensaje;
END $$
DELIMITER ;

CALL SP_ActualizarHeadAdmin(5, '83748233', 'Isaias Raul', 'Pascal Ramos', '923749400', 'Isaias38kA', 4313.51);

-- LISTA UN YAPE REALIZADO POR SU ID
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
