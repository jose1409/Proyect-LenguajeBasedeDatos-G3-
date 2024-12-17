------------------------------------ SPs para CRUD de HOTEL_TAB

----INSERT
create or replace PROCEDURE SP_INSERT_HOTEL(
ID_DIRECCION_V NUMBER,
ID_HORARIO_V NUMBER,
NOMBRE_V NVARCHAR2,
TELEFONO_V NVARCHAR2,
CORREO_V NVARCHAR2
)
is 
begin

    INSERT INTO HOTEL_TB(ID_DIRECCION ,ID_HORARIO ,NOMBRE ,TELEFONO ,CORREO )
    VALUES (ID_DIRECCION_V ,ID_HORARIO_V ,NOMBRE_V ,TELEFONO_V ,CORREO_V);
    COMMIT;
end;
/
--EXECUTE SP_INSERT_HOTEL(1,1,1, 'NOMBRE', '123456789', 'NOMBRE@ejemplo.com');


----UPDATE
create or replace PROCEDURE SP_UPDATE_HOTEL(
ID_HOTEL_V NUMBER,
ID_DIRECCION_V NUMBER,
ID_HORARIO_V NUMBER,
NOMBRE_V NVARCHAR2,
TELEFONO_V NVARCHAR2,
CORREO_V NVARCHAR2
)
is 
begin
    UPDATE HOTEL_TB SET
    ID_DIRECCION  = ID_DIRECCION_V,
    ID_HORARIO = ID_HORARIO_V,
    NOMBRE = NOMBRE_V,
    TELEFONO = TELEFONO_V,
    CORREO = CORREO_V
    WHERE ID_HOTEL = ID_HOTEL_V;
    COMMIT;
end;

/
--EXECUTE SP_UPDATE_HOTEL(1,1,1, 'NOMBRE_UPD', '123456789', 'UPDATE@ejemplo.com');


----DELETE
create or replace PROCEDURE SP_DELETE_HOTEL(
ID_HOTEL_V NUMBER
)
is 
begin

    DELETE FROM HOTEL_TB
    WHERE ID_HOTEL = ID_HOTEL_V;
    
    COMMIT;
end;

--EXECUTE SP_DELETE_HOTEL(1);
/

------------------------------------ SPs para CRUD de DIRECCION_TB

----INSERT
create or replace PROCEDURE SP_INSERT_DIRECCION(
PROVINCIA_V NVARCHAR2,
CANTON_V NVARCHAR2,
DISTRITO_V NVARCHAR2,
DIRECCION_DETALLADA_V NVARCHAR2
)
is 
begin

    INSERT INTO DIRECCION_TB(PROVINCIA ,CANTON ,DISTRITO ,DIRECCION_DETALLADA )
    VALUES (PROVINCIA_V ,CANTON_V ,DISTRITO_V ,DIRECCION_DETALLADA_V);
    COMMIT;
end;
/
--EXECUTE SP_INSERT_DIRECCION('HEREDIA', 'SANTA BARBARA', 'SANTA BARBARA', 'DETRAS DE LA PARROQUIA 100 SUR');


----UPDATE
create or replace PROCEDURE SP_UPDATE_DIRECCION(
ID_DIRECCION_V NUMBER,
PROVINCIA_V NVARCHAR2,
CANTON_V NVARCHAR2,
DISTRITO_V NVARCHAR2,
DIRECCION_DETALLADA_V NVARCHAR2
)
is 
begin
    UPDATE DIRECCION_TB SET
    PROVINCIA = PROVINCIA_V,
    CANTON = CANTON_V,
    DISTRITO = DISTRITO_V,
    DIRECCION_DETALLADA = DIRECCION_DETALLADA_V
    WHERE ID_DIRECCION = ID_DIRECCION_V;
    COMMIT;
end;

/
--EXECUTE SP_UPDATE_DIRECCION('HEREDIA', 'SANTA BARBARA', 'SAN PEDRO', '500 NORTE DEL PARQUE');


----DELETE
create or replace PROCEDURE SP_DELETE_DIRECCION(
ID_DIRECCION_V NUMBER
)
is 
begin

    DELETE FROM DIRECCION_TB
    WHERE ID_DIRECCION = ID_DIRECCION_V;
    
    COMMIT;
end;

--EXECUTE SP_DELETE_DIRECCION(1);

/
------------------------------------ SPs para CRUD de SERVICIO_HOTEL_TAB

----INSERT
create or replace PROCEDURE SP_INSERT_SERVICIO_HOTEL(
ID_HOTEL_V NUMBER,
NOMBRE_V NVARCHAR2,
ESTADO_V NVARCHAR2
)
is 
begin

    INSERT INTO SERVICIO_HOTEL_TAB(ID_HOTEL ,NOMBRE ,ESTADO )
    VALUES (ID_HOTEL_V ,NOMBRE_V ,ESTADO_V);
    COMMIT;
end;
/
--EXECUTE SP_INSERT_SERVICIO_HOTEL(1, 'SERVICIO', 'ACTIVO');


----UPDATE
create or replace PROCEDURE SP_UPDATE_SERVICIO_HOTEL(
ID_SERVICIO_HOTEL_V NUMBER,
NOMBRE_V NVARCHAR2,
ESTADO_V NVARCHAR2
)
is 
begin
    UPDATE SERVICIO_HOTEL_TAB SET
    NOMBRE = NOMBRE_V,
    ESTADO = ESTADO_V
    WHERE ID_SERVICIO_HOTEL = ID_SERVICIO_HOTEL_V;
    COMMIT;
end;

/
--EXECUTE SP_UPDATE_SERVICIO_HOTEL(1, 'SERVICIO', 'INACTIVO');


----DELETE
create or replace PROCEDURE SP_DELETE_SERVICIO_HOTEL(
ID_SERVICIO_HOTEL_V NUMBER
)
is 
begin

    DELETE FROM SERVICIO_HOTEL_TAB
    WHERE ID_SERVICIO_HOTEL = ID_SERVICIO_HOTEL_V;
    
    COMMIT;
end;

--EXECUTE SP_DELETE_SERVICIO_HOTEL(1);
/


create or replace PROCEDURE OBTENER_HORARIOS(
    P_CURSOR OUT SYS_REFCURSOR
)
AS
BEGIN
    -- Abrir el cursor y seleccionar todos los registros de la tabla SERVICIO_TB
    OPEN P_CURSOR FOR
    SELECT ID_HORARIO, FECHA_HORARIO, HORA_APERTURA, HORA_CIERRE
    FROM HORARIO_TB;
END;

INSERT INTO DIRECCION_TB (ID_DIRECCION, PROVINCIA, CANTON, DISTRITO, DIRECCION_DETALLADA) VALUES (1, 'San José', 'Escazú', 'San Rafael', 'Centro Comercial Multiplaza');
INSERT INTO DIRECCION_TB (ID_DIRECCION, PROVINCIA, CANTON, DISTRITO, DIRECCION_DETALLADA) VALUES (2, 'Heredia', 'Belén', 'Asunción', 'Zona Franca América, Edificio 5');

--

--EXECUTE SP_DELETE_HOTEL(1);
/
CREATE OR REPLACE PROCEDURE OBTENER_HOTEL(
    RESULTADO OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN RESULTADO FOR
    SELECT ID_HOTEL,d.direccion_detallada,hr.fecha_horario,NOMBRE, TELEFONO, CORREO
    FROM HOTEL_TB h inner join direccion_tb d
    on h.id_direccion = d.id_direccion
    inner join horario_tb hr
    on h.id_horario = hr.id_horario;
END;
/

--
create or replace PROCEDURE OBTENER_HORARIO_POR_ID(
    P_ID_HORARIO IN HORARIO_TB.ID_HORARIO%TYPE, -- ID del horario que se desea consultar
    RESULTADO OUT SYS_REFCURSOR                 -- Cursor para devolver el resultado
)
AS
BEGIN
    -- Abrir un cursor con la consulta SELECT filtrada por ID_HORARIO
    OPEN RESULTADO FOR
    SELECT ID_HORARIO, FECHA_HORARIO, HORA_APERTURA, HORA_CIERRE
    FROM HORARIO_TB
    WHERE ID_HORARIO = P_ID_HORARIO;
END;
--

create or replace PROCEDURE OBTENER_DIRECCIONES(
    RESULTADO OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN RESULTADO FOR
    SELECT ID_DIRECCION,PROVINCIA, CANTON, DISTRITO,DIRECCION_DETALLADA
    FROM DIRECCION_TB;
END;

--
create or replace PROCEDURE OBTENER_DIRECCION_POR_ID(
    P_ID_DIRECCION IN DIRECCION_TB.ID_DIRECCION%TYPE, 
    RESULTADO OUT SYS_REFCURSOR        
)
AS
BEGIN
    OPEN RESULTADO FOR
    SELECT ID_DIRECCION,PROVINCIA, CANTON, DISTRITO,DIRECCION_DETALLADA
    FROM DIRECCION_TB
    WHERE ID_DIRECCION = P_ID_DIRECCION;
END;
---


-- 1. Ver el empleado y su puesto según el hotel en el que se encuentran
CREATE OR REPLACE VIEW VISTA_EMPLEADO_HOTEL AS
SELECT  H.NOMBRE AS HOTEL_NOMBRE, H.CORREO AS HOTEL_CORREO, 
P.NOMBRE || ' ' || P.PRIMER_APELLIDO || ' ' || P.SEGUNDO_APELLIDO AS NOMBRE_EMPLEADO,
   E.PUESTO AS EMPLEADO_PUESTO
FROM 
    EMPLEADO_TB E
INNER JOIN PERSONA_TB P 
    ON E.ID_PERSONA = P.ID_PERSONA
INNER JOIN HOTEL_TB H
    ON E.ID_HOTEL = H.ID_HOTEL
WHERE E.ESTADO = 'Activo';


/
SELECT * FROM VISTA_EMPLEADO_HOTEL;

/
--2. Mostrar la cantidad de empleados que hay en el hote en cada puesto
CREATE OR REPLACE VIEW VISTA_CANTIDAD_EMPLEADO AS
SELECT H.NOMBRE AS HOTEL_NOMBRE,E.PUESTO AS EMPLEADO_PUESTO,
    COUNT(E.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS
FROM 
    EMPLEADO_TB E
INNER JOIN HOTEL_TB H ON E.ID_HOTEL = H.ID_HOTEL
GROUP BY 
    H.NOMBRE, E.PUESTO
ORDER BY 
    H.NOMBRE, E.PUESTO;
/
SELECT * FROM VISTA_CANTIDAD_EMPLEADO;

/
-- 3. Mostrar la venta por productos
CREATE OR REPLACE VIEW VISTA_HABITACION_OCUPACION AS
SELECT H.ID_HOTEL, H.ID_HABITACION, H.NUMERO_HABITACION,
    COUNT(R.ID_RESERVACION_HABITACION) AS CANTIDAD_OCUPACIONES
FROM 
    RESERVACION_HABITACION_TB R
INNER JOIN  HABITACION_TB H ON R.ID_HABITACION = H.ID_HABITACION
WHERE R.ID_HORARIO IN (
        SELECT ID_HORARIO
        FROM HORARIO_TB
        WHERE FECHA_HORARIO BETWEEN ADD_MONTHS(SYSDATE, -1) AND SYSDATE
    )
GROUP BY H.ID_HABITACION, H.NUMERO_HABITACION, H.ID_HOTEL
ORDER BY CANTIDAD_OCUPACIONES DESC;
/
SELECT * FROM VISTA_HABITACION_OCUPACION;
/

--Vista Servicios Hotel
CREATE OR REPLACE VIEW VISTA_SERVICIOS_HOTELES AS
SELECT 
    SERVICIO_HOTEL_TAB.ID_SERVICIO_HOTEL,
    SERVICIO_HOTEL_TAB.NOMBRE AS NOMBRE_SERVICIO,
    HOTEL_TB.NOMBRE AS NOMBRE_HOTEL,
    DIRECCION_TB.PROVINCIA,
    DIRECCION_TB.CANTON,
    DIRECCION_TB.DISTRITO,
    DIRECCION_TB.DIRECCION_DETALLADA
FROM 
    SERVICIO_HOTEL_TAB
JOIN 
    HOTEL_TB ON SERVICIO_HOTEL_TAB.ID_HOTEL = HOTEL_TB.ID_HOTEL
LEFT JOIN 
    DIRECCION_TB ON HOTEL_TB.ID_DIRECCION = DIRECCION_TB.ID_DIRECCION;

--Vista Servicios Habitaciones
CREATE OR REPLACE VIEW VISTA_SERVICIOS_MULTIPLES_HABITACIONES AS
SELECT 
    SERVICIO_MULTIPLE_TB.ID_SERVICIO_MULTIPLE,
    HABITACION_TB.NUMERO_HABITACION,
    HABITACION_TB.DESCRIPCION,
    HABITACION_TB.ESTADO_LIMPIEZA,
    HOTEL_TB.NOMBRE AS NOMBRE_HOTEL
FROM 
    SERVICIO_MULTIPLE_TB
JOIN 
    HABITACION_TB ON SERVICIO_MULTIPLE_TB.ID_HABITACION = HABITACION_TB.ID_HABITACION
JOIN 
    HOTEL_TB ON HABITACION_TB.ID_HOTEL = HOTEL_TB.ID_HOTEL;

--Vista Empleados Activos
CREATE OR REPLACE VIEW VISTA_EMPLEADOS_ACTIVOS AS
SELECT 
    EMPLEADO_TB.ID_EMPLEADO,
    PERSONA_TB.NOMBRE,
    PERSONA_TB.PRIMER_APELLIDO,
    PERSONA_TB.SEGUNDO_APELLIDO,
    PERSONA_TB.TELEFONO,
    PERSONA_TB.CORREO,
    EMPLEADO_TB.PUESTO,
    EMPLEADO_TB.SALARIO,
    EMPLEADO_TB.FECHA_INGRESO
FROM 
    EMPLEADO_TB
JOIN 
    PERSONA_TB ON EMPLEADO_TB.ID_PERSONA = PERSONA_TB.ID_PERSONA
WHERE 
    EMPLEADO_TB.ESTADO = 'Activo';

--insert
--Direccion

INSERT INTO DIRECCION_TB (ID_DIRECCION, PROVINCIA, CANTON, DISTRITO, DIRECCION_DETALLADA)
VALUES (1, 'San José', 'Escazú', 'San Rafael', 'Multiplaza Escazú');
INSERT INTO DIRECCION_TB (ID_DIRECCION, PROVINCIA, CANTON, DISTRITO, DIRECCION_DETALLADA)
VALUES (2, 'Heredia', 'Belén', 'La Asunción', 'Zona Franca Metropark');
INSERT INTO DIRECCION_TB (ID_DIRECCION, PROVINCIA, CANTON, DISTRITO, DIRECCION_DETALLADA)
VALUES (3, 'Alajuela', 'Alajuela', 'San José', 'Centro Comercial Plaza Real');
INSERT INTO DIRECCION_TB (ID_DIRECCION, PROVINCIA, CANTON, DISTRITO, DIRECCION_DETALLADA)
VALUES (4, 'Cartago', 'Oreamuno', 'Cot', 'Cerca de la Basílica de Los Ángeles');
INSERT INTO DIRECCION_TB (ID_DIRECCION, PROVINCIA, CANTON, DISTRITO, DIRECCION_DETALLADA)
VALUES (5, 'Guanacaste', 'Liberia', 'Liberia', 'Aeropuerto Daniel Oduber');
INSERT INTO DIRECCION_TB (ID_DIRECCION, PROVINCIA, CANTON, DISTRITO, DIRECCION_DETALLADA)
VALUES (6, 'Puntarenas', 'Garabito', 'Jacó', 'Frente a Playa Jacó');
INSERT INTO DIRECCION_TB (ID_DIRECCION, PROVINCIA, CANTON, DISTRITO, DIRECCION_DETALLADA)
VALUES (7, 'Limón', 'Pococí', 'Guápiles', 'Avenida Principal, Centro Comercial Guápiles');
INSERT INTO DIRECCION_TB (ID_DIRECCION, PROVINCIA, CANTON, DISTRITO, DIRECCION_DETALLADA)
VALUES (8, 'San José', 'Moravia', 'San Vicente', 'Plaza Lincoln');
INSERT INTO DIRECCION_TB (ID_DIRECCION, PROVINCIA, CANTON, DISTRITO, DIRECCION_DETALLADA)
VALUES (9, 'Heredia', 'San Isidro', 'San Francisco', 'Urbanización Las Flores');
INSERT INTO DIRECCION_TB (ID_DIRECCION, PROVINCIA, CANTON, DISTRITO, DIRECCION_DETALLADA)
VALUES (10, 'Alajuela', 'San Carlos', 'Ciudad Quesada', 'Frente al Hospital San Carlos');

/
--Restaurante
INSERT INTO RESTAURANTE_TB (ID_HOTEL, NOMBRE)
VALUES (1, 'Restaurante La Terraza');
INSERT INTO RESTAURANTE_TB (ID_HOTEL, NOMBRE) 
VALUES (1, 'El Buen Sabor');
INSERT INTO RESTAURANTE_TB (ID_HOTEL, NOMBRE) 
VALUES (1, 'Gastro Pub Central');
INSERT INTO RESTAURANTE_TB (ID_HOTEL, NOMBRE) 
VALUES (1, 'Bistro Elegance');
INSERT INTO RESTAURANTE_TB (ID_HOTEL, NOMBRE) 
VALUES (1, 'Asados y Más');
INSERT INTO RESTAURANTE_TB (ID_HOTEL, NOMBRE) 
VALUES (1, 'Cafetería Dulce Aroma');
INSERT INTO RESTAURANTE_TB (ID_HOTEL, NOMBRE) 
VALUES (1, 'Steak House Gourmet');
INSERT INTO RESTAURANTE_TB (ID_HOTEL, NOMBRE) 
VALUES (1, 'El Ranchito');
INSERT INTO RESTAURANTE_TB (ID_HOTEL, NOMBRE) 
VALUES (1, 'Mariscos Del Mar');
INSERT INTO RESTAURANTE_TB (ID_HOTEL, NOMBRE) 
VALUES (1, 'Pizza Express');

--servicio
INSERT INTO servicio_tb (id_servicio, nombre) 
VALUES (1, 'Servicio de limpieza');
INSERT INTO servicio_tb (id_servicio, nombre) 
VALUES (2, 'Wi-Fi gratuito');
INSERT INTO servicio_tb (id_servicio, nombre) 
VALUES (3, 'Desayuno incluido');
INSERT INTO servicio_tb (id_servicio, nombre) 
VALUES (4, 'Transporte al aeropuerto');
INSERT INTO servicio_tb (id_servicio, nombre) 
VALUES (5, 'Gimnasio');
INSERT INTO servicio_tb (id_servicio, nombre) 
VALUES (6, 'Piscina');
INSERT INTO servicio_tb (id_servicio, nombre) 
VALUES (7, 'Servicio a la habitación');
INSERT INTO servicio_tb (id_servicio, nombre) 
VALUES (8, 'Estacionamiento gratuito');
INSERT INTO servicio_tb (id_servicio, nombre) 
VALUES (9, 'Servicio de lavandería');
INSERT INTO servicio_tb (id_servicio, nombre) 
VALUES (10, 'Spa');
/
--horario
INSERT INTO horario_tb (id_horario, fecha_horario, hora_apertura_temp, hora_cierre_temp)
VALUES (11, TO_DATE('2024-06-01', 'YYYY-MM-DD'), '08:00', '10:00');
INSERT INTO horario_tb (id_horario, fecha_horario, hora_apertura_temp, hora_cierre_temp)
VALUES (12, TO_DATE('2024-06-02', 'YYYY-MM-DD'), '09:00', '08:00');
INSERT INTO horario_tb (id_horario, fecha_horario, hora_apertura_temp, hora_cierre_temp)
VALUES (3, TO_DATE('2024-06-03', 'YYYY-MM-DD'), '08:30', '09:00');
INSERT INTO horario_tb (id_horario, fecha_horario, hora_apertura_temp, hora_cierre_temp)
VALUES (4, TO_DATE('2024-06-04', 'YYYY-MM-DD'), '07:00', '07:00');
INSERT INTO horario_tb (id_horario, fecha_horario, hora_apertura_temp, hora_cierre_temp)
VALUES (5, TO_DATE('2024-06-05', 'YYYY-MM-DD'), '09:00', '09:30');
INSERT INTO horario_tb (id_horario, fecha_horario, hora_apertura_temp, hora_cierre_temp)
VALUES (6, TO_DATE('2024-06-06', 'YYYY-MM-DD'), '08:00', '08:30');
INSERT INTO horario_tb (id_horario, fecha_horario, hora_apertura_temp, hora_cierre_temp)
VALUES (7, TO_DATE('2024-06-07', 'YYYY-MM-DD'), '10:00', '06:00');
INSERT INTO horario_tb (id_horario, fecha_horario, hora_apertura_temp, hora_cierre_temp)
VALUES (8, TO_DATE('2024-06-08', 'YYYY-MM-DD'), '07:30', '07:30');
INSERT INTO horario_tb (id_horario, fecha_horario, hora_apertura_temp, hora_cierre_temp)
VALUES (9, TO_DATE('2024-06-09', 'YYYY-MM-DD'), '06:00', '05:00');
INSERT INTO horario_tb (id_horario, fecha_horario, hora_apertura_temp, hora_cierre_temp)
VALUES (10, TO_DATE('2024-06-10', 'YYYY-MM-DD'), '08:00', '08:00');
/
--Persona
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (41, 'Juan', 'Perez', 'Ramirez', 'Cédula', '101010101', '6000-0001', 'juanperez@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (42, 'Maria', 'Lopez', 'Fernandez', 'Cédula', '202020202', '6000-0002', 'marialopez@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (43, 'Carlos', 'Rojas', 'Hernandez', 'Cédula', '303030303', '6000-0003', 'carlosrojas@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (44, 'Laura', 'Castro', 'Mendez', 'Cédula', '404040404', '6000-0004', 'lauracastro@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (45, 'Pedro', 'Gomez', 'Sanchez', 'Cédula', '505050505', '6000-0005', 'pedrogomez@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (46, 'Ana', 'Ramirez', 'Torres', 'Cédula', '606060606', '6000-0006', 'anaramirez@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (47, 'Luis', 'Vargas', 'Jimenez', 'Cédula', '707070707', '6000-0007', 'luisvargas@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (48, 'Carolina', 'Diaz', 'Morales', 'Cédula', '808080808', '6000-0008', 'carolinadiaz@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (49, 'Alberto', 'Reyes', 'Martinez', 'Cédula', '909090909', '6000-0009', 'albertoreyes@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (50, 'Jessica', 'Mora', 'Ruiz', 'Cédula', '111111111', '6000-0010', 'jessicamora@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (51, 'Andres', 'Solano', 'Araya', 'Cédula', '121212121', '6000-0011', 'andressolano@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (52, 'Sofia', 'Chacon', 'Lopez', 'Cédula', '131313131', '6000-0012', 'sofiachacon@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (53, 'Miguel', 'Navarro', 'Diaz', 'Cédula', '141414141', '6000-0013', 'miguelnavarro@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (54, 'Isabel', 'Acosta', 'Solis', 'Cédula', '151515151', '6000-0014', 'isabelacosta@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (55, 'Daniel', 'Quesada', 'Mejia', 'Cédula', '161616161', '6000-0015', 'danielquesada@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (56, 'Natalia', 'Martinez', 'Arce', 'Cédula', '171717171', '6000-0016', 'nataliamartinez@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (57, 'Enrique', 'Rivera', 'Gomez', 'Cédula', '181818181', '6000-0017', 'enriquerivera@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (58, 'Patricia', 'Soto', 'Jimenez', 'Cédula', '191919191', '6000-0018', 'patriciasoto@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (59, 'Roberto', 'Perez', 'Alvarez', 'Cédula', '202020202', '6000-0019', 'robertoperez@gmail.com');
INSERT INTO persona_tb(id_persona, nombre, primer_apellido, segundo_apellido, tipo_documento, cedula, telefono, correo)
VALUES (60, 'Monica', 'Herrera', 'Cruz', 'Cédula', '212121212', '6000-0020', 'monicaherrera@gmail.com');
/
--cliente
INSERT INTO cliente_tb(id_cliente, id_persona)
VALUES (40, 41);
INSERT INTO cliente_tb(id_cliente, id_persona)
VALUES (2, 42);
INSERT INTO cliente_tb(id_cliente, id_persona)
VALUES (3, 43);
INSERT INTO cliente_tb(id_cliente, id_persona)
VALUES (4, 44);
INSERT INTO cliente_tb(id_cliente, id_persona)
VALUES (5, 45);
INSERT INTO cliente_tb(id_cliente, id_persona)
VALUES (6, 46);
INSERT INTO cliente_tb(id_cliente, id_persona)
VALUES (7, 47);
INSERT INTO cliente_tb(id_cliente, id_persona)
VALUES (8, 48);
INSERT INTO cliente_tb(id_cliente, id_persona)
VALUES (9, 49);
INSERT INTO cliente_tb(id_cliente, id_persona)
VALUES (10, 50);
/

--habitacion
INSERT INTO habitacion_tb(id_habitacion, id_hotel, numero_habitacion, descripcion, precio, estado_limpieza, capacidad)
VALUES (1, 1, 101, 'Habitación individual', 50000, 'Limpia', 10);
INSERT INTO habitacion_tb(id_habitacion, id_hotel, numero_habitacion, descripcion, precio, estado_limpieza, capacidad)
VALUES (2, 1, 102, 'Habitación doble', 80000, 'Limpia', 2);
INSERT INTO habitacion_tb(id_habitacion, id_hotel, numero_habitacion, descripcion, precio, estado_limpieza, capacidad)
VALUES (3, 1, 103, 'Suite familiar', 150000, 'Sucio', 4);
INSERT INTO habitacion_tb(id_habitacion, id_hotel, numero_habitacion, descripcion, precio, estado_limpieza, capacidad)
VALUES (4, 1, 104, 'Habitación doble', 85000, 'Limpia', 2);
INSERT INTO habitacion_tb(id_habitacion, id_hotel, numero_habitacion, descripcion, precio, estado_limpieza, capacidad)
VALUES (5, 1, 105, 'Habitación ejecutiva', 120000, 'Limpia', 20);
INSERT INTO habitacion_tb(id_habitacion, id_hotel, numero_habitacion, descripcion, precio, estado_limpieza, capacidad)
VALUES (6, 1, 106, 'Suite presidencial', 200000, 'Limpia', 4);
INSERT INTO habitacion_tb(id_habitacion, id_hotel, numero_habitacion, descripcion, precio, estado_limpieza, capacidad)
VALUES (7, 1, 107, 'Habitación individual', 55000, 'Limpia', 1);
INSERT INTO habitacion_tb(id_habitacion, id_hotel, numero_habitacion, descripcion, precio, estado_limpieza, capacidad)
VALUES (8, 1, 108, 'Suite de lujo', 180000, 'Sucio', 3);
INSERT INTO habitacion_tb(id_habitacion, id_hotel, numero_habitacion, descripcion, precio, estado_limpieza, capacidad)
VALUES (9, 1, 109, 'Habitación económica', 40000, 'Limpia', 6);
INSERT INTO habitacion_tb(id_habitacion, id_hotel, numero_habitacion, descripcion, precio, estado_limpieza, capacidad)
VALUES (10, 1, 110, 'Habitación estándar', 70000, 'Sucio', 20);

/
