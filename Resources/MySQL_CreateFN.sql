-- RETORNA EL CODIGO DEL ULTIMO USUARIO CREADO
DELIMITER $$
CREATE FUNCTION FN_GetCodigoUltimoUsuario()
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

-- DEVUELVE EXISTE SI EL CODIGO INGRESADO EXISTE, DEVUELVE NO EXISTE SI NO

DELIMITER $$
	CREATE FUNCTION FN_VerificarSiCodigoExiste 
    (
        Codigo INT
    )
		RETURNS VARCHAR(10) 
		DETERMINISTIC
	BEGIN
		DECLARE 	CodigoHolder 	INT;
		DECLARE 	Resultado 		VARCHAR(10);
        
        SELECT 	COD_USU 
        INTO 	CodigoHolder
        FROM 	LOGINS.USUARIO
        WHERE 	COD_USU = Codigo;
        
        IF(CodigoHolder = Codigo) THEN
			SET Resultado = 'Existe';
        ELSE
			SET Resultado = 'No Existe';
		END IF;
        
        RETURN Resultado;
    END $$
DELIMITER ;

SELECT FN_VerificarSiCodigoExiste(3);

-- DEVUELVE EXISTE SI EL TELEFONO INGRESADO EXISTE, DEVUELVE NO EXISTE SI NO

DELIMITER $$
	CREATE FUNCTION FN_VerificarSiTelefonoExiste
    (
        Telefono CHAR(9)
    )
		RETURNS VARCHAR(10) 
		DETERMINISTIC
	BEGIN
		DECLARE TelefonoHolder 	CHAR(9);
		DECLARE Resultado 		VARCHAR(10);
        
        SELECT 	TEL_USU 
        INTO 	TelefonoHolder
        FROM 	LOGINS.USUARIO
        WHERE 	TEL_USU = Telefono;
        
        IF(TelefonoHolder = Telefono) THEN
			SET Resultado = 'Existe';
        ELSE
			SET Resultado = 'No Existe';
		END IF;
        
        RETURN Resultado;
    END $$
DELIMITER ;

SELECT FN_VerificarSiTelefonoExiste('945888000');

-- DEVUELVE UN VARCHAR INDICANDO EL TIPO DE USUARIO

DELIMITER $$
	CREATE FUNCTION FN_VerificarTipoUsuario
    (
		Codigo INT
    )
		RETURNS VARCHAR(15) 
		DETERMINISTIC
	BEGIN
		DECLARE Resultado VARCHAR(15);
        
		SELECT 	TIP_USU 
        INTO 	Resultado
        FROM 	LOGINS.USUARIO
        WHERE 	COD_USU = Codigo;
        
        IF(Resultado IS NULL) THEN
			SET Resultado = 'Codigo Invalido';
        END IF; 
        
        RETURN 	Resultado;
    END $$
DELIMITER ;

SELECT FN_VerificarTipoUsuario(7);

-- DEVUELVE 0 SI EL CODIGO INGRESADO NO EXISTE O NO ES DE UN CLIENTE, DEVUELVE 1 SI EL CODIGO SI EXISTE Y ES DE UN CLIENTE

DELIMITER $$
	CREATE FUNCTION FN_VerificarCodigoCliente
    (
		Codigo INT
    )
		RETURNS INT 
		DETERMINISTIC
	BEGIN
		DECLARE Resultado INT;
        
		SELECT IF	(COD_CLI = Codigo, 1, 0) 
        INTO 		Resultado
        FROM 		LOGINS.USUARIO_CLIENTE
        WHERE 		COD_CLI = Codigo;
	
        RETURN Resultado;
    END $$
DELIMITER ;