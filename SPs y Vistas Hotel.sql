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

CREATE OR REPLACE PACKAGE SERVICIO_PKG IS
    -- Procedimiento para agregar un servicio
    PROCEDURE AGREGAR_SERVICIO(p_nombre IN NVARCHAR2);

    -- Procedimiento para actualizar un servicio
    PROCEDURE ACTUALIZAR_SERVICIO(p_id_servicio IN NUMBER, p_nombre IN NVARCHAR2);

    -- Procedimiento para eliminar un servicio
    PROCEDURE ELIMINAR_SERVICIO(p_id_servicio IN NUMBER);

    -- Procedimiento para obtener todos los servicios
    PROCEDURE OBTENER_SERVICIOS;

    -- Funci�n para verificar si un servicio existe
    FUNCTION EXISTE_SERVICIO(p_id_servicio IN NUMBER) RETURN BOOLEAN;
END SERVICIO_PKG;
/
CREATE OR REPLACE PACKAGE BODY SERVICIO_PKG IS

    -- Procedimiento para agregar un servicio
    PROCEDURE AGREGAR_SERVICIO(p_nombre IN NVARCHAR2) IS
    BEGIN
        INSERT INTO SERVICIO_TB (id_servicio, nombre)
        VALUES (ID_SERVICIO_SEQ.NEXTVAL, p_nombre);
    END AGREGAR_SERVICIO;

    -- Procedimiento para actualizar un servicio
    PROCEDURE ACTUALIZAR_SERVICIO(p_id_servicio IN NUMBER, p_nombre IN NVARCHAR2) IS
    BEGIN
        UPDATE SERVICIO_TB
        SET nombre = p_nombre
        WHERE id_servicio = p_id_servicio;
    END ACTUALIZAR_SERVICIO;

    -- Procedimiento para eliminar un servicio
    PROCEDURE ELIMINAR_SERVICIO(p_id_servicio IN NUMBER) IS
    BEGIN
        DELETE FROM SERVICIO_TB
        WHERE id_servicio = p_id_servicio;
    END ELIMINAR_SERVICIO;

    -- Procedimiento para obtener todos los servicios
    PROCEDURE OBTENER_SERVICIOS IS
        CURSOR c_servicios IS
            SELECT id_servicio, nombre FROM SERVICIO_TB;
        v_id_servicio NUMBER;
        v_nombre NVARCHAR2(100);
    BEGIN
        OPEN c_servicios;
        LOOP
            FETCH c_servicios INTO v_id_servicio, v_nombre;
            EXIT WHEN c_servicios%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id_servicio || ' - Nombre: ' || v_nombre);
        END LOOP;
        CLOSE c_servicios;
    END OBTENER_SERVICIOS;

    -- Funci�n para verificar si un servicio existe
    FUNCTION EXISTE_SERVICIO(p_id_servicio IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM SERVICIO_TB
        WHERE id_servicio = p_id_servicio;

        RETURN v_count > 0;
    END EXISTE_SERVICIO;

END SERVICIO_PKG;

-- Tabla DIRECCION_TB

CREATE OR REPLACE PACKAGE DIRECCION_PKG IS
    -- Procedimiento para agregar una direcci�n
    PROCEDURE AGREGAR_DIRECCION(
        p_provincia IN NVARCHAR2,
        p_canton IN NVARCHAR2,
        p_distrito IN NVARCHAR2,
        p_direccion_detallada IN NVARCHAR2
    );

    -- Procedimiento para actualizar una direcci�n
    PROCEDURE ACTUALIZAR_DIRECCION(
        p_id_direccion IN NUMBER,
        p_provincia IN NVARCHAR2,
        p_canton IN NVARCHAR2,
        p_distrito IN NVARCHAR2,
        p_direccion_detallada IN NVARCHAR2
    );

    -- Procedimiento para eliminar una direcci�n
    PROCEDURE ELIMINAR_DIRECCION(p_id_direccion IN NUMBER);

    -- Procedimiento para obtener todas las direcciones
    PROCEDURE OBTENER_DIRECCIONES;

    -- Funci�n para verificar si una direcci�n existe
    FUNCTION EXISTE_DIRECCION(p_id_direccion IN NUMBER) RETURN BOOLEAN;
END DIRECCION_PKG;


CREATE OR REPLACE PACKAGE BODY DIRECCION_PKG IS

    -- Procedimiento para agregar una direcci�n
    PROCEDURE AGREGAR_DIRECCION(
        p_provincia IN NVARCHAR2,
        p_canton IN NVARCHAR2,
        p_distrito IN NVARCHAR2,
        p_direccion_detallada IN NVARCHAR2
    ) IS
    BEGIN
        INSERT INTO DIRECCION_TB (ID_DIRECCION, PROVINCIA, CANTON, DISTRITO, DIRECCION_DETALLADA)
        VALUES (ID_DIRECCION_SEQ.NEXTVAL, p_provincia, p_canton, p_distrito, p_direccion_detallada);
    END AGREGAR_DIRECCION;

    -- Procedimiento para actualizar una direcci�n
    PROCEDURE ACTUALIZAR_DIRECCION(
        p_id_direccion IN NUMBER,
        p_provincia IN NVARCHAR2,
        p_canton IN NVARCHAR2,
        p_distrito IN NVARCHAR2,
        p_direccion_detallada IN NVARCHAR2
    ) IS
    BEGIN
        UPDATE DIRECCION_TB
        SET PROVINCIA = p_provincia,
            CANTON = p_canton,
            DISTRITO = p_distrito,
            DIRECCION_DETALLADA = p_direccion_detallada
        WHERE ID_DIRECCION = p_id_direccion;
    END ACTUALIZAR_DIRECCION;

    -- Procedimiento para eliminar una direcci�n
    PROCEDURE ELIMINAR_DIRECCION(p_id_direccion IN NUMBER) IS
    BEGIN
        DELETE FROM DIRECCION_TB
        WHERE ID_DIRECCION = p_id_direccion;
    END ELIMINAR_DIRECCION;

    -- Procedimiento para obtener todas las direcciones
    PROCEDURE OBTENER_DIRECCIONES IS
        CURSOR c_direcciones IS
            SELECT ID_DIRECCION, PROVINCIA, CANTON, DISTRITO, DIRECCION_DETALLADA
            FROM DIRECCION_TB;
        v_id_direccion NUMBER;
        v_provincia NVARCHAR2(100);
        v_canton NVARCHAR2(100);
        v_distrito NVARCHAR2(100);
        v_direccion_detallada NVARCHAR2(100);
    BEGIN
        OPEN c_direcciones;
        LOOP
            FETCH c_direcciones INTO v_id_direccion, v_provincia, v_canton, v_distrito, v_direccion_detallada;
            EXIT WHEN c_direcciones%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id_direccion || ', Provincia: ' || v_provincia ||
                                 ', Cant�n: ' || v_canton || ', Distrito: ' || v_distrito ||
                                 ', Detalle: ' || v_direccion_detallada);
        END LOOP;
        CLOSE c_direcciones;
    END OBTENER_DIRECCIONES;

    -- Funci�n para verificar si una direcci�n existe
    FUNCTION EXISTE_DIRECCION(p_id_direccion IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM DIRECCION_TB
        WHERE ID_DIRECCION = p_id_direccion;

        RETURN v_count > 0;
    END EXISTE_DIRECCION;

END DIRECCION_PKG;

CREATE OR REPLACE PACKAGE HORARIO_PKG IS
    -- Procedimiento para agregar un horario
    PROCEDURE AGREGAR_HORARIO(
        p_fecha_horario IN DATE,
        p_hora_apertura IN NVARCHAR2,
        p_hora_cierre IN NVARCHAR2
    );

    -- Procedimiento para actualizar un horario
    PROCEDURE ACTUALIZAR_HORARIO(
        p_id_horario IN NUMBER,
        p_fecha_horario IN DATE,
        p_hora_apertura IN NVARCHAR2,
        p_hora_cierre IN NVARCHAR2
    );

    -- Procedimiento para eliminar un horario
    PROCEDURE ELIMINAR_HORARIO(p_id_horario IN NUMBER);

    -- Procedimiento para obtener todos los horarios
    PROCEDURE OBTENER_HORARIOS;

    -- Funci�n para verificar si un horario existe
    FUNCTION EXISTE_HORARIO(p_id_horario IN NUMBER) RETURN BOOLEAN;
END HORARIO_PKG;


CREATE OR REPLACE PACKAGE BODY HORARIO_PKG IS

    -- Procedimiento para agregar un horario
    PROCEDURE AGREGAR_HORARIO(
        p_fecha_horario IN DATE,
        p_hora_apertura IN NVARCHAR2,
        p_hora_cierre IN NVARCHAR2
    ) IS
    BEGIN
        INSERT INTO HORARIO_TB (ID_HORARIO, FECHA_HORARIO, HORA_APERTURA, HORA_CIERRE)
        VALUES (ID_HORARIO_SEQ.NEXTVAL, p_fecha_horario, p_hora_apertura, p_hora_cierre);
    END AGREGAR_HORARIO;

    -- Procedimiento para actualizar un horario
    PROCEDURE ACTUALIZAR_HORARIO(
        p_id_horario IN NUMBER,
        p_fecha_horario IN DATE,
        p_hora_apertura IN NVARCHAR2,
        p_hora_cierre IN NVARCHAR2
    ) IS
    BEGIN
        UPDATE HORARIO_TB
        SET FECHA_HORARIO = p_fecha_horario,
            HORA_APERTURA = p_hora_apertura,
            HORA_CIERRE = p_hora_cierre
        WHERE ID_HORARIO = p_id_horario;
    END ACTUALIZAR_HORARIO;

    -- Procedimiento para eliminar un horario
    PROCEDURE ELIMINAR_HORARIO(p_id_horario IN NUMBER) IS
    BEGIN
        DELETE FROM HORARIO_TB
        WHERE ID_HORARIO = p_id_horario;
    END ELIMINAR_HORARIO;

    -- Procedimiento para obtener todos los horarios
    PROCEDURE OBTENER_HORARIOS IS
        CURSOR c_horarios IS
            SELECT ID_HORARIO, FECHA_HORARIO, HORA_APERTURA, HORA_CIERRE
            FROM HORARIO_TB;
        v_id_horario NUMBER;
        v_fecha_horario DATE;
        v_hora_apertura NVARCHAR2(50);
        v_hora_cierre NVARCHAR2(50);
    BEGIN
        OPEN c_horarios;
        LOOP
            FETCH c_horarios INTO v_id_horario, v_fecha_horario, v_hora_apertura, v_hora_cierre;
            EXIT WHEN c_horarios%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id_horario || 
                                 ', Fecha: ' || TO_CHAR(v_fecha_horario, 'YYYY-MM-DD') ||
                                 ', Apertura: ' || v_hora_apertura ||
                                 ', Cierre: ' || v_hora_cierre);
        END LOOP;
        CLOSE c_horarios;
    END OBTENER_HORARIOS;

    -- Funci�n para verificar si un horario existe
    FUNCTION EXISTE_HORARIO(p_id_horario IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM HORARIO_TB
        WHERE ID_HORARIO = p_id_horario;

        RETURN v_count > 0;
    END EXISTE_HORARIO;

END HORARIO_PKG;


--Tabla HOTEL_TB

CREATE OR REPLACE PACKAGE HOTEL_PKG IS
    -- Procedimiento para agregar un hotel
    PROCEDURE AGREGAR_HOTEL(
        p_id_direccion IN NUMBER,
        p_id_horario IN NUMBER,
        p_nombre IN NVARCHAR2,
        p_telefono IN NVARCHAR2,
        p_correo IN NVARCHAR2
    );

    -- Procedimiento para actualizar un hotel
    PROCEDURE ACTUALIZAR_HOTEL(
        p_id_hotel IN NUMBER,
        p_id_direccion IN NUMBER,
        p_id_horario IN NUMBER,
        p_nombre IN NVARCHAR2,
        p_telefono IN NVARCHAR2,
        p_correo IN NVARCHAR2
    );

    -- Procedimiento para eliminar un hotel
    PROCEDURE ELIMINAR_HOTEL(p_id_hotel IN NUMBER);

    -- Procedimiento para obtener todos los hoteles
    PROCEDURE OBTENER_HOTELES;

    -- Funci�n para verificar si un hotel existe
    FUNCTION EXISTE_HOTEL(p_id_hotel IN NUMBER) RETURN BOOLEAN;
END HOTEL_PKG;


CREATE OR REPLACE PACKAGE BODY HOTEL_PKG IS

    -- Procedimiento para agregar un hotel
    PROCEDURE AGREGAR_HOTEL(
        p_id_direccion IN NUMBER,
        p_id_horario IN NUMBER,
        p_nombre IN NVARCHAR2,
        p_telefono IN NVARCHAR2,
        p_correo IN NVARCHAR2
    ) IS
    BEGIN
        INSERT INTO HOTEL_TB (ID_HOTEL, ID_DIRECCION, ID_HORARIO, NOMBRE, TELEFONO, CORREO)
        VALUES (ID_HOTEL_SEQ.NEXTVAL, p_id_direccion, p_id_horario, p_nombre, p_telefono, p_correo);
    END AGREGAR_HOTEL;

    -- Procedimiento para actualizar un hotel
    PROCEDURE ACTUALIZAR_HOTEL(
        p_id_hotel IN NUMBER,
        p_id_direccion IN NUMBER,
        p_id_horario IN NUMBER,
        p_nombre IN NVARCHAR2,
        p_telefono IN NVARCHAR2,
        p_correo IN NVARCHAR2
    ) IS
    BEGIN
        UPDATE HOTEL_TB
        SET ID_DIRECCION = p_id_direccion,
            ID_HORARIO = p_id_horario,
            NOMBRE = p_nombre,
            TELEFONO = p_telefono,
            CORREO = p_correo
        WHERE ID_HOTEL = p_id_hotel;
    END ACTUALIZAR_HOTEL;

    -- Procedimiento para eliminar un hotel
    PROCEDURE ELIMINAR_HOTEL(p_id_hotel IN NUMBER) IS
    BEGIN
        DELETE FROM HOTEL_TB
        WHERE ID_HOTEL = p_id_hotel;
    END ELIMINAR_HOTEL;

    -- Procedimiento para obtener todos los hoteles
    PROCEDURE OBTENER_HOTELES IS
        CURSOR c_hoteles IS
            SELECT H.ID_HOTEL, H.NOMBRE, H.TELEFONO, H.CORREO, D.PROVINCIA, D.CANTON, D.DISTRITO, D.DIRECCION_DETALLADA,
                   HR.FECHA_HORARIO, HR.HORA_APERTURA, HR.HORA_CIERRE
            FROM HOTEL_TB H
            LEFT JOIN DIRECCION_TB D ON H.ID_DIRECCION = D.ID_DIRECCION
            LEFT JOIN HORARIO_TB HR ON H.ID_HORARIO = HR.ID_HORARIO;
        v_id_hotel NUMBER;
        v_nombre NVARCHAR2(100);
        v_telefono NVARCHAR2(100);
        v_correo NVARCHAR2(100);
        v_provincia NVARCHAR2(100);
        v_canton NVARCHAR2(100);
        v_distrito NVARCHAR2(100);
        v_direccion_detallada NVARCHAR2(100);
        v_fecha_horario DATE;
        v_hora_apertura NVARCHAR2(50);
        v_hora_cierre NVARCHAR2(50);
    BEGIN
        OPEN c_hoteles;
        LOOP
            FETCH c_hoteles INTO v_id_hotel, v_nombre, v_telefono, v_correo, 
                               v_provincia, v_canton, v_distrito, v_direccion_detallada,
                               v_fecha_horario, v_hora_apertura, v_hora_cierre;
            EXIT WHEN c_hoteles%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('Hotel ID: ' || v_id_hotel || ', Nombre: ' || v_nombre);
            DBMS_OUTPUT.PUT_LINE('Tel�fono: ' || v_telefono || ', Correo: ' || v_correo);
            DBMS_OUTPUT.PUT_LINE('Direcci�n: ' || v_provincia || ', ' || v_canton || ', ' || v_distrito || ', ' || v_direccion_detallada);
            DBMS_OUTPUT.PUT_LINE('Horario: Fecha: ' || TO_CHAR(v_fecha_horario, 'YYYY-MM-DD') || 
                                 ', Apertura: ' || v_hora_apertura || 
                                 ', Cierre: ' || v_hora_cierre);
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
        END LOOP;
        CLOSE c_hoteles;
    END OBTENER_HOTELES;

    -- Funci�n para verificar si un hotel existe
    FUNCTION EXISTE_HOTEL(p_id_hotel IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM HOTEL_TB
        WHERE ID_HOTEL = p_id_hotel;

        RETURN v_count > 0;
    END EXISTE_HOTEL;

END HOTEL_PKG;


CREATE OR REPLACE PACKAGE SERVICIO_HOTEL_PKG IS
    -- Procedimiento para agregar un servicio al hotel
    PROCEDURE AGREGAR_SERVICIO_HOTEL(
        p_id_hotel IN NUMBER,
        p_nombre IN NVARCHAR2,
        p_estado IN NVARCHAR2
    );

    -- Procedimiento para actualizar un servicio del hotel
    PROCEDURE ACTUALIZAR_SERVICIO_HOTEL(
        p_id_servicio_hotel IN NUMBER,
        p_nombre IN NVARCHAR2,
        p_estado IN NVARCHAR2
    );

    -- Procedimiento para eliminar un servicio del hotel
    PROCEDURE ELIMINAR_SERVICIO_HOTEL(p_id_servicio_hotel IN NUMBER);

    -- Procedimiento para obtener todos los servicios asociados a un hotel
    PROCEDURE OBTENER_SERVICIOS_HOTEL(p_id_hotel IN NUMBER);

    -- Funci�n para verificar si un servicio existe
    FUNCTION EXISTE_SERVICIO_HOTEL(p_id_servicio_hotel IN NUMBER) RETURN BOOLEAN;
END SERVICIO_HOTEL_PKG;


CREATE OR REPLACE PACKAGE BODY SERVICIO_HOTEL_PKG IS

    -- Procedimiento para agregar un servicio al hotel
    PROCEDURE AGREGAR_SERVICIO_HOTEL(
        p_id_hotel IN NUMBER,
        p_nombre IN NVARCHAR2,
        p_estado IN NVARCHAR2
    ) IS
        v_hotel_existente NUMBER;
    BEGIN
        -- Verificar si el hotel existe
        SELECT COUNT(*)
        INTO v_hotel_existente
        FROM HOTEL_TB
        WHERE ID_HOTEL = p_id_hotel;

        IF v_hotel_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El hotel especificado no existe.');
        END IF;

        -- Si todo es v�lido, realizar el INSERT en SERVICIO_HOTEL_TAB
        INSERT INTO SERVICIO_HOTEL_TAB (ID_SERVICIO_HOTEL, ID_HOTEL, NOMBRE, ESTADO)
        VALUES (ID_SERVICIO_HOTEL_SEQ.NEXTVAL, p_id_hotel, p_nombre, p_estado);
    END AGREGAR_SERVICIO_HOTEL;

    -- Procedimiento para actualizar un servicio del hotel
    PROCEDURE ACTUALIZAR_SERVICIO_HOTEL(
        p_id_servicio_hotel IN NUMBER,
        p_nombre IN NVARCHAR2,
        p_estado IN NVARCHAR2
    ) IS
        v_servicio_existente NUMBER;
    BEGIN
        -- Verificar si el servicio existe
        SELECT COUNT(*)
        INTO v_servicio_existente
        FROM SERVICIO_HOTEL_TAB
        WHERE ID_SERVICIO_HOTEL = p_id_servicio_hotel;

        IF v_servicio_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El servicio especificado no existe.');
        END IF;

        -- Actualizar el servicio
        UPDATE SERVICIO_HOTEL_TAB
        SET NOMBRE = p_nombre,
            ESTADO = p_estado
        WHERE ID_SERVICIO_HOTEL = p_id_servicio_hotel;
    END ACTUALIZAR_SERVICIO_HOTEL;

    -- Procedimiento para eliminar un servicio del hotel
    PROCEDURE ELIMINAR_SERVICIO_HOTEL(p_id_servicio_hotel IN NUMBER) IS
        v_servicio_existente NUMBER;
    BEGIN
        -- Verificar si el servicio existe
        SELECT COUNT(*)
        INTO v_servicio_existente
        FROM SERVICIO_HOTEL_TAB
        WHERE ID_SERVICIO_HOTEL = p_id_servicio_hotel;

        IF v_servicio_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El servicio especificado no existe.');
        END IF;

        -- Eliminar el servicio
        DELETE FROM SERVICIO_HOTEL_TAB
        WHERE ID_SERVICIO_HOTEL = p_id_servicio_hotel;
    END ELIMINAR_SERVICIO_HOTEL;

    -- Procedimiento para obtener todos los servicios asociados a un hotel
    PROCEDURE OBTENER_SERVICIOS_HOTEL(p_id_hotel IN NUMBER) IS
        CURSOR c_servicios IS
            SELECT ID_SERVICIO_HOTEL, NOMBRE, ESTADO
            FROM SERVICIO_HOTEL_TAB
            WHERE ID_HOTEL = p_id_hotel;

        v_id_servicio_hotel NUMBER;
        v_nombre NVARCHAR2(100);
        v_estado NVARCHAR2(100);
    BEGIN
        OPEN c_servicios;
        LOOP
            FETCH c_servicios INTO v_id_servicio_hotel, v_nombre, v_estado;
            EXIT WHEN c_servicios%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID Servicio: ' || v_id_servicio_hotel || ', Nombre: ' || v_nombre || ', Estado: ' || v_estado);
        END LOOP;
        CLOSE c_servicios;
    END OBTENER_SERVICIOS_HOTEL;

    -- Funci�n para verificar si un servicio existe
    FUNCTION EXISTE_SERVICIO_HOTEL(p_id_servicio_hotel IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM SERVICIO_HOTEL_TAB
        WHERE ID_SERVICIO_HOTEL = p_id_servicio_hotel;

        RETURN v_count > 0;
    END EXISTE_SERVICIO_HOTEL;

END SERVICIO_HOTEL_PKG;


CREATE OR REPLACE PACKAGE RESTAURANTE_PKG IS
    -- Procedimiento para agregar un restaurante
    PROCEDURE AGREGAR_RESTAURANTE(
        p_id_hotel IN NUMBER,
        p_nombre IN NVARCHAR2
    );

    -- Procedimiento para actualizar un restaurante
    PROCEDURE ACTUALIZAR_RESTAURANTE(
        p_id_restaurante IN NUMBER,
        p_nombre IN NVARCHAR2
    );

    -- Procedimiento para eliminar un restaurante
    PROCEDURE ELIMINAR_RESTAURANTE(p_id_restaurante IN NUMBER);

    -- Procedimiento para obtener todos los restaurantes asociados a un hotel
    PROCEDURE OBTENER_RESTAURANTES(p_id_hotel IN NUMBER);

    -- Funci�n para verificar si un restaurante existe
    FUNCTION EXISTE_RESTAURANTE(p_id_restaurante IN NUMBER) RETURN BOOLEAN;
END RESTAURANTE_PKG;


CREATE OR REPLACE PACKAGE BODY RESTAURANTE_PKG IS

    -- Procedimiento para agregar un restaurante
    PROCEDURE AGREGAR_RESTAURANTE(
        p_id_hotel IN NUMBER,
        p_nombre IN NVARCHAR2
    ) IS
        v_hotel_existente NUMBER;
    BEGIN
        -- Verificar si el hotel existe
        SELECT COUNT(*)
        INTO v_hotel_existente
        FROM HOTEL_TB
        WHERE ID_HOTEL = p_id_hotel;

        IF v_hotel_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El hotel especificado no existe.');
        END IF;

        -- Insertar el restaurante
        INSERT INTO RESTAURANTE_TB (ID_RESTAURANTE, ID_HOTEL, NOMBRE)
        VALUES (ID_RESTAURANTE_SEQ.NEXTVAL, p_id_hotel, p_nombre);
    END AGREGAR_RESTAURANTE;

    -- Procedimiento para actualizar un restaurante
    PROCEDURE ACTUALIZAR_RESTAURANTE(
        p_id_restaurante IN NUMBER,
        p_nombre IN NVARCHAR2
    ) IS
        v_restaurante_existente NUMBER;
    BEGIN
        -- Verificar si el restaurante existe
        SELECT COUNT(*)
        INTO v_restaurante_existente
        FROM RESTAURANTE_TB
        WHERE ID_RESTAURANTE = p_id_restaurante;

        IF v_restaurante_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El restaurante especificado no existe.');
        END IF;

        -- Actualizar el nombre del restaurante
        UPDATE RESTAURANTE_TB
        SET NOMBRE = p_nombre
        WHERE ID_RESTAURANTE = p_id_restaurante;
    END ACTUALIZAR_RESTAURANTE;

    -- Procedimiento para eliminar un restaurante
    PROCEDURE ELIMINAR_RESTAURANTE(p_id_restaurante IN NUMBER) IS
        v_restaurante_existente NUMBER;
    BEGIN
        -- Verificar si el restaurante existe
        SELECT COUNT(*)
        INTO v_restaurante_existente
        FROM RESTAURANTE_TB
        WHERE ID_RESTAURANTE = p_id_restaurante;

        IF v_restaurante_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El restaurante especificado no existe.');
        END IF;

        -- Eliminar el restaurante
        DELETE FROM RESTAURANTE_TB
        WHERE ID_RESTAURANTE = p_id_restaurante;
    END ELIMINAR_RESTAURANTE;

    -- Procedimiento para obtener todos los restaurantes asociados a un hotel
    PROCEDURE OBTENER_RESTAURANTES(p_id_hotel IN NUMBER) IS
        CURSOR c_restaurantes IS
            SELECT ID_RESTAURANTE, NOMBRE
            FROM RESTAURANTE_TB
            WHERE ID_HOTEL = p_id_hotel;

        v_id_restaurante NUMBER;
        v_nombre NVARCHAR2(100);
        v_hotel_existente NUMBER;
    BEGIN
        -- Verificar si el hotel existe
        SELECT COUNT(*)
        INTO v_hotel_existente
        FROM HOTEL_TB
        WHERE ID_HOTEL = p_id_hotel;

        IF v_hotel_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'El hotel especificado no tiene restaurantes asociados.');
        END IF;

        -- Obtener los restaurantes asociados
        OPEN c_restaurantes;
        LOOP
            FETCH c_restaurantes INTO v_id_restaurante, v_nombre;
            EXIT WHEN c_restaurantes%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID Restaurante: ' || v_id_restaurante || ', Nombre: ' || v_nombre);
        END LOOP;
        CLOSE c_restaurantes;
    END OBTENER_RESTAURANTES;

    -- Funci�n para verificar si un restaurante existe
    FUNCTION EXISTE_RESTAURANTE(p_id_restaurante IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM RESTAURANTE_TB
        WHERE ID_RESTAURANTE = p_id_restaurante;

        RETURN v_count > 0;
    END EXISTE_RESTAURANTE;

END RESTAURANTE_PKG;



CREATE OR REPLACE PACKAGE PLATILLO_PKG IS
    -- Procedimiento para agregar un platillo
    PROCEDURE AGREGAR_PLATILLO(
        p_id_restaurante IN NUMBER,
        p_nombre IN NVARCHAR2,
        p_precio IN NUMBER,
        p_cantidad IN NUMBER
    );

    -- Procedimiento para actualizar un platillo
    PROCEDURE ACTUALIZAR_PLATILLO(
        p_id_platillo IN NUMBER,
        p_nombre IN NVARCHAR2,
        p_precio IN NUMBER,
        p_cantidad IN NUMBER
    );

    -- Procedimiento para eliminar un platillo
    PROCEDURE ELIMINAR_PLATILLO(p_id_platillo IN NUMBER);

    -- Procedimiento para obtener todos los platillos de un restaurante
    PROCEDURE OBTENER_PLATILLOS(p_id_restaurante IN NUMBER);

    -- Funci�n para verificar si un platillo existe
    FUNCTION EXISTE_PLATILLO(p_id_platillo IN NUMBER) RETURN BOOLEAN;
END PLATILLO_PKG;


CREATE OR REPLACE PACKAGE BODY PLATILLO_PKG IS

    -- Procedimiento para agregar un platillo
    PROCEDURE AGREGAR_PLATILLO(
        p_id_restaurante IN NUMBER,
        p_nombre IN NVARCHAR2,
        p_precio IN NUMBER,
        p_cantidad IN NUMBER
    ) IS
        v_restaurante_existente NUMBER;
    BEGIN
        -- Verificar si el restaurante existe
        SELECT COUNT(*)
        INTO v_restaurante_existente
        FROM RESTAURANTE_TB
        WHERE ID_RESTAURANTE = p_id_restaurante;

        IF v_restaurante_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El restaurante especificado no existe.');
        END IF;

        -- Insertar el platillo
        INSERT INTO PLATILLO_TB (ID_PLATILLO, ID_RESTAURANTE, NOMBRE, PRECIO, CANTIDAD)
        VALUES (ID_PLATILLO_SEQ.NEXTVAL, p_id_restaurante, p_nombre, p_precio, p_cantidad);
    END AGREGAR_PLATILLO;

    -- Procedimiento para actualizar un platillo
    PROCEDURE ACTUALIZAR_PLATILLO(
        p_id_platillo IN NUMBER,
        p_nombre IN NVARCHAR2,
        p_precio IN NUMBER,
        p_cantidad IN NUMBER
    ) IS
        v_platillo_existente NUMBER;
    BEGIN
        -- Verificar si el platillo existe
        SELECT COUNT(*)
        INTO v_platillo_existente
        FROM PLATILLO_TB
        WHERE ID_PLATILLO = p_id_platillo;

        IF v_platillo_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El platillo especificado no existe.');
        END IF;

        -- Actualizar el platillo
        UPDATE PLATILLO_TB
        SET NOMBRE = p_nombre,
            PRECIO = p_precio,
            CANTIDAD = p_cantidad
        WHERE ID_PLATILLO = p_id_platillo;
    END ACTUALIZAR_PLATILLO;

    -- Procedimiento para eliminar un platillo
    PROCEDURE ELIMINAR_PLATILLO(p_id_platillo IN NUMBER) IS
        v_platillo_existente NUMBER;
    BEGIN
        -- Verificar si el platillo existe
        SELECT COUNT(*)
        INTO v_platillo_existente
        FROM PLATILLO_TB
        WHERE ID_PLATILLO = p_id_platillo;

        IF v_platillo_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El platillo especificado no existe.');
        END IF;

        -- Eliminar el platillo
        DELETE FROM PLATILLO_TB
        WHERE ID_PLATILLO = p_id_platillo;
    END ELIMINAR_PLATILLO;

    -- Procedimiento para obtener todos los platillos de un restaurante
    PROCEDURE OBTENER_PLATILLOS(p_id_restaurante IN NUMBER) IS
        CURSOR c_platillos IS
            SELECT ID_PLATILLO, NOMBRE, PRECIO, CANTIDAD
            FROM PLATILLO_TB
            WHERE ID_RESTAURANTE = p_id_restaurante;

        v_id_platillo NUMBER;
        v_nombre NVARCHAR2(100);
        v_precio NUMBER;
        v_cantidad NUMBER;
    BEGIN
        -- Obtener los platillos asociados al restaurante
        OPEN c_platillos;
        LOOP
            FETCH c_platillos INTO v_id_platillo, v_nombre, v_precio, v_cantidad;
            EXIT WHEN c_platillos%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID Platillo: ' || v_id_platillo || 
                                 ', Nombre: ' || v_nombre || 
                                 ', Precio: ' || v_precio || 
                                 ', Cantidad: ' || v_cantidad);
        END LOOP;
        CLOSE c_platillos;
    END OBTENER_PLATILLOS;

    -- Funci�n para verificar si un platillo existe
    FUNCTION EXISTE_PLATILLO(p_id_platillo IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM PLATILLO_TB
        WHERE ID_PLATILLO = p_id_platillo;

        RETURN v_count > 0;
    END EXISTE_PLATILLO;

END PLATILLO_PKG;

---- Tabla HABITACION_TB

CREATE OR REPLACE PACKAGE HABITACION_PKG IS
    -- Procedimiento para agregar una habitaci�n
    PROCEDURE AGREGAR_HABITACION(
        p_id_hotel IN NUMBER,
        p_numero_habitacion IN NUMBER,
        p_precio IN NUMBER,
        p_descripcion IN NVARCHAR2,
        p_estado_limpieza IN NVARCHAR2,
        p_capacidad IN NUMBER
    );

    -- Procedimiento para actualizar una habitaci�n
    PROCEDURE ACTUALIZAR_HABITACION(
        p_id_habitacion IN NUMBER,
        p_numero_habitacion IN NUMBER,
        p_precio IN NUMBER,
        p_descripcion IN NVARCHAR2,
        p_estado_limpieza IN NVARCHAR2,
        p_capacidad IN NUMBER
    );

    -- Procedimiento para eliminar una habitaci�n
    PROCEDURE ELIMINAR_HABITACION(p_id_habitacion IN NUMBER);

    -- Procedimiento para obtener todas las habitaciones de un hotel
    PROCEDURE OBTENER_HABITACIONES(p_id_hotel IN NUMBER);

    -- Funci�n para verificar si una habitaci�n existe
    FUNCTION EXISTE_HABITACION(p_id_habitacion IN NUMBER) RETURN BOOLEAN;
END HABITACION_PKG;


CREATE OR REPLACE PACKAGE BODY HABITACION_PKG IS

    -- Procedimiento para agregar una habitaci�n
    PROCEDURE AGREGAR_HABITACION(
        p_id_hotel IN NUMBER,
        p_numero_habitacion IN NUMBER,
        p_precio IN NUMBER,
        p_descripcion IN NVARCHAR2,
        p_estado_limpieza IN NVARCHAR2,
        p_capacidad IN NUMBER
    ) IS
        v_hotel_existente NUMBER;
    BEGIN
        -- Verificar si el hotel existe
        SELECT COUNT(*)
        INTO v_hotel_existente
        FROM HOTEL_TB
        WHERE ID_HOTEL = p_id_hotel;

        IF v_hotel_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El hotel especificado no existe.');
        END IF;

        -- Insertar la habitaci�n
        INSERT INTO HABITACION_TB (
            ID_HABITACION, ID_HOTEL, NUMERO_HABITACION, PRECIO, DESCRIPCION, ESTADO_LIMPIEZA, CAPACIDAD
        ) VALUES (
            ID_HABITACION_SEQ.NEXTVAL, p_id_hotel, p_numero_habitacion, p_precio, p_descripcion, p_estado_limpieza, p_capacidad
        );
    END AGREGAR_HABITACION;

    -- Procedimiento para actualizar una habitaci�n
    PROCEDURE ACTUALIZAR_HABITACION(
        p_id_habitacion IN NUMBER,
        p_numero_habitacion IN NUMBER,
        p_precio IN NUMBER,
        p_descripcion IN NVARCHAR2,
        p_estado_limpieza IN NVARCHAR2,
        p_capacidad IN NUMBER
    ) IS
        v_habitacion_existente NUMBER;
    BEGIN
        -- Verificar si la habitaci�n existe
        SELECT COUNT(*)
        INTO v_habitacion_existente
        FROM HABITACION_TB
        WHERE ID_HABITACION = p_id_habitacion;

        IF v_habitacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'La habitaci�n especificada no existe.');
        END IF;

        -- Actualizar la habitaci�n
        UPDATE HABITACION_TB
        SET NUMERO_HABITACION = p_numero_habitacion,
            PRECIO = p_precio,
            DESCRIPCION = p_descripcion,
            ESTADO_LIMPIEZA = p_estado_limpieza,
            CAPACIDAD = p_capacidad
        WHERE ID_HABITACION = p_id_habitacion;
    END ACTUALIZAR_HABITACION;

    -- Procedimiento para eliminar una habitaci�n
    PROCEDURE ELIMINAR_HABITACION(p_id_habitacion IN NUMBER) IS
        v_habitacion_existente NUMBER;
    BEGIN
        -- Verificar si la habitaci�n existe
        SELECT COUNT(*)
        INTO v_habitacion_existente
        FROM HABITACION_TB
        WHERE ID_HABITACION = p_id_habitacion;

        IF v_habitacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'La habitaci�n especificada no existe.');
        END IF;

        -- Eliminar la habitaci�n
        DELETE FROM HABITACION_TB
        WHERE ID_HABITACION = p_id_habitacion;
    END ELIMINAR_HABITACION;

    -- Procedimiento para obtener todas las habitaciones de un hotel
    PROCEDURE OBTENER_HABITACIONES(p_id_hotel IN NUMBER) IS
        CURSOR c_habitaciones IS
            SELECT ID_HABITACION, NUMERO_HABITACION, PRECIO, DESCRIPCION, ESTADO_LIMPIEZA, CAPACIDAD
            FROM HABITACION_TB
            WHERE ID_HOTEL = p_id_hotel;

        v_id_habitacion NUMBER;
        v_numero_habitacion NUMBER;
        v_precio NUMBER;
        v_descripcion NVARCHAR2(150);
        v_estado_limpieza NVARCHAR2(100);
        v_capacidad NUMBER;
    BEGIN
        -- Obtener las habitaciones asociadas al hotel
        OPEN c_habitaciones;
        LOOP
            FETCH c_habitaciones INTO v_id_habitacion, v_numero_habitacion, v_precio, v_descripcion, v_estado_limpieza, v_capacidad;
            EXIT WHEN c_habitaciones%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID Habitaci�n: ' || v_id_habitacion || 
                                 ', N�mero: ' || v_numero_habitacion || 
                                 ', Precio: ' || v_precio || 
                                 ', Descripci�n: ' || v_descripcion || 
                                 ', Estado de Limpieza: ' || v_estado_limpieza || 
                                 ', Capacidad: ' || v_capacidad);
        END LOOP;
        CLOSE c_habitaciones;
    END OBTENER_HABITACIONES;

    -- Funci�n para verificar si una habitaci�n existe
    FUNCTION EXISTE_HABITACION(p_id_habitacion IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM HABITACION_TB
        WHERE ID_HABITACION = p_id_habitacion;

        RETURN v_count > 0;
    END EXISTE_HABITACION;

END HABITACION_PKG;


--Tabla PERSONA_TB

CREATE OR REPLACE PACKAGE PERSONA_PKG IS
    -- Procedimiento para agregar una persona
    PROCEDURE AGREGAR_PERSONA(
        p_tipo_documento IN NVARCHAR2,
        p_cedula IN NVARCHAR2,
        p_telefono IN NVARCHAR2,
        p_correo IN NVARCHAR2,
        p_nombre IN NVARCHAR2,
        p_primer_apellido IN NVARCHAR2,
        p_segundo_apellido IN NVARCHAR2
    );

    -- Procedimiento para actualizar los datos de una persona
    PROCEDURE ACTUALIZAR_PERSONA(
        p_id_persona IN NUMBER,
        p_tipo_documento IN NVARCHAR2,
        p_cedula IN NVARCHAR2,
        p_telefono IN NVARCHAR2,
        p_correo IN NVARCHAR2,
        p_nombre IN NVARCHAR2,
        p_primer_apellido IN NVARCHAR2,
        p_segundo_apellido IN NVARCHAR2
    );

    -- Procedimiento para eliminar una persona
    PROCEDURE ELIMINAR_PERSONA(p_id_persona IN NUMBER);

    -- Procedimiento para listar todas las personas
    PROCEDURE OBTENER_PERSONAS;

    -- Funci�n para verificar si una persona existe
    FUNCTION EXISTE_PERSONA(p_id_persona IN NUMBER) RETURN BOOLEAN;
END PERSONA_PKG;


CREATE OR REPLACE PACKAGE BODY PERSONA_PKG IS

    -- Procedimiento para agregar una persona
    PROCEDURE AGREGAR_PERSONA(
        p_tipo_documento IN NVARCHAR2,
        p_cedula IN NVARCHAR2,
        p_telefono IN NVARCHAR2,
        p_correo IN NVARCHAR2,
        p_nombre IN NVARCHAR2,
        p_primer_apellido IN NVARCHAR2,
        p_segundo_apellido IN NVARCHAR2
    ) IS
    BEGIN
        INSERT INTO PERSONA_TB (
            ID_PERSONA, TIPO_DOCUMENTO, CEDULA, TELEFONO, CORREO, NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO
        ) VALUES (
            ID_PERSONA_SEQ.NEXTVAL, p_tipo_documento, p_cedula, p_telefono, p_correo, p_nombre, p_primer_apellido, p_segundo_apellido
        );
    END AGREGAR_PERSONA;

    -- Procedimiento para actualizar los datos de una persona
    PROCEDURE ACTUALIZAR_PERSONA(
        p_id_persona IN NUMBER,
        p_tipo_documento IN NVARCHAR2,
        p_cedula IN NVARCHAR2,
        p_telefono IN NVARCHAR2,
        p_correo IN NVARCHAR2,
        p_nombre IN NVARCHAR2,
        p_primer_apellido IN NVARCHAR2,
        p_segundo_apellido IN NVARCHAR2
    ) IS
        v_persona_existente NUMBER;
    BEGIN
        -- Verificar si la persona existe
        SELECT COUNT(*)
        INTO v_persona_existente
        FROM PERSONA_TB
        WHERE ID_PERSONA = p_id_persona;

        IF v_persona_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'La persona especificada no existe.');
        END IF;

        -- Actualizar los datos de la persona
        UPDATE PERSONA_TB
        SET TIPO_DOCUMENTO = p_tipo_documento,
            CEDULA = p_cedula,
            TELEFONO = p_telefono,
            CORREO = p_correo,
            NOMBRE = p_nombre,
            PRIMER_APELLIDO = p_primer_apellido,
            SEGUNDO_APELLIDO = p_segundo_apellido
        WHERE ID_PERSONA = p_id_persona;
    END ACTUALIZAR_PERSONA;

    -- Procedimiento para eliminar una persona
    PROCEDURE ELIMINAR_PERSONA(p_id_persona IN NUMBER) IS
        v_persona_existente NUMBER;
    BEGIN
        -- Verificar si la persona existe
        SELECT COUNT(*)
        INTO v_persona_existente
        FROM PERSONA_TB
        WHERE ID_PERSONA = p_id_persona;

        IF v_persona_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'La persona especificada no existe.');
        END IF;

        -- Eliminar la persona
        DELETE FROM PERSONA_TB
        WHERE ID_PERSONA = p_id_persona;
    END ELIMINAR_PERSONA;

    -- Procedimiento para listar todas las personas
    PROCEDURE OBTENER_PERSONAS IS
        CURSOR c_personas IS
            SELECT ID_PERSONA, TIPO_DOCUMENTO, CEDULA, TELEFONO, CORREO, NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO
            FROM PERSONA_TB;

        v_id_persona NUMBER;
        v_tipo_documento NVARCHAR2(100);
        v_cedula NVARCHAR2(100);
        v_telefono NVARCHAR2(100);
        v_correo NVARCHAR2(100);
        v_nombre NVARCHAR2(100);
        v_primer_apellido NVARCHAR2(100);
        v_segundo_apellido NVARCHAR2(100);
    BEGIN
        OPEN c_personas;
        LOOP
            FETCH c_personas INTO v_id_persona, v_tipo_documento, v_cedula, v_telefono, v_correo, v_nombre, v_primer_apellido, v_segundo_apellido;
            EXIT WHEN c_personas%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id_persona || ', Tipo Doc: ' || v_tipo_documento || ', C�dula: ' || v_cedula);
            DBMS_OUTPUT.PUT_LINE('Tel�fono: ' || v_telefono || ', Correo: ' || v_correo || ', Nombre: ' || v_nombre);
            DBMS_OUTPUT.PUT_LINE('Apellidos: ' || v_primer_apellido || ' ' || v_segundo_apellido);
            DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
        END LOOP;
        CLOSE c_personas;
    END OBTENER_PERSONAS;

    -- Funci�n para verificar si una persona existe
    FUNCTION EXISTE_PERSONA(p_id_persona IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM PERSONA_TB
        WHERE ID_PERSONA = p_id_persona;

        RETURN v_count > 0;
    END EXISTE_PERSONA;

END PERSONA_PKG;


---- Tabla EMPLEADO_TB

CREATE OR REPLACE PACKAGE EMPLEADO_PKG IS
    -- Procedimiento para agregar un empleado
    PROCEDURE AGREGAR_EMPLEADO(
        p_id_hotel IN NUMBER,
        p_id_persona IN NUMBER,
        p_estado IN NVARCHAR2,
        p_puesto IN NVARCHAR2,
        p_salario IN NUMBER,
        p_fecha_ingreso IN DATE
    );

    -- Procedimiento para actualizar los datos de un empleado
    PROCEDURE ACTUALIZAR_EMPLEADO(
        p_id_empleado IN NUMBER,
        p_estado IN NVARCHAR2,
        p_puesto IN NVARCHAR2,
        p_salario IN NUMBER
    );

    -- Procedimiento para eliminar un empleado
    PROCEDURE ELIMINAR_EMPLEADO(p_id_empleado IN NUMBER);

    -- Procedimiento para listar todos los empleados de un hotel
    PROCEDURE OBTENER_EMPLEADOS(p_id_hotel IN NUMBER);

    -- Funci�n para verificar si un empleado existe
    FUNCTION EXISTE_EMPLEADO(p_id_empleado IN NUMBER) RETURN BOOLEAN;
END EMPLEADO_PKG;


CREATE OR REPLACE PACKAGE BODY EMPLEADO_PKG IS

    -- Procedimiento para agregar un empleado
    PROCEDURE AGREGAR_EMPLEADO(
        p_id_hotel IN NUMBER,
        p_id_persona IN NUMBER,
        p_estado IN NVARCHAR2,
        p_puesto IN NVARCHAR2,
        p_salario IN NUMBER,
        p_fecha_ingreso IN DATE
    ) IS
        v_hotel_existente NUMBER;
        v_persona_existente NUMBER;
    BEGIN
        -- Verificar si el hotel existe
        SELECT COUNT(*)
        INTO v_hotel_existente
        FROM HOTEL_TB
        WHERE ID_HOTEL = p_id_hotel;

        IF v_hotel_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El hotel especificado no existe.');
        END IF;

        -- Verificar si la persona existe
        SELECT COUNT(*)
        INTO v_persona_existente
        FROM PERSONA_TB
        WHERE ID_PERSONA = p_id_persona;

        IF v_persona_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'La persona especificada no existe.');
        END IF;

        -- Insertar el empleado
        INSERT INTO EMPLEADO_TB (
            ID_EMPLEADO, ID_HOTEL, ID_PERSONA, ESTADO, PUESTO, SALARIO, FECHA_INGRESO
        ) VALUES (
            ID_EMPLEADO_SEQ.NEXTVAL, p_id_hotel, p_id_persona, p_estado, p_puesto, p_salario, p_fecha_ingreso
        );
    END AGREGAR_EMPLEADO;

    -- Procedimiento para actualizar los datos de un empleado
    PROCEDURE ACTUALIZAR_EMPLEADO(
        p_id_empleado IN NUMBER,
        p_estado IN NVARCHAR2,
        p_puesto IN NVARCHAR2,
        p_salario IN NUMBER
    ) IS
        v_empleado_existente NUMBER;
    BEGIN
        -- Verificar si el empleado existe
        SELECT COUNT(*)
        INTO v_empleado_existente
        FROM EMPLEADO_TB
        WHERE ID_EMPLEADO = p_id_empleado;

        IF v_empleado_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'El empleado especificado no existe.');
        END IF;

        -- Actualizar los datos del empleado
        UPDATE EMPLEADO_TB
        SET ESTADO = p_estado,
            PUESTO = p_puesto,
            SALARIO = p_salario
        WHERE ID_EMPLEADO = p_id_empleado;
    END ACTUALIZAR_EMPLEADO;

    -- Procedimiento para eliminar un empleado
    PROCEDURE ELIMINAR_EMPLEADO(p_id_empleado IN NUMBER) IS
        v_empleado_existente NUMBER;
    BEGIN
        -- Verificar si el empleado existe
        SELECT COUNT(*)
        INTO v_empleado_existente
        FROM EMPLEADO_TB
        WHERE ID_EMPLEADO = p_id_empleado;

        IF v_empleado_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'El empleado especificado no existe.');
        END IF;

        -- Eliminar el empleado
        DELETE FROM EMPLEADO_TB
        WHERE ID_EMPLEADO = p_id_empleado;
    END ELIMINAR_EMPLEADO;

    -- Procedimiento para listar todos los empleados de un hotel
    PROCEDURE OBTENER_EMPLEADOS(p_id_hotel IN NUMBER) IS
        CURSOR c_empleados IS
            SELECT E.ID_EMPLEADO, P.NOMBRE, P.PRIMER_APELLIDO, P.SEGUNDO_APELLIDO, E.PUESTO, E.SALARIO, E.FECHA_INGRESO
            FROM EMPLEADO_TB E
            INNER JOIN PERSONA_TB P ON E.ID_PERSONA = P.ID_PERSONA
            WHERE E.ID_HOTEL = p_id_hotel;

        v_id_empleado NUMBER;
        v_nombre NVARCHAR2(100);
        v_primer_apellido NVARCHAR2(100);
        v_segundo_apellido NVARCHAR2(100);
        v_puesto NVARCHAR2(150);
        v_salario NUMBER;
        v_fecha_ingreso DATE;
    BEGIN
        -- Obtener los empleados asociados al hotel
        OPEN c_empleados;
        LOOP
            FETCH c_empleados INTO v_id_empleado, v_nombre, v_primer_apellido, v_segundo_apellido, v_puesto, v_salario, v_fecha_ingreso;
            EXIT WHEN c_empleados%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID Empleado: ' || v_id_empleado || 
                                 ', Nombre: ' || v_nombre || 
                                 ', Apellidos: ' || v_primer_apellido || ' ' || v_segundo_apellido);
            DBMS_OUTPUT.PUT_LINE('Puesto: ' || v_puesto || ', Salario: ' || v_salario || ', Fecha Ingreso: ' || TO_CHAR(v_fecha_ingreso, 'YYYY-MM-DD'));
            DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
        END LOOP;
        CLOSE c_empleados;
    END OBTENER_EMPLEADOS;

    -- Funci�n para verificar si un empleado existe
    FUNCTION EXISTE_EMPLEADO(p_id_empleado IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM EMPLEADO_TB
        WHERE ID_EMPLEADO = p_id_empleado;

        RETURN v_count > 0;
    END EXISTE_EMPLEADO;

END EMPLEADO_PKG;


----- Tabla LIMPIEZA_HABITACION_TB


CREATE OR REPLACE PACKAGE LIMPIEZA_HABITACION_PKG IS
    -- Procedimiento para agregar una tarea de limpieza
    PROCEDURE AGREGAR_TAREA_LIMPIEZA(
        p_id_empleado IN NUMBER,
        p_id_habitacion IN NUMBER,
        p_estado_tarea IN NVARCHAR2,
        p_fecha IN DATE
    );

    -- Procedimiento para actualizar una tarea de limpieza
    PROCEDURE ACTUALIZAR_TAREA_LIMPIEZA(
        p_id_limpieza_habitacion IN NUMBER,
        p_estado_tarea IN NVARCHAR2
    );

    -- Procedimiento para eliminar una tarea de limpieza
    PROCEDURE ELIMINAR_TAREA_LIMPIEZA(p_id_limpieza_habitacion IN NUMBER);

    -- Procedimiento para listar todas las tareas de limpieza de una habitaci�n
    PROCEDURE OBTENER_TAREAS_HABITACION(p_id_habitacion IN NUMBER);

    -- Funci�n para verificar si una tarea de limpieza existe
    FUNCTION EXISTE_TAREA_LIMPIEZA(p_id_limpieza_habitacion IN NUMBER) RETURN BOOLEAN;
END LIMPIEZA_HABITACION_PKG;


CREATE OR REPLACE PACKAGE BODY LIMPIEZA_HABITACION_PKG IS

    -- Procedimiento para agregar una tarea de limpieza
    PROCEDURE AGREGAR_TAREA_LIMPIEZA(
        p_id_empleado IN NUMBER,
        p_id_habitacion IN NUMBER,
        p_estado_tarea IN NVARCHAR2,
        p_fecha IN DATE
    ) IS
        v_empleado_existente NUMBER;
        v_habitacion_existente NUMBER;
    BEGIN
        -- Verificar si el empleado existe
        SELECT COUNT(*)
        INTO v_empleado_existente
        FROM EMPLEADO_TB
        WHERE ID_EMPLEADO = p_id_empleado;

        IF v_empleado_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El empleado especificado no existe.');
        END IF;

        -- Verificar si la habitaci�n existe
        SELECT COUNT(*)
        INTO v_habitacion_existente
        FROM HABITACION_TB
        WHERE ID_HABITACION = p_id_habitacion;

        IF v_habitacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'La habitaci�n especificada no existe.');
        END IF;

        -- Insertar la tarea de limpieza
        INSERT INTO LIMPIEZA_HABITACION_TB (
            ID_LIMPIEZA_HABITACION, ID_EMPLEADO, ID_HABITACION, ESTADO_TAREA, FECHA
        ) VALUES (
            ID_LIMPIEZA_HABITACION_SEQ.NEXTVAL, p_id_empleado, p_id_habitacion, p_estado_tarea, p_fecha
        );
    END AGREGAR_TAREA_LIMPIEZA;

    -- Procedimiento para actualizar una tarea de limpieza
    PROCEDURE ACTUALIZAR_TAREA_LIMPIEZA(
        p_id_limpieza_habitacion IN NUMBER,
        p_estado_tarea IN NVARCHAR2
    ) IS
        v_tarea_existente NUMBER;
    BEGIN
        -- Verificar si la tarea de limpieza existe
        SELECT COUNT(*)
        INTO v_tarea_existente
        FROM LIMPIEZA_HABITACION_TB
        WHERE ID_LIMPIEZA_HABITACION = p_id_limpieza_habitacion;

        IF v_tarea_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'La tarea de limpieza especificada no existe.');
        END IF;

        -- Actualizar el estado de la tarea
        UPDATE LIMPIEZA_HABITACION_TB
        SET ESTADO_TAREA = p_estado_tarea
        WHERE ID_LIMPIEZA_HABITACION = p_id_limpieza_habitacion;
    END ACTUALIZAR_TAREA_LIMPIEZA;

    -- Procedimiento para eliminar una tarea de limpieza
    PROCEDURE ELIMINAR_TAREA_LIMPIEZA(p_id_limpieza_habitacion IN NUMBER) IS
        v_tarea_existente NUMBER;
    BEGIN
        -- Verificar si la tarea de limpieza existe
        SELECT COUNT(*)
        INTO v_tarea_existente
        FROM LIMPIEZA_HABITACION_TB
        WHERE ID_LIMPIEZA_HABITACION = p_id_limpieza_habitacion;

        IF v_tarea_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'La tarea de limpieza especificada no existe.');
        END IF;

        -- Eliminar la tarea
        DELETE FROM LIMPIEZA_HABITACION_TB
        WHERE ID_LIMPIEZA_HABITACION = p_id_limpieza_habitacion;
    END ELIMINAR_TAREA_LIMPIEZA;

    -- Procedimiento para listar todas las tareas de limpieza de una habitaci�n
    PROCEDURE OBTENER_TAREAS_HABITACION(p_id_habitacion IN NUMBER) IS
        CURSOR c_tareas IS
            SELECT L.ID_LIMPIEZA_HABITACION, E.ID_EMPLEADO, L.ESTADO_TAREA, L.FECHA
            FROM LIMPIEZA_HABITACION_TB L
            INNER JOIN EMPLEADO_TB E ON L.ID_EMPLEADO = E.ID_EMPLEADO
            WHERE L.ID_HABITACION = p_id_habitacion;

        v_id_limpieza_habitacion NUMBER;
        v_id_empleado NUMBER;
        v_estado_tarea NVARCHAR2(100);
        v_fecha DATE;
    BEGIN
        -- Obtener las tareas de limpieza asociadas a la habitaci�n
        OPEN c_tareas;
        LOOP
            FETCH c_tareas INTO v_id_limpieza_habitacion, v_id_empleado, v_estado_tarea, v_fecha;
            EXIT WHEN c_tareas%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID Tarea: ' || v_id_limpieza_habitacion || 
                                 ', ID Empleado: ' || v_id_empleado || 
                                 ', Estado: ' || v_estado_tarea || 
                                 ', Fecha: ' || TO_CHAR(v_fecha, 'YYYY-MM-DD'));
        END LOOP;
        CLOSE c_tareas;
    END OBTENER_TAREAS_HABITACION;

    -- Funci�n para verificar si una tarea de limpieza existe
    FUNCTION EXISTE_TAREA_LIMPIEZA(p_id_limpieza_habitacion IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM LIMPIEZA_HABITACION_TB
        WHERE ID_LIMPIEZA_HABITACION = p_id_limpieza_habitacion;

        RETURN v_count > 0;
    END EXISTE_TAREA_LIMPIEZA;

END LIMPIEZA_HABITACION_PKG;


---- Tabla SERVICIO_MULTIPLE_TB

CREATE OR REPLACE PACKAGE SERVICIO_MULTIPLE_PKG IS
    -- Procedimiento para agregar un servicio m�ltiple
    PROCEDURE AGREGAR_SERVICIO_MULTIPLE(
        p_id_habitacion IN NUMBER
    );

    -- Procedimiento para eliminar un servicio m�ltiple
    PROCEDURE ELIMINAR_SERVICIO_MULTIPLE(p_id_servicio_multiple IN NUMBER);

    -- Procedimiento para listar todos los servicios m�ltiples asociados a una habitaci�n
    PROCEDURE OBTENER_SERVICIOS_MULTIPLES(p_id_habitacion IN NUMBER);

    -- Funci�n para verificar si un servicio m�ltiple existe
    FUNCTION EXISTE_SERVICIO_MULTIPLE(p_id_servicio_multiple IN NUMBER) RETURN BOOLEAN;
END SERVICIO_MULTIPLE_PKG;


CREATE OR REPLACE PACKAGE BODY SERVICIO_MULTIPLE_PKG IS

    -- Procedimiento para agregar un servicio m�ltiple
    PROCEDURE AGREGAR_SERVICIO_MULTIPLE(
        p_id_habitacion IN NUMBER
    ) IS
        v_habitacion_existente NUMBER;
    BEGIN
        -- Verificar si la habitaci�n existe
        SELECT COUNT(*)
        INTO v_habitacion_existente
        FROM HABITACION_TB
        WHERE ID_HABITACION = p_id_habitacion;

        IF v_habitacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'La habitaci�n especificada no existe.');
        END IF;

        -- Insertar el servicio m�ltiple
        INSERT INTO SERVICIO_MULTIPLE_TB (
            ID_SERVICIO_MULTIPLE, ID_HABITACION
        ) VALUES (
            ID_SERVICIO_MULTIPLE_SEQ.NEXTVAL, p_id_habitacion
        );
    END AGREGAR_SERVICIO_MULTIPLE;

    -- Procedimiento para eliminar un servicio m�ltiple
    PROCEDURE ELIMINAR_SERVICIO_MULTIPLE(p_id_servicio_multiple IN NUMBER) IS
        v_servicio_existente NUMBER;
    BEGIN
        -- Verificar si el servicio m�ltiple existe
        SELECT COUNT(*)
        INTO v_servicio_existente
        FROM SERVICIO_MULTIPLE_TB
        WHERE ID_SERVICIO_MULTIPLE = p_id_servicio_multiple;

        IF v_servicio_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El servicio m�ltiple especificado no existe.');
        END IF;

        -- Eliminar el servicio m�ltiple
        DELETE FROM SERVICIO_MULTIPLE_TB
        WHERE ID_SERVICIO_MULTIPLE = p_id_servicio_multiple;
    END ELIMINAR_SERVICIO_MULTIPLE;

    -- Procedimiento para listar todos los servicios m�ltiples asociados a una habitaci�n
    PROCEDURE OBTENER_SERVICIOS_MULTIPLES(p_id_habitacion IN NUMBER) IS
        CURSOR c_servicios IS
            SELECT ID_SERVICIO_MULTIPLE, ID_HABITACION
            FROM SERVICIO_MULTIPLE_TB
            WHERE ID_HABITACION = p_id_habitacion;

        v_id_servicio_multiple NUMBER;
        v_id_habitacion NUMBER;
    BEGIN
        -- Obtener los servicios m�ltiples asociados a la habitaci�n
        OPEN c_servicios;
        LOOP
            FETCH c_servicios INTO v_id_servicio_multiple, v_id_habitacion;
            EXIT WHEN c_servicios%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID Servicio M�ltiple: ' || v_id_servicio_multiple || 
                                 ', ID Habitaci�n: ' || v_id_habitacion);
        END LOOP;
        CLOSE c_servicios;
    END OBTENER_SERVICIOS_MULTIPLES;

    -- Funci�n para verificar si un servicio m�ltiple existe
    FUNCTION EXISTE_SERVICIO_MULTIPLE(p_id_servicio_multiple IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM SERVICIO_MULTIPLE_TB
        WHERE ID_SERVICIO_MULTIPLE = p_id_servicio_multiple;

        RETURN v_count > 0;
    END EXISTE_SERVICIO_MULTIPLE;

END SERVICIO_MULTIPLE_PKG;


CREATE OR REPLACE PACKAGE CLIENTE_PKG IS
    -- Procedimiento para agregar un cliente
    PROCEDURE AGREGAR_CLIENTE(
        p_id_persona IN NUMBER
    );

    -- Procedimiento para eliminar un cliente
    PROCEDURE ELIMINAR_CLIENTE(p_id_cliente IN NUMBER);

    -- Procedimiento para listar todos los clientes
    PROCEDURE OBTENER_CLIENTES;

    -- Funci�n para verificar si un cliente existe
    FUNCTION EXISTE_CLIENTE(p_id_cliente IN NUMBER) RETURN BOOLEAN;
END CLIENTE_PKG;


CREATE OR REPLACE PACKAGE BODY CLIENTE_PKG IS

    -- Procedimiento para agregar un cliente
    PROCEDURE AGREGAR_CLIENTE(
        p_id_persona IN NUMBER
    ) IS
        v_persona_existente NUMBER;
    BEGIN
        -- Verificar si la persona existe
        SELECT COUNT(*)
        INTO v_persona_existente
        FROM PERSONA_TB
        WHERE ID_PERSONA = p_id_persona;

        IF v_persona_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'La persona especificada no existe.');
        END IF;

        -- Insertar el cliente
        INSERT INTO CLIENTE_TB (
            ID_CLIENTE, ID_PERSONA
        ) VALUES (
            ID_CLIENTE_SEQ.NEXTVAL, p_id_persona
        );
    END AGREGAR_CLIENTE;

    -- Procedimiento para eliminar un cliente
    PROCEDURE ELIMINAR_CLIENTE(p_id_cliente IN NUMBER) IS
        v_cliente_existente NUMBER;
    BEGIN
        -- Verificar si el cliente existe
        SELECT COUNT(*)
        INTO v_cliente_existente
        FROM CLIENTE_TB
        WHERE ID_CLIENTE = p_id_cliente;

        IF v_cliente_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El cliente especificado no existe.');
        END IF;

        -- Eliminar el cliente
        DELETE FROM CLIENTE_TB
        WHERE ID_CLIENTE = p_id_cliente;
    END ELIMINAR_CLIENTE;

    -- Procedimiento para listar todos los clientes
    PROCEDURE OBTENER_CLIENTES IS
        CURSOR c_clientes IS
            SELECT C.ID_CLIENTE, P.NOMBRE, P.PRIMER_APELLIDO, P.SEGUNDO_APELLIDO
            FROM CLIENTE_TB C
            INNER JOIN PERSONA_TB P ON C.ID_PERSONA = P.ID_PERSONA;

        v_id_cliente NUMBER;
        v_nombre NVARCHAR2(100);
        v_primer_apellido NVARCHAR2(100);
        v_segundo_apellido NVARCHAR2(100);
    BEGIN
        -- Obtener todos los clientes
        OPEN c_clientes;
        LOOP
            FETCH c_clientes INTO v_id_cliente, v_nombre, v_primer_apellido, v_segundo_apellido;
            EXIT WHEN c_clientes%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID Cliente: ' || v_id_cliente || 
                                 ', Nombre: ' || v_nombre || 
                                 ', Apellidos: ' || v_primer_apellido || ' ' || v_segundo_apellido);
        END LOOP;
        CLOSE c_clientes;
    END OBTENER_CLIENTES;

    -- Funci�n para verificar si un cliente existe
    FUNCTION EXISTE_CLIENTE(p_id_cliente IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM CLIENTE_TB
        WHERE ID_CLIENTE = p_id_cliente;

        RETURN v_count > 0;
    END EXISTE_CLIENTE;

END CLIENTE_PKG;


CREATE OR REPLACE PACKAGE RESERVACION_HABITACION_PKG IS
    -- Procedimiento para agregar una reservaci�n
    PROCEDURE AGREGAR_RESERVACION(
        p_id_habitacion IN NUMBER,
        p_id_cliente IN NUMBER,
        p_id_horario IN NUMBER,
        p_metodo_pago IN NVARCHAR2,
        p_descuento IN NUMBER,
        p_total_pagar IN NUMBER,
        p_fecha_entrada IN DATE,
        p_fecha_salida IN DATE
    );

    -- Procedimiento para actualizar una reservaci�n
    PROCEDURE ACTUALIZAR_RESERVACION(
        p_id_reservacion_habitacion IN NUMBER,
        p_metodo_pago IN NVARCHAR2,
        p_descuento IN NUMBER,
        p_total_pagar IN NUMBER,
        p_fecha_entrada IN DATE,
        p_fecha_salida IN DATE
    );

    -- Procedimiento para eliminar una reservaci�n
    PROCEDURE ELIMINAR_RESERVACION(p_id_reservacion_habitacion IN NUMBER);

    -- Procedimiento para listar todas las reservaciones
    PROCEDURE OBTENER_RESERVACIONES;

    -- Funci�n para verificar si una reservaci�n existe
    FUNCTION EXISTE_RESERVACION(p_id_reservacion_habitacion IN NUMBER) RETURN BOOLEAN;
END RESERVACION_HABITACION_PKG;


CREATE OR REPLACE PACKAGE BODY RESERVACION_HABITACION_PKG IS

    -- Procedimiento para agregar una reservaci�n
    PROCEDURE AGREGAR_RESERVACION(
        p_id_habitacion IN NUMBER,
        p_id_cliente IN NUMBER,
        p_id_horario IN NUMBER,
        p_metodo_pago IN NVARCHAR2,
        p_descuento IN NUMBER,
        p_total_pagar IN NUMBER,
        p_fecha_entrada IN DATE,
        p_fecha_salida IN DATE
    ) IS
        v_habitacion_existente NUMBER;
        v_cliente_existente NUMBER;
        v_horario_existente NUMBER;
    BEGIN
        -- Verificar si la habitaci�n existe
        SELECT COUNT(*)
        INTO v_habitacion_existente
        FROM HABITACION_TB
        WHERE ID_HABITACION = p_id_habitacion;

        IF v_habitacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'La habitaci�n especificada no existe.');
        END IF;

        -- Verificar si el cliente existe
        SELECT COUNT(*)
        INTO v_cliente_existente
        FROM CLIENTE_TB
        WHERE ID_CLIENTE = p_id_cliente;

        IF v_cliente_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El cliente especificado no existe.');
        END IF;

        -- Verificar si el horario existe
        SELECT COUNT(*)
        INTO v_horario_existente
        FROM HORARIO_TB
        WHERE ID_HORARIO = p_id_horario;

        IF v_horario_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'El horario especificado no existe.');
        END IF;

        -- Insertar la reservaci�n
        INSERT INTO RESERVACION_HABITACION_TB (
            ID_RESERVACION_HABITACION, ID_HABITACION, ID_CLIENTE, ID_HORARIO, 
            METODO_PAGO, DESCUENTO, TOTAL_PAGAR, FECHA_ENTREDA, FECHA_SALIDA
        ) VALUES (
            ID_RESERVACION_HABITACION_SEQ.NEXTVAL, p_id_habitacion, p_id_cliente, p_id_horario, 
            p_metodo_pago, p_descuento, p_total_pagar, p_fecha_entrada, p_fecha_salida
        );
    END AGREGAR_RESERVACION;

    -- Procedimiento para actualizar una reservaci�n
    PROCEDURE ACTUALIZAR_RESERVACION(
        p_id_reservacion_habitacion IN NUMBER,
        p_metodo_pago IN NVARCHAR2,
        p_descuento IN NUMBER,
        p_total_pagar IN NUMBER,
        p_fecha_entrada IN DATE,
        p_fecha_salida IN DATE
    ) IS
        v_reservacion_existente NUMBER;
    BEGIN
        -- Verificar si la reservaci�n existe
        SELECT COUNT(*)
        INTO v_reservacion_existente
        FROM RESERVACION_HABITACION_TB
        WHERE ID_RESERVACION_HABITACION = p_id_reservacion_habitacion;

        IF v_reservacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'La reservaci�n especificada no existe.');
        END IF;

        -- Actualizar la reservaci�n
        UPDATE RESERVACION_HABITACION_TB
        SET METODO_PAGO = p_metodo_pago,
            DESCUENTO = p_descuento,
            TOTAL_PAGAR = p_total_pagar,
            FECHA_ENTREDA = p_fecha_entrada,
            FECHA_SALIDA = p_fecha_salida
        WHERE ID_RESERVACION_HABITACION = p_id_reservacion_habitacion;
    END ACTUALIZAR_RESERVACION;

    -- Procedimiento para eliminar una reservaci�n
    PROCEDURE ELIMINAR_RESERVACION(p_id_reservacion_habitacion IN NUMBER) IS
        v_reservacion_existente NUMBER;
    BEGIN
        -- Verificar si la reservaci�n existe
        SELECT COUNT(*)
        INTO v_reservacion_existente
        FROM RESERVACION_HABITACION_TB
        WHERE ID_RESERVACION_HABITACION = p_id_reservacion_habitacion;

        IF v_reservacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20005, 'La reservaci�n especificada no existe.');
        END IF;

        -- Eliminar la reservaci�n
        DELETE FROM RESERVACION_HABITACION_TB
        WHERE ID_RESERVACION_HABITACION = p_id_reservacion_habitacion;
    END ELIMINAR_RESERVACION;

    -- Procedimiento para listar todas las reservaciones
    PROCEDURE OBTENER_RESERVACIONES IS
        CURSOR c_reservaciones IS
            SELECT R.ID_RESERVACION_HABITACION, R.ID_HABITACION, C.ID_CLIENTE, R.METODO_PAGO, 
                   R.DESCUENTO, R.TOTAL_PAGAR, R.FECHA_ENTREDA, R.FECHA_SALIDA
            FROM RESERVACION_HABITACION_TB R
            INNER JOIN CLIENTE_TB C ON R.ID_CLIENTE = C.ID_CLIENTE;

        v_id_reservacion NUMBER;
        v_id_habitacion NUMBER;
        v_id_cliente NUMBER;
        v_metodo_pago NVARCHAR2(100);
        v_descuento NUMBER;
        v_total_pagar NUMBER;
        v_fecha_entrada DATE;
        v_fecha_salida DATE;
    BEGIN
        -- Listar todas las reservaciones
        OPEN c_reservaciones;
        LOOP
            FETCH c_reservaciones INTO v_id_reservacion, v_id_habitacion, v_id_cliente, v_metodo_pago, 
                                      v_descuento, v_total_pagar, v_fecha_entrada, v_fecha_salida;
            EXIT WHEN c_reservaciones%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID Reservaci�n: ' || v_id_reservacion || 
                                 ', Habitaci�n: ' || v_id_habitacion || 
                                 ', Cliente: ' || v_id_cliente);
            DBMS_OUTPUT.PUT_LINE('M�todo Pago: ' || v_metodo_pago || 
                                 ', Descuento: ' || v_descuento || 
                                 ', Total: ' || v_total_pagar);
            DBMS_OUTPUT.PUT_LINE('Entrada: ' || TO_CHAR(v_fecha_entrada, 'YYYY-MM-DD') || 
                                 ', Salida: ' || TO_CHAR(v_fecha_salida, 'YYYY-MM-DD'));
            DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
        END LOOP;
        CLOSE c_reservaciones;
    END OBTENER_RESERVACIONES;

    -- Funci�n para verificar si una reservaci�n existe
    FUNCTION EXISTE_RESERVACION(p_id_reservacion_habitacion IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM RESERVACION_HABITACION_TB
        WHERE ID_RESERVACION_HABITACION = p_id_reservacion_habitacion;

        RETURN v_count > 0;
    END EXISTE_RESERVACION;

END RESERVACION_HABITACION_PKG;


--- Tabla RESERVACION_RESTAURANTE_TB

CREATE OR REPLACE PACKAGE RESERVACION_RESTAURANTE_PKG IS
    -- Procedimiento para agregar una reservaci�n en el restaurante
    PROCEDURE AGREGAR_RESERVACION_RESTAURANTE(
        p_id_cliente IN NUMBER,
        p_hora_entrada IN NVARCHAR2,
        p_fecha_reservacion IN DATE
    );

    -- Procedimiento para actualizar una reservaci�n en el restaurante
    PROCEDURE ACTUALIZAR_RESERVACION_RESTAURANTE(
        p_id_reservacion_restaurante IN NUMBER,
        p_hora_entrada IN NVARCHAR2,
        p_fecha_reservacion IN DATE
    );

    -- Procedimiento para eliminar una reservaci�n en el restaurante
    PROCEDURE ELIMINAR_RESERVACION_RESTAURANTE(p_id_reservacion_restaurante IN NUMBER);

    -- Procedimiento para listar todas las reservaciones en el restaurante
    PROCEDURE OBTENER_RESERVACIONES_RESTAURANTE;

    -- Funci�n para verificar si una reservaci�n existe
    FUNCTION EXISTE_RESERVACION_RESTAURANTE(p_id_reservacion_restaurante IN NUMBER) RETURN BOOLEAN;
END RESERVACION_RESTAURANTE_PKG;


CREATE OR REPLACE PACKAGE BODY RESERVACION_RESTAURANTE_PKG IS

    -- Procedimiento para agregar una reservaci�n en el restaurante
    PROCEDURE AGREGAR_RESERVACION_RESTAURANTE(
        p_id_cliente IN NUMBER,
        p_hora_entrada IN NVARCHAR2,
        p_fecha_reservacion IN DATE
    ) IS
        v_cliente_existente NUMBER;
    BEGIN
        -- Verificar si el cliente existe
        SELECT COUNT(*)
        INTO v_cliente_existente
        FROM CLIENTE_TB
        WHERE ID_CLIENTE = p_id_cliente;

        IF v_cliente_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El cliente especificado no existe.');
        END IF;

        -- Insertar la reservaci�n
        INSERT INTO RESERVACION_RESTAURANTE_TB (
            ID_RESERVACION_RESTAURANTE, ID_CLIENTE, HORA_ENTRADA, FECHA_RESRVACION
        ) VALUES (
            ID_RESERVACION_RESTAURANTE_SEQ.NEXTVAL, p_id_cliente, p_hora_entrada, p_fecha_reservacion
        );
    END AGREGAR_RESERVACION_RESTAURANTE;

    -- Procedimiento para actualizar una reservaci�n en el restaurante
    PROCEDURE ACTUALIZAR_RESERVACION_RESTAURANTE(
        p_id_reservacion_restaurante IN NUMBER,
        p_hora_entrada IN NVARCHAR2,
        p_fecha_reservacion IN DATE
    ) IS
        v_reservacion_existente NUMBER;
    BEGIN
        -- Verificar si la reservaci�n existe
        SELECT COUNT(*)
        INTO v_reservacion_existente
        FROM RESERVACION_RESTAURANTE_TB
        WHERE ID_RESERVACION_RESTAURANTE = p_id_reservacion_restaurante;

        IF v_reservacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'La reservaci�n especificada no existe.');
        END IF;

        -- Actualizar la reservaci�n
        UPDATE RESERVACION_RESTAURANTE_TB
        SET HORA_ENTRADA = p_hora_entrada,
            FECHA_RESRVACION = p_fecha_reservacion
        WHERE ID_RESERVACION_RESTAURANTE = p_id_reservacion_restaurante;
    END ACTUALIZAR_RESERVACION_RESTAURANTE;

    -- Procedimiento para eliminar una reservaci�n en el restaurante
    PROCEDURE ELIMINAR_RESERVACION_RESTAURANTE(p_id_reservacion_restaurante IN NUMBER) IS
        v_reservacion_existente NUMBER;
    BEGIN
        -- Verificar si la reservaci�n existe
        SELECT COUNT(*)
        INTO v_reservacion_existente
        FROM RESERVACION_RESTAURANTE_TB
        WHERE ID_RESERVACION_RESTAURANTE = p_id_reservacion_restaurante;

        IF v_reservacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'La reservaci�n especificada no existe.');
        END IF;

        -- Eliminar la reservaci�n
        DELETE FROM RESERVACION_RESTAURANTE_TB
        WHERE ID_RESERVACION_RESTAURANTE = p_id_reservacion_restaurante;
    END ELIMINAR_RESERVACION_RESTAURANTE;

    -- Procedimiento para listar todas las reservaciones en el restaurante
    PROCEDURE OBTENER_RESERVACIONES_RESTAURANTE IS
        CURSOR c_reservaciones IS
            SELECT R.ID_RESERVACION_RESTAURANTE, R.ID_CLIENTE, R.HORA_ENTRADA, R.FECHA_RESRVACION, 
                   P.NOMBRE, P.PRIMER_APELLIDO, P.SEGUNDO_APELLIDO
            FROM RESERVACION_RESTAURANTE_TB R
            INNER JOIN CLIENTE_TB C ON R.ID_CLIENTE = C.ID_CLIENTE
            INNER JOIN PERSONA_TB P ON C.ID_PERSONA = P.ID_PERSONA;

        v_id_reservacion NUMBER;
        v_id_cliente NUMBER;
        v_hora_entrada NVARCHAR2(50);
        v_fecha_reservacion DATE;
        v_nombre NVARCHAR2(100);
        v_primer_apellido NVARCHAR2(100);
        v_segundo_apellido NVARCHAR2(100);
    BEGIN
        -- Listar todas las reservaciones
        OPEN c_reservaciones;
        LOOP
            FETCH c_reservaciones INTO v_id_reservacion, v_id_cliente, v_hora_entrada, v_fecha_reservacion, 
                                      v_nombre, v_primer_apellido, v_segundo_apellido;
            EXIT WHEN c_reservaciones%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID Reservaci�n: ' || v_id_reservacion || 
                                 ', Cliente: ' || v_nombre || ' ' || v_primer_apellido || ' ' || v_segundo_apellido);
            DBMS_OUTPUT.PUT_LINE('Hora Entrada: ' || v_hora_entrada || 
                                 ', Fecha Reservaci�n: ' || TO_CHAR(v_fecha_reservacion, 'YYYY-MM-DD'));
            DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
        END LOOP;
        CLOSE c_reservaciones;
    END OBTENER_RESERVACIONES_RESTAURANTE;

    -- Funci�n para verificar si una reservaci�n existe
    FUNCTION EXISTE_RESERVACION_RESTAURANTE(p_id_reservacion_restaurante IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM RESERVACION_RESTAURANTE_TB
        WHERE ID_RESERVACION_RESTAURANTE = p_id_reservacion_restaurante;

        RETURN v_count > 0;
    END EXISTE_RESERVACION_RESTAURANTE;

END RESERVACION_RESTAURANTE_PKG;


--- Tabla FAC_RESTAURANTE_TB

CREATE OR REPLACE PACKAGE FAC_RESTAURANTE_PKG IS
    -- Procedimiento para agregar una factura
    PROCEDURE AGREGAR_FACTURA(
        p_id_reservacion_restaurante IN NUMBER,
        p_descuento IN NUMBER,
        p_total_pago IN NUMBER,
        p_metodo_pago IN NVARCHAR2
    );

    -- Procedimiento para actualizar una factura
    PROCEDURE ACTUALIZAR_FACTURA(
        p_id_fact_restaurante IN NUMBER,
        p_descuento IN NUMBER,
        p_total_pago IN NUMBER,
        p_metodo_pago IN NVARCHAR2
    );

    -- Procedimiento para eliminar una factura
    PROCEDURE ELIMINAR_FACTURA(p_id_fact_restaurante IN NUMBER);

    -- Procedimiento para listar todas las facturas
    PROCEDURE OBTENER_FACTURAS;

    -- Funci�n para verificar si una factura existe
    FUNCTION EXISTE_FACTURA(p_id_fact_restaurante IN NUMBER) RETURN BOOLEAN;
END FAC_RESTAURANTE_PKG;


CREATE OR REPLACE PACKAGE BODY FAC_RESTAURANTE_PKG IS

    -- Procedimiento para agregar una factura
    PROCEDURE AGREGAR_FACTURA(
        p_id_reservacion_restaurante IN NUMBER,
        p_descuento IN NUMBER,
        p_total_pago IN NUMBER,
        p_metodo_pago IN NVARCHAR2
    ) IS
        v_reservacion_existente NUMBER;
    BEGIN
        -- Verificar si la reservaci�n del restaurante existe
        SELECT COUNT(*)
        INTO v_reservacion_existente
        FROM RESERVACION_RESTAURANTE_TB
        WHERE ID_RESERVACION_RESTAURANTE = p_id_reservacion_restaurante;

        IF v_reservacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'La reservaci�n especificada no existe.');
        END IF;

        -- Insertar la factura
        INSERT INTO FAC_RESTAURANTE_TB (
            ID_FACT_RESTAURANTE, ID_RESERVACION_RESTAURANTE, DESCUENTO, TOTAL_PAGO, METODO_PAGO
        ) VALUES (
            ID_FACT_RESTAURANTE_SEQ.NEXTVAL, p_id_reservacion_restaurante, p_descuento, p_total_pago, p_metodo_pago
        );
    END AGREGAR_FACTURA;

    -- Procedimiento para actualizar una factura
    PROCEDURE ACTUALIZAR_FACTURA(
        p_id_fact_restaurante IN NUMBER,
        p_descuento IN NUMBER,
        p_total_pago IN NUMBER,
        p_metodo_pago IN NVARCHAR2
    ) IS
        v_factura_existente NUMBER;
    BEGIN
        -- Verificar si la factura existe
        SELECT COUNT(*)
        INTO v_factura_existente
        FROM FAC_RESTAURANTE_TB
        WHERE ID_FACT_RESTAURANTE = p_id_fact_restaurante;

        IF v_factura_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'La factura especificada no existe.');
        END IF;

        -- Actualizar la factura
        UPDATE FAC_RESTAURANTE_TB
        SET DESCUENTO = p_descuento,
            TOTAL_PAGO = p_total_pago,
            METODO_PAGO = p_metodo_pago
        WHERE ID_FACT_RESTAURANTE = p_id_fact_restaurante;
    END ACTUALIZAR_FACTURA;

    -- Procedimiento para eliminar una factura
    PROCEDURE ELIMINAR_FACTURA(p_id_fact_restaurante IN NUMBER) IS
        v_factura_existente NUMBER;
    BEGIN
        -- Verificar si la factura existe
        SELECT COUNT(*)
        INTO v_factura_existente
        FROM FAC_RESTAURANTE_TB
        WHERE ID_FACT_RESTAURANTE = p_id_fact_restaurante;

        IF v_factura_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'La factura especificada no existe.');
        END IF;

        -- Eliminar la factura
        DELETE FROM FAC_RESTAURANTE_TB
        WHERE ID_FACT_RESTAURANTE = p_id_fact_restaurante;
    END ELIMINAR_FACTURA;

    -- Procedimiento para listar todas las facturas
    PROCEDURE OBTENER_FACTURAS IS
        CURSOR c_facturas IS
            SELECT F.ID_FACT_RESTAURANTE, F.ID_RESERVACION_RESTAURANTE, F.DESCUENTO, F.TOTAL_PAGO, 
                   F.METODO_PAGO, R.ID_CLIENTE, P.NOMBRE, P.PRIMER_APELLIDO, P.SEGUNDO_APELLIDO
            FROM FAC_RESTAURANTE_TB F
            INNER JOIN RESERVACION_RESTAURANTE_TB R ON F.ID_RESERVACION_RESTAURANTE = R.ID_RESERVACION_RESTAURANTE
            INNER JOIN CLIENTE_TB C ON R.ID_CLIENTE = C.ID_CLIENTE
            INNER JOIN PERSONA_TB P ON C.ID_PERSONA = P.ID_PERSONA;

        v_id_factura NUMBER;
        v_id_reservacion NUMBER;
        v_descuento NUMBER;
        v_total_pago NUMBER;
        v_metodo_pago NVARCHAR2(100);
        v_id_cliente NUMBER;
        v_nombre NVARCHAR2(100);
        v_primer_apellido NVARCHAR2(100);
        v_segundo_apellido NVARCHAR2(100);
    BEGIN
        -- Listar todas las facturas
        OPEN c_facturas;
        LOOP
            FETCH c_facturas INTO v_id_factura, v_id_reservacion, v_descuento, v_total_pago, 
                                  v_metodo_pago, v_id_cliente, v_nombre, v_primer_apellido, v_segundo_apellido;
            EXIT WHEN c_facturas%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID Factura: ' || v_id_factura || 
                                 ', ID Reservaci�n: ' || v_id_reservacion || 
                                 ', Cliente: ' || v_nombre || ' ' || v_primer_apellido || ' ' || v_segundo_apellido);
            DBMS_OUTPUT.PUT_LINE('Descuento: ' || v_descuento || 
                                 ', Total Pago: ' || v_total_pago || 
                                 ', M�todo Pago: ' || v_metodo_pago);
            DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
        END LOOP;
        CLOSE c_facturas;
    END OBTENER_FACTURAS;

    -- Funci�n para verificar si una factura existe
    FUNCTION EXISTE_FACTURA(p_id_fact_restaurante IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM FAC_RESTAURANTE_TB
        WHERE ID_FACT_RESTAURANTE = p_id_fact_restaurante;

        RETURN v_count > 0;
    END EXISTE_FACTURA;

END FAC_RESTAURANTE_PKG;

-- Tabla PLATILLO_MULTIPLE_TB


CREATE OR REPLACE PACKAGE PLATILLO_MULTIPLE_PKG IS
    -- Procedimiento para agregar un platillo m�ltiple
    PROCEDURE AGREGAR_PLATILLO_MULTIPLE(
        p_id_platillo IN NUMBER,
        p_id_fact_restaurante IN NUMBER
    );

    -- Procedimiento para eliminar un platillo m�ltiple
    PROCEDURE ELIMINAR_PLATILLO_MULTIPLE(p_id_platillo_multiple IN NUMBER);

    -- Procedimiento para listar todos los platillos m�ltiples asociados a una factura
    PROCEDURE OBTENER_PLATILLOS_MULTIPLES(p_id_fact_restaurante IN NUMBER);

    -- Funci�n para verificar si un platillo m�ltiple existe
    FUNCTION EXISTE_PLATILLO_MULTIPLE(p_id_platillo_multiple IN NUMBER) RETURN BOOLEAN;
END PLATILLO_MULTIPLE_PKG;
/

CREATE OR REPLACE PACKAGE BODY PLATILLO_MULTIPLE_PKG IS

    -- Procedimiento para agregar un platillo m�ltiple
    PROCEDURE AGREGAR_PLATILLO_MULTIPLE(
        p_id_platillo IN NUMBER,
        p_id_fact_restaurante IN NUMBER
    ) IS
        v_platillo_existente NUMBER;
        v_factura_existente NUMBER;
    BEGIN
        -- Verificar si el platillo existe
        SELECT COUNT(*)
        INTO v_platillo_existente
        FROM PLATILLO_TB
        WHERE ID_PLATILLO = p_id_platillo;

        IF v_platillo_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El platillo especificado no existe.');
        END IF;

        -- Verificar si la factura existe
        SELECT COUNT(*)
        INTO v_factura_existente
        FROM FAC_RESTAURANTE_TB
        WHERE ID_FACT_RESTAURANTE = p_id_fact_restaurante;

        IF v_factura_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'La factura especificada no existe.');
        END IF;

        -- Insertar el platillo m�ltiple
        INSERT INTO PLATILLO_MULTIPLE_TB (
            ID_PLATILLO_MULTIPLE, ID_PLATILLO, ID_FACT_RESTAURANTE
        ) VALUES (
            ID_PLATILLO_MULTIPLE_SEQ.NEXTVAL, p_id_platillo, p_id_fact_restaurante
        );
    END AGREGAR_PLATILLO_MULTIPLE;

    -- Procedimiento para eliminar un platillo m�ltiple
    PROCEDURE ELIMINAR_PLATILLO_MULTIPLE(p_id_platillo_multiple IN NUMBER) IS
        v_platillo_multiple_existente NUMBER;
    BEGIN
        -- Verificar si el platillo m�ltiple existe
        SELECT COUNT(*)
        INTO v_platillo_multiple_existente
        FROM PLATILLO_MULTIPLE_TB
        WHERE ID_PLATILLO_MULTIPLE = p_id_platillo_multiple;

        IF v_platillo_multiple_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'El registro de platillo m�ltiple especificado no existe.');
        END IF;

        -- Eliminar el platillo m�ltiple
        DELETE FROM PLATILLO_MULTIPLE_TB
        WHERE ID_PLATILLO_MULTIPLE = p_id_platillo_multiple;
    END ELIMINAR_PLATILLO_MULTIPLE;

    -- Procedimiento para listar todos los platillos m�ltiples asociados a una factura
    PROCEDURE OBTENER_PLATILLOS_MULTIPLES(p_id_fact_restaurante IN NUMBER) IS
        CURSOR c_platillos IS
            SELECT PM.ID_PLATILLO_MULTIPLE, P.NOMBRE, P.PRECIO, PM.ID_FACT_RESTAURANTE
            FROM PLATILLO_MULTIPLE_TB PM
            INNER JOIN PLATILLO_TB P ON PM.ID_PLATILLO = P.ID_PLATILLO
            WHERE PM.ID_FACT_RESTAURANTE = p_id_fact_restaurante;

        v_id_platillo_multiple NUMBER;
        v_nombre NVARCHAR2(100);
        v_precio NUMBER;
        v_id_factura NUMBER;
    BEGIN
        -- Obtener los platillos asociados a la factura
        OPEN c_platillos;
        LOOP
            FETCH c_platillos INTO v_id_platillo_multiple, v_nombre, v_precio, v_id_factura;
            EXIT WHEN c_platillos%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID Platillo M�ltiple: ' || v_id_platillo_multiple || 
                                 ', Nombre: ' || v_nombre || 
                                 ', Precio: ' || v_precio || 
                                 ', ID Factura: ' || v_id_factura);
        END LOOP;
        CLOSE c_platillos;
    END OBTENER_PLATILLOS_MULTIPLES;

    -- Funci�n para verificar si un platillo m�ltiple existe
    FUNCTION EXISTE_PLATILLO_MULTIPLE(p_id_platillo_multiple IN NUMBER) RETURN BOOLEAN IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM PLATILLO_MULTIPLE_TB
        WHERE ID_PLATILLO_MULTIPLE = p_id_platillo_multiple;

        RETURN v_count > 0;
    END EXISTE_PLATILLO_MULTIPLE;

END PLATILLO_MULTIPLE_PKG;



    
    
    
    
    
