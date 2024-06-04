
-- INGRESO DE CLIENTES

CALL dbyape.SP_RegistrarCliente('70282011', 'Valentina Laura', 'Sanchez Fernandez', '934713573', 'vale');
CALL dbyape.SP_RegistrarCliente('02782713', 'Yvet Monica', 'Morales Ramirez', '985729373', 'yvei38');
CALL dbyape.SP_RegistrarCliente('92732271', 'Paola Fernanda', 'Castro Villacorta', '972017391', 'paoLi38');
CALL dbyape.SP_RegistrarCliente('93285721', 'Jorge Andres', 'Torres Fernandez', '933028472', 'jor238');
CALL dbyape.SP_RegistrarCliente('28494732', 'Andres Pedro', 'Aguilar Rodriguez', '948274893', 'andr82A');
CALL dbyape.SP_RegistrarCliente('58275024', 'Maria Camila ', 'Vásquez Estevez', '937499321', 'maria83hs');

-- INGRESAR SALDO A LOS CLIENTES

CALL dbyape.SP_UpdateSaldoCliente(6, 384.21);
CALL dbyape.SP_UpdateSaldoCliente(9, 724.22);
CALL dbyape.SP_UpdateSaldoCliente(10, 3634.64);
CALL dbyape.SP_UpdateSaldoCliente(11, 2248.11);
CALL dbyape.SP_UpdateSaldoCliente(12, 1028.18);
CALL dbyape.SP_UpdateSaldoCliente(13, 380.3);
CALL dbyape.SP_UpdateSaldoCliente(14, 9381.3);

-- INGRESO DE ADMINISTRADORES

CALL dbyape.SP_RegistrarAdmin('83723244', 'Juan Diego', 'Álvarez Vera', '920460192', 'Jug382', 1100);
CALL dbyape.SP_RegistrarAdmin('34839471', 'Valentino Anderson', 'Valenzuela Sisneros', '917497452', 'Vlad832@', 1200);
CALL dbyape.SP_RegistrarAdmin('94834723', 'Andrés Alan', 'Sisneros Ontiveros', '938473173', 'Loreign382', 1050);
CALL dbyape.SP_RegistrarAdmin('99483924', 'Lorenzo Jorge', 'Prieto Olmos', '937412132', 'Jorge73', 1050);
CALL dbyape.SP_RegistrarAdmin('33482751', 'Emiliano Bruno', 'Mena Gómez', '947241442', 'Loreign382', 1250);

-- INGRESO DE HEADADMINS

CALL dbyape.SP_RegistrarHeadAdmin('78204522', 'Lorenzo Sergio', 'Pedroza Vera', '969966585', 'Loreign382', 1900);
CALL dbyape.SP_RegistrarHeadAdmin('74927401', 'Montserrat Bianca', 'Arce Barrios', '937048231', 'monsssert31', 1852.93);
CALL dbyape.SP_RegistrarHeadAdmin('38428912', 'Ariana Martina', 'Bustos Valencia', '935422741', 'airheu3m', 100); 