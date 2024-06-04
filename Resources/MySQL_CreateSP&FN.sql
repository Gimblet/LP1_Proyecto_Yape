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

-- VERIFICA QUE EL TELEFONO DE UN USUARIO SEAN VALIDOS, RETORNA 0 SI ES INVALIDO, UNO SI AMBOS SON VALIDOS

DELIMITER $$
	CREATE FUNCTION FN_VerificarNumeroyCodigo
    (
		Codigo INT,
        Telefono CHAR(9)
    )
		RETURNS INT 
		DETERMINISTIC
	BEGIN
		DECLARE Resultado INT;
        
		SELECT IF	(COD_USU = Codigo, 1, 0)
        INTO 		Resultado
		FROM 		LOGINS.USUARIO 
		WHERE 		COD_USU = Codigo;
        
        SELECT IF	(TEL_USU = Telefono, 0, 1) 
        INTO 		Resultado
        FROM 		LOGINS.USUARIO
        WHERE 		TEL_USU = Telefono;
        
        RETURN Resultado;
    END $$
DELIMITER ;

DELIMITER $$
	CREATE FUNCTION FN_VerificarTipoUsuario
    (
		Codigo INT
    )
		RETURNS VARCHAR(15) 
		DETERMINISTIC
	BEGIN
		DECLARE Resultado VARCHAR(15);
        
		SELECT TIP_USU INTO Resultado
        FROM LOGINS.USUARIO
        WHERE COD_USU = Codigo;
        
        RETURN Resultado;
    END $$
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
    (COD_CLI, SAL_CLI)
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
		(Dni, 'HeadAdmin', Nombres, Apellidos, Telefono, Clave);
        
	SET CODIGO = FN_GetUltimoUsuario();
        
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
    FROM LOGINS.USUARIO 				AS U
    INNER JOIN LOGINS.USUARIO_CLIENTE 	AS C
    ON C.COD_CLI = U.COD_USU;
END $$
DELIMITER ;

CALL SP_ListarClientes();

-- CONSULTAR/BUSCAR ADMINS
DELIMITER $$
CREATE PROCEDURE SP_ListarAdmins()
BEGIN
	SELECT 	U.COD_USU, U.DNI_USU, U.TIP_USU, U.NOM_USU, U.APE_USU, U.TEL_USU, U.CON_USU, U.FCC_USU,
			A.SUB_ADM, A.COM_ADM, A.CAC_ADM, A.SUM_ADM
    FROM LOGINS.USUARIO 				AS U
    INNER JOIN LOGINS.USUARIO_ADMIN 	AS A
    ON U.COD_USU = A.COD_ADM;
END $$
DELIMITER ;

CALL SP_ListarAdmins();

-- CONSULTAR/BUSCAR HEADADMINS
DELIMITER $$
CREATE PROCEDURE SP_ListarHeadAdmins()
BEGIN
	SELECT 	U.COD_USU, U.DNI_USU, U.TIP_USU, U.NOM_USU, U.APE_USU, U.TEL_USU, U.CON_USU, U.FCC_USU,
			H.SUE_HEA
    FROM LOGINS.USUARIO 					AS U
    INNER JOIN LOGINS.USUARIO_HEADADMIN 	AS H
    ON U.COD_USU = H.COD_HEA;
END $$
DELIMITER ;

CALL SP_ListarHeadAdmins();

-- LISTAR DATOS DEL CLIENTE A RECIBIR UN YAPE
DELIMITER $$
CREATE PROCEDURE SP_BuscarClientexNumero
(
	Telefono CHAR(9)
)
BEGIN
	SELECT 	U.NOM_USU, U.APE_USU, U.TEL_USU
    FROM LOGINS.USUARIO 				AS U
    INNER JOIN LOGINS.USUARIO_CLIENTE 	AS C
    ON C.COD_CLI = U.COD_USU
    WHERE U.TEL_USU = Telefono;
END $$
DELIMITER ;

CALL SP_BuscarClientexNumero('945888777');

-- ACTUALIZAR DATOS DE UN CLIENTE
/*
	El procedimiento valida que el telefono ingresado no exista y el codigo sea valido con la funcion VerificarNumero y Codigo
	Si todo es correcto, La variable Valido sera = 1 , de lo contrario la variable sera 0. En caso la variable sea 0 se abandona el procedimiento
    Se verificar que el codigo ingresado pertenezaca a un cliente, de lo contrario se imprime un mensaje y se abandona el proceimiento
    Luego se guarda el telefono original del usuario en una variable OGTelefono
    Se procede a hcaer un update de los campos ingresados
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
	DECLARE Valido INT;
    DECLARE OGTelefono CHAR(9);
    DECLARE Tipo VARCHAR(15);
    SET 	Valido = FN_VerificarNumeroyCodigo(Codigo, Telefono);
    SET 	Tipo = FN_VerificarTipoUsuario(Codigo);

	IF (Valido = 0) THEN
		SELECT 'El Codigo no Existe o el Telefono ingresado ya se encuentra registrado' AS Mensaje;
		LEAVE Procedimiento;
	END IF;
    
    IF(Tipo != 'Cliente') THEN
		SELECT 'El Codigo Ingresado No Pertenece a un Cliente' AS Mensaje;
        LEAVE Procedimiento;
	END IF;
    
	SELECT 	TEL_USU 
    INTO 	OGTelefono 
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

	UPDATE LOGINS.USUARIO 
	SET DNI_USU = Dni, 
		NOM_USU = Nombres, 
		APE_USU = Apellidos,
		TEL_USU = Telefono,
		CON_USU = Clave
	WHERE COD_USU = Codigo;

	UPDATE TRANSACCIONES.YAPE
		SET NRC_YAP = Telefono
	WHERE NRC_YAP = OGTelefono;

	UPDATE TRANSACCIONES.YAPE
		SET NRT_YAP = Telefono
	WHERE NRT_YAP = OGTelefono;
		
	ALTER TABLE TRANSACCIONES.YAPE
	ADD CONSTRAINT yape_ibfk_1
	FOREIGN KEY (NRC_YAP) REFERENCES LOGINS.USUARIO(TEL_USU);

	ALTER TABLE TRANSACCIONES.YAPE
	ADD CONSTRAINT yape_ibfk_2
	FOREIGN KEY (NRT_YAP) REFERENCES LOGINS.USUARIO(TEL_USU);
    
    SELECT 'Datos Actualizados Correctamente' AS Mensaje;
END $$
DELIMITER ;

CALL SP_ActualizarCliente(2, '91893044', 'Miguel Ivan', 'Rodriguez Campos', '948930132', 'Miguel032', 1204.51, 'Inactiva');

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
	DECLARE Valido INT;
    DECLARE OGTelefono CHAR(9);
    DECLARE Tipo VARCHAR(15);
    SET 	Valido = FN_VerificarNumeroyCodigo(Codigo, Telefono);
    SET 	Tipo = FN_VerificarTipoUsuario(Codigo);

	IF (Valido = 0) THEN
		SELECT 'El Codigo no Existe o el Telefono ingresado ya se encuentra registrado' AS Mensaje;
		LEAVE Procedimiento;
    END IF;
    
    IF(Tipo != 'Admin') THEN
		SELECT 'El Codigo Ingresado No Pertenece a un Administrador' AS Mensaje;
        LEAVE Procedimiento;
	END IF;
    
    UPDATE LOGINS.USUARIO
    SET DNI_USU = Dni, 
		NOM_USU = Nombres, 
		APE_USU = Apellidos,
		TEL_USU = Telefono,
		CON_USU = Clave
	WHERE COD_USU = Codigo;
    
    SELECT 'Datos Actualizados Correctamente' AS Mensaje;
END $$
DELIMITER ;

CALL SP_ActualizarAdminSP(5, '93847322', 'Alexa Maria', 'Mendoza Flores', '903844224', 'Alexa48h');

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
	DECLARE Valido INT;
    DECLARE OGTelefono CHAR(9);
    DECLARE Tipo VARCHAR(15);
    SET 	Valido = FN_VerificarNumeroyCodigo(Codigo, Telefono);
    SET 	Tipo = FN_VerificarTipoUsuario(Codigo);

	IF (Valido = 0) THEN
		SELECT 'El Codigo no Existe o el Telefono ingresado ya se encuentra registrado' AS Mensaje;
		LEAVE Procedimiento;
	END IF;
    
    IF(Tipo != 'HeadAdmin') THEN
		SELECT 'El Codigo Ingresado No Pertenece a un Administrador Superior (HeadAdmin)' AS Mensaje;
        LEAVE Procedimiento;
	END IF;
    
    UPDATE LOGINS.USUARIO_HEADADMIN
    SET SUE_HEA = Sueldo
    WHERE COD_HEA = Codigo;
    
    UPDATE LOGINS.USUARIO
    SET DNI_USU = Dni, 
		NOM_USU = Nombres, 
		APE_USU = Apellidos,
		TEL_USU = Telefono,
		CON_USU = Clave
	WHERE COD_USU = Codigo;
    
    SELECT 'Datos Actualizados Correctamente' AS Mensaje;
END $$
DELIMITER ;

CALL SP_ActualizarHeadAdmin(6, '83748233', 'Isaias Raul', 'Pascal Ramos', '923749400', 'Isaias38kA', 4313.51);
    
-- ----- TO DO

-- AGREGAR VALIDACION DE NUMERO DE TELEFONO Y DNI AL MOMENTO DE AGREGAR USUARIOS (MOSTRAR MENSAJE SI ES QUE LOS DATOS SON DUPLICADOS)

-- Crear Procedimiento para actualizar la comision, sueldo y sueldo del mes de un administrador (tener en cuenta que la suma de las comisiones y el sueldo base da el sueldo final)
-- Crear Procedimientos para eliminar los campos usuarios (Cambiar el estado del cliente a inactivo, no eliminar la tabla del cliente como tal)

-- Crear Procedimientos para Insertar/Realizar un yape (Verificar que el saldo sea suficiente, que el numero exista y que el estado de cuenta de los clientes esten activos)
-- Crear Procedimientos para actualizar los campos de un yape (DEJAR ESTE PROCEDIMIENTO AL FINAL)
-- Crear Procedimientos para eliminar un yape (Cambiar el estado del yape a eliminado, devolver el dinero al yapero y quitar el dinero al beneficiaro del yape, no eliminar el registro del yape como tal)

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
