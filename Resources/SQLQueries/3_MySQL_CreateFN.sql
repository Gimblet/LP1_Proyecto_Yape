-- RETORNA EL CODIGO DEL ULTIMO USUARIO CREADO
DELIMITER $$
CREATE FUNCTION FN_GetCodigoUltimoUsuario()
	RETURNS INT
    DETERMINISTIC
BEGIN
	DECLARE Codigo INT;
    
	SELECT COD_USU INTO Codigo
    FROM LOGINS.USUARIO 
		ORDER BY COD_USU DESC
		LIMIT 1;
    
    RETURN Codigo;
END $$
DELIMITER ;

SELECT FN_GetCodigoUltimoUsuario();

-- RETORNA EL ULTIMO VALOR DE COMISION
DELIMITER $$
CREATE FUNCTION FN_ValorActualComision()
	RETURNS DOUBLE
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

-- DEVUELVE UN VARCHAR INDICANDO EL TIPO DE USUARIO, DEVUELVE CODIGO INVALIDO EN CASO EL CODIGO INGRESADO NO EXISTA

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

-- DEVUELVE CLIENTE SI EL CODIGO INGRESADO ES DE CLIENTE, DEVUELVE CODIGO INVALIDO EN CUALQUIER OTRO CASO

DELIMITER $$
	CREATE FUNCTION FN_VerificarSiEsCodigoDeCliente
    (
		Codigo INT
    )
		RETURNS VARCHAR(15) 
		DETERMINISTIC
	BEGIN
		DECLARE CodigoHolder INT;
		DECLARE Resultado VARCHAR(15);
        
		SELECT 	COD_CLI 
        INTO 	CodigoHolder
        FROM 	LOGINS.USUARIO_CLIENTE
        WHERE 	COD_CLI = Codigo;
        
        IF(CodigoHolder = Codigo) THEN
			SET Resultado = 'Cliente';
        ELSE
			SET Resultado = 'CODIGO INVALIDO';
		END IF;
	
        RETURN Resultado;
    END $$
DELIMITER ;

SELECT FN_VerificarSiEsCodigoDeCliente(3);