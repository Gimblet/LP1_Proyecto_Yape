
-- INGRESO DE CLIENTES

CALL dbyape.SP_RegistrarCliente('70282011', 'Valentina Laura', 'Sanchez Fernandez', '934713573', 'vale', 384.21);
CALL dbyape.SP_RegistrarCliente('02782713', 'Yvet Monica', 'Morales Ramirez', '985729373', 'yvei38', 3492.34);
CALL dbyape.SP_RegistrarCliente('92732271', 'Paola Fernanda', 'Castro Villacorta', '972017391', 'paoLi38', 134.1);
CALL dbyape.SP_RegistrarCliente('93285721', 'Jorge Andres', 'Torres Fernandez', '933028472', 'jor238', 724.22);
CALL dbyape.SP_RegistrarCliente('28494732', 'Andres Pedro', 'Aguilar Rodriguez', '948274893', 'andr82A', 3634.64);
CALL dbyape.SP_RegistrarCliente('58275024', 'Maria Camila ', 'Vásquez Estevez', '937499321', 'maria83hs', 2248.11);

-- INGRESO DE ADMINISTRADORES

-- INGRESO DE HEADADMINS

-- ------------------------------ BULK DATA -------------------------------

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