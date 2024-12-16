--Paquetes Divididos por Tablas

-- Tabla SERVICIO_TB

CREATE OR REPLACE PACKAGE SERVICIO_PKG IS
    -- Procedimiento para agregar un servicio
    PROCEDURE AGREGAR_SERVICIO(p_nombre IN NVARCHAR2);

    -- Procedimiento para actualizar un servicio
    PROCEDURE ACTUALIZAR_SERVICIO(p_id_servicio IN NUMBER, p_nombre IN NVARCHAR2);

    -- Procedimiento para eliminar un servicio
    PROCEDURE ELIMINAR_SERVICIO(p_id_servicio IN NUMBER);

    -- Procedimiento para obtener todos los servicios
    PROCEDURE OBTENER_SERVICIOS;

    -- Función para verificar si un servicio existe
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

    -- Función para verificar si un servicio existe
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
/

--Ejemplo de prueba

--Agregar

BEGIN
    SERVICIO_PKG.AGREGAR_SERVICIO('Caja');
END;
/

SELECT * FROM SERVICIO_TB;

--Actualizar

BEGIN
    SERVICIO_PKG.ACTUALIZAR_SERVICIO(1, 'Limpieza Premium');
END;
/

SELECT * FROM SERVICIO_TB;

--Verificar los servicios

BEGIN
    SERVICIO_PKG.OBTENER_SERVICIOS;
END;
/

--Ver si existe un servicio

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := SERVICIO_PKG.EXISTE_SERVICIO(4);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('El servicio existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El servicio no existe.');
    END IF;
END;
/

-- Tabla DIRECCION_TB

CREATE OR REPLACE PACKAGE DIRECCION_PKG IS
    -- Procedimiento para agregar una dirección
    PROCEDURE AGREGAR_DIRECCION(
        p_provincia IN NVARCHAR2,
        p_canton IN NVARCHAR2,
        p_distrito IN NVARCHAR2,
        p_direccion_detallada IN NVARCHAR2
    );

    -- Procedimiento para actualizar una dirección
    PROCEDURE ACTUALIZAR_DIRECCION(
        p_id_direccion IN NUMBER,
        p_provincia IN NVARCHAR2,
        p_canton IN NVARCHAR2,
        p_distrito IN NVARCHAR2,
        p_direccion_detallada IN NVARCHAR2
    );

    -- Procedimiento para eliminar una dirección
    PROCEDURE ELIMINAR_DIRECCION(p_id_direccion IN NUMBER);

    -- Procedimiento para obtener todas las direcciones
    PROCEDURE OBTENER_DIRECCIONES;

    -- Función para verificar si una dirección existe
    FUNCTION EXISTE_DIRECCION(p_id_direccion IN NUMBER) RETURN BOOLEAN;
END DIRECCION_PKG;
/

CREATE OR REPLACE PACKAGE BODY DIRECCION_PKG IS

    -- Procedimiento para agregar una dirección
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

    -- Procedimiento para actualizar una dirección
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

    -- Procedimiento para eliminar una dirección
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
                                 ', Cantón: ' || v_canton || ', Distrito: ' || v_distrito ||
                                 ', Detalle: ' || v_direccion_detallada);
        END LOOP;
        CLOSE c_direcciones;
    END OBTENER_DIRECCIONES;

    -- Función para verificar si una dirección existe
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
/

--Agregar una direccion

BEGIN
    DIRECCION_PKG.AGREGAR_DIRECCION(
        p_provincia => 'San José',
        p_canton => 'Central',
        p_distrito => 'Carmen',
        p_direccion_detallada => 'Calle 1, Avenida 2'
    );
END;
/

--Actualizar un direccion

BEGIN
    DIRECCION_PKG.ACTUALIZAR_DIRECCION(
        p_id_direccion => 2,
        p_provincia => 'Heredia',
        p_canton => 'Belén',
        p_distrito => 'San Antonio',
        p_direccion_detallada => 'Calle 5, Casa Blanca'
    );
END;
/

--Eliminar un direccion

BEGIN
    DIRECCION_PKG.ELIMINAR_DIRECCION(p_id_direccion => 2);
END;
/

--Verificar si existe

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := DIRECCION_PKG.EXISTE_DIRECCION(p_id_direccion => 2);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('La dirección existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('La dirección no existe.');
    END IF;
END;
/

SELECT * FROM DIRECCION_TB;

--Tabla HORARIO_TB

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

    -- Función para verificar si un horario existe
    FUNCTION EXISTE_HORARIO(p_id_horario IN NUMBER) RETURN BOOLEAN;
END HORARIO_PKG;
/

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

    -- Función para verificar si un horario existe
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
/

--Agregar Horario

BEGIN
    HORARIO_PKG.AGREGAR_HORARIO(
        p_fecha_horario => TO_DATE('2024-12-20', 'YYYY-MM-DD'),
        p_hora_apertura => '08:00 AM',
        p_hora_cierre => '05:00 PM'
    );
END;
/

--Actualizar Horario

BEGIN
    HORARIO_PKG.ACTUALIZAR_HORARIO(
        p_id_horario => 1,
        p_fecha_horario => TO_DATE('2024-12-21', 'YYYY-MM-DD'),
        p_hora_apertura => '09:00 AM',
        p_hora_cierre => '06:00 PM'
    );
END;
/

--Eliminar Horario

BEGIN
    HORARIO_PKG.ELIMINAR_HORARIO(p_id_horario => 2);
END;
/

--Obtener Todos los horarios

BEGIN
    HORARIO_PKG.OBTENER_HORARIOS;
END;
/

--Verificar si un horario existe

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := HORARIO_PKG.EXISTE_HORARIO(p_id_horario => 2);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('El horario existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El horario no existe.');
    END IF;
END;
/

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

    -- Función para verificar si un hotel existe
    FUNCTION EXISTE_HOTEL(p_id_hotel IN NUMBER) RETURN BOOLEAN;
END HOTEL_PKG;
/

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
            DBMS_OUTPUT.PUT_LINE('Teléfono: ' || v_telefono || ', Correo: ' || v_correo);
            DBMS_OUTPUT.PUT_LINE('Dirección: ' || v_provincia || ', ' || v_canton || ', ' || v_distrito || ', ' || v_direccion_detallada);
            DBMS_OUTPUT.PUT_LINE('Horario: Fecha: ' || TO_CHAR(v_fecha_horario, 'YYYY-MM-DD') || 
                                 ', Apertura: ' || v_hora_apertura || 
                                 ', Cierre: ' || v_hora_cierre);
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
        END LOOP;
        CLOSE c_hoteles;
    END OBTENER_HOTELES;

    -- Función para verificar si un hotel existe
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
/

--Agregar un hotel

BEGIN
    HOTEL_PKG.AGREGAR_HOTEL(
        p_id_direccion => 3,
        p_id_horario => 2,
        p_nombre => 'Hotel Riu',
        p_telefono => '123456789',
        p_correo => 'info@hotelriu.com'
    );
END;
/

--Actualizar un hotel

BEGIN
    HOTEL_PKG.ACTUALIZAR_HOTEL(
        p_id_hotel => 1,
        p_id_direccion => 3,
        p_id_horario => 2,
        p_nombre => 'Hotel Riu Palace',
        p_telefono => '987654321',
        p_correo => 'contact@hotelriu.com'
    );
END;
/

--Eliminar un hotel

BEGIN
    HOTEL_PKG.ELIMINAR_HOTEL(p_id_hotel => 1);
END;
/

--Obeter todos los hoteles

BEGIN
    HOTEL_PKG.OBTENER_HOTELES;
END;
/

--Verificar todos los hoteles

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := HOTEL_PKG.EXISTE_HOTEL(p_id_hotel => 8);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('El hotel existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El hotel no existe.');
    END IF;
END;
/



--Tabla SERVICIO_HOTEL_TAB



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

    -- Función para verificar si un servicio existe
    FUNCTION EXISTE_SERVICIO_HOTEL(p_id_servicio_hotel IN NUMBER) RETURN BOOLEAN;
END SERVICIO_HOTEL_PKG;
/

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

        -- Si todo es válido, realizar el INSERT en SERVICIO_HOTEL_TAB
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

    -- Función para verificar si un servicio existe
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
/

--Agregar un servicio a un hotel

BEGIN
    SERVICIO_HOTEL_PKG.AGREGAR_SERVICIO_HOTEL(
        p_id_hotel => 8,
        p_nombre => 'Servicio de Spa',
        p_estado => 'Activo'
    );
END;
/

--Actualizar

BEGIN
    SERVICIO_HOTEL_PKG.ACTUALIZAR_SERVICIO_HOTEL(
        p_id_servicio_hotel => 1,
        p_nombre => 'Servicio de Spa Deluxe',
        p_estado => 'Activo'
    );
END;
/

--Eliminar

BEGIN
    SERVICIO_HOTEL_PKG.ELIMINAR_SERVICIO_HOTEL(p_id_servicio_hotel => 1);
END;
/

--Obtener 

BEGIN
    SERVICIO_HOTEL_PKG.OBTENER_SERVICIOS_HOTEL(p_id_hotel => 1);
END;
/

--Verificar si existe

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := SERVICIO_HOTEL_PKG.EXISTE_SERVICIO_HOTEL(p_id_servicio_hotel => 2);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('El servicio existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El servicio no existe.');
    END IF;
END;
/

--- Tabla RESTAURANTE_TB

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

    -- Función para verificar si un restaurante existe
    FUNCTION EXISTE_RESTAURANTE(p_id_restaurante IN NUMBER) RETURN BOOLEAN;
END RESTAURANTE_PKG;
/

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

    -- Función para verificar si un restaurante existe
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

/

--Agregar

BEGIN
    RESTAURANTE_PKG.AGREGAR_RESTAURANTE(
        p_id_hotel => 8,
        p_nombre => 'Restaurante Mediterráneo'
    );
END;
/

--Actulalizar

BEGIN
    RESTAURANTE_PKG.ACTUALIZAR_RESTAURANTE(
        p_id_restaurante => 1,
        p_nombre => 'Restaurante Mediterráneo Deluxe'
    );
END;
/

--Eliminar

BEGIN
    RESTAURANTE_PKG.ELIMINAR_RESTAURANTE(p_id_restaurante => 1);
END;
/

--Obtener

BEGIN
    RESTAURANTE_PKG.OBTENER_RESTAURANTES(p_id_hotel => 8);
END;
/

--Verificar

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := RESTAURANTE_PKG.EXISTE_RESTAURANTE(p_id_restaurante => 22);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('El restaurante existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El restaurante no existe.');
    END IF;
END;
/

SELECT * FROM restaurante_tb;



---- Tabla PLATILLO_TB



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

    -- Función para verificar si un platillo existe
    FUNCTION EXISTE_PLATILLO(p_id_platillo IN NUMBER) RETURN BOOLEAN;
END PLATILLO_PKG;
/

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

    -- Función para verificar si un platillo existe
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
/

--Agregar 

BEGIN
    PLATILLO_PKG.AGREGAR_PLATILLO(
        p_id_restaurante => 22,
        p_nombre => 'Pizza Margarita',
        p_precio => 12.99,
        p_cantidad => 20
    );
END;
/

--Actualizar

BEGIN
    PLATILLO_PKG.ACTUALIZAR_PLATILLO(
        p_id_platillo => 1,
        p_nombre => 'Pizza Margarita Deluxe',
        p_precio => 15.99,
        p_cantidad => 15
    );
END;
/

--Eliminar

BEGIN
    PLATILLO_PKG.ELIMINAR_PLATILLO(p_id_platillo => 1);
END;
/

--Obtener

BEGIN
    PLATILLO_PKG.OBTENER_PLATILLOS(p_id_restaurante => 22);
END;
/

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := PLATILLO_PKG.EXISTE_PLATILLO(p_id_platillo => 2);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('El platillo existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El platillo no existe.');
    END IF;
END;
/

SELECT * FROM platillo_tb;

---- Tabla HABITACION_TB

CREATE OR REPLACE PACKAGE HABITACION_PKG IS
    -- Procedimiento para agregar una habitación
    PROCEDURE AGREGAR_HABITACION(
        p_id_hotel IN NUMBER,
        p_numero_habitacion IN NUMBER,
        p_precio IN NUMBER,
        p_descripcion IN NVARCHAR2,
        p_estado_limpieza IN NVARCHAR2,
        p_capacidad IN NUMBER
    );

    -- Procedimiento para actualizar una habitación
    PROCEDURE ACTUALIZAR_HABITACION(
        p_id_habitacion IN NUMBER,
        p_numero_habitacion IN NUMBER,
        p_precio IN NUMBER,
        p_descripcion IN NVARCHAR2,
        p_estado_limpieza IN NVARCHAR2,
        p_capacidad IN NUMBER
    );

    -- Procedimiento para eliminar una habitación
    PROCEDURE ELIMINAR_HABITACION(p_id_habitacion IN NUMBER);

    -- Procedimiento para obtener todas las habitaciones de un hotel
    PROCEDURE OBTENER_HABITACIONES(p_id_hotel IN NUMBER);

    -- Función para verificar si una habitación existe
    FUNCTION EXISTE_HABITACION(p_id_habitacion IN NUMBER) RETURN BOOLEAN;
END HABITACION_PKG;
/

CREATE OR REPLACE PACKAGE BODY HABITACION_PKG IS

    -- Procedimiento para agregar una habitación
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

        -- Insertar la habitación
        INSERT INTO HABITACION_TB (
            ID_HABITACION, ID_HOTEL, NUMERO_HABITACION, PRECIO, DESCRIPCION, ESTADO_LIMPIEZA, CAPACIDAD
        ) VALUES (
            ID_HABITACION_SEQ.NEXTVAL, p_id_hotel, p_numero_habitacion, p_precio, p_descripcion, p_estado_limpieza, p_capacidad
        );
    END AGREGAR_HABITACION;

    -- Procedimiento para actualizar una habitación
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
        -- Verificar si la habitación existe
        SELECT COUNT(*)
        INTO v_habitacion_existente
        FROM HABITACION_TB
        WHERE ID_HABITACION = p_id_habitacion;

        IF v_habitacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'La habitación especificada no existe.');
        END IF;

        -- Actualizar la habitación
        UPDATE HABITACION_TB
        SET NUMERO_HABITACION = p_numero_habitacion,
            PRECIO = p_precio,
            DESCRIPCION = p_descripcion,
            ESTADO_LIMPIEZA = p_estado_limpieza,
            CAPACIDAD = p_capacidad
        WHERE ID_HABITACION = p_id_habitacion;
    END ACTUALIZAR_HABITACION;

    -- Procedimiento para eliminar una habitación
    PROCEDURE ELIMINAR_HABITACION(p_id_habitacion IN NUMBER) IS
        v_habitacion_existente NUMBER;
    BEGIN
        -- Verificar si la habitación existe
        SELECT COUNT(*)
        INTO v_habitacion_existente
        FROM HABITACION_TB
        WHERE ID_HABITACION = p_id_habitacion;

        IF v_habitacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'La habitación especificada no existe.');
        END IF;

        -- Eliminar la habitación
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

            DBMS_OUTPUT.PUT_LINE('ID Habitación: ' || v_id_habitacion || 
                                 ', Número: ' || v_numero_habitacion || 
                                 ', Precio: ' || v_precio || 
                                 ', Descripción: ' || v_descripcion || 
                                 ', Estado de Limpieza: ' || v_estado_limpieza || 
                                 ', Capacidad: ' || v_capacidad);
        END LOOP;
        CLOSE c_habitaciones;
    END OBTENER_HABITACIONES;

    -- Función para verificar si una habitación existe
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
/

--Agregar

BEGIN
    HABITACION_PKG.AGREGAR_HABITACION(
        p_id_hotel => 8,
        p_numero_habitacion => 101,
        p_precio => 100.00,
        p_descripcion => 'Habitación sencilla con vista al mar',
        p_estado_limpieza => 'Limpia',
        p_capacidad => 2
    );
END;
/

--Actualizar

BEGIN
    HABITACION_PKG.ACTUALIZAR_HABITACION(
        p_id_habitacion => 1,
        p_numero_habitacion => 102,
        p_precio => 150.00,
        p_descripcion => 'Habitación doble con vista al mar',
        p_estado_limpieza => 'En limpieza',
        p_capacidad => 4
    );
END;
/

--Eliminar

BEGIN
    HABITACION_PKG.ELIMINAR_HABITACION(p_id_habitacion => 1);
END;
/

--Obtener 

BEGIN
    HABITACION_PKG.OBTENER_HABITACIONES(p_id_hotel => 8);
END;
/

--Verificar

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := HABITACION_PKG.EXISTE_HABITACION(p_id_habitacion => 2);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('La habitación existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('La habitación no existe.');
    END IF;
END;
/

select * from habitacion_tb;


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

    -- Función para verificar si una persona existe
    FUNCTION EXISTE_PERSONA(p_id_persona IN NUMBER) RETURN BOOLEAN;
END PERSONA_PKG;
/

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

            DBMS_OUTPUT.PUT_LINE('ID: ' || v_id_persona || ', Tipo Doc: ' || v_tipo_documento || ', Cédula: ' || v_cedula);
            DBMS_OUTPUT.PUT_LINE('Teléfono: ' || v_telefono || ', Correo: ' || v_correo || ', Nombre: ' || v_nombre);
            DBMS_OUTPUT.PUT_LINE('Apellidos: ' || v_primer_apellido || ' ' || v_segundo_apellido);
            DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
        END LOOP;
        CLOSE c_personas;
    END OBTENER_PERSONAS;

    -- Función para verificar si una persona existe
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
/

--Agregar

BEGIN
    PERSONA_PKG.AGREGAR_PERSONA(
        p_tipo_documento => 'Cédula Nacional',
        p_cedula => '123456789',
        p_telefono => '1234567890',
        p_correo => 'persona@correo.com',
        p_nombre => 'Juan',
        p_primer_apellido => 'Pérez',
        p_segundo_apellido => 'García'
    );
END;
/

--Actualizar

BEGIN
    PERSONA_PKG.ACTUALIZAR_PERSONA(
        p_id_persona => 1,
        p_tipo_documento => 'Cédula Nacional',
        p_cedula => '987654321',
        p_telefono => '0987654321',
        p_correo => 'juan.perez@correo.com',
        p_nombre => 'Juan Carlos',
        p_primer_apellido => 'Pérez',
        p_segundo_apellido => 'García'
    );
END;
/

--Eliminar

BEGIN
    PERSONA_PKG.ELIMINAR_PERSONA(p_id_persona => 1);
END;
/

--Obtener

BEGIN
    PERSONA_PKG.OBTENER_PERSONAS;
END;
/

--Verificar

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := PERSONA_PKG.EXISTE_PERSONA(p_id_persona => 22);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('La persona existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('La persona no existe.');
    END IF;
END;
/

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

    -- Función para verificar si un empleado existe
    FUNCTION EXISTE_EMPLEADO(p_id_empleado IN NUMBER) RETURN BOOLEAN;
END EMPLEADO_PKG;
/

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

    -- Función para verificar si un empleado existe
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
/

--Agregar

BEGIN
    EMPLEADO_PKG.AGREGAR_EMPLEADO(
        p_id_hotel => 8,
        p_id_persona => 1,
        p_estado => 'Activo',
        p_puesto => 'Recepcionista',
        p_salario => 800.00,
        p_fecha_ingreso => SYSDATE
    );
END;
/

--Actualizar

BEGIN
    EMPLEADO_PKG.ACTUALIZAR_EMPLEADO(
        p_id_empleado => 1,
        p_estado => 'Inactivo',
        p_puesto => 'Administrador',
        p_salario => 1200.00
    );
END;
/

--Eliminar

BEGIN
    EMPLEADO_PKG.ELIMINAR_EMPLEADO(p_id_empleado => 1);
END;
/

--Obtener por ID hotel

BEGIN
    EMPLEADO_PKG.OBTENER_EMPLEADOS(p_id_hotel => 8);
END;
/

--Verificar

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := EMPLEADO_PKG.EXISTE_EMPLEADO(p_id_empleado => 2);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('El empleado existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El empleado no existe.');
    END IF;
END;
/

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

    -- Procedimiento para listar todas las tareas de limpieza de una habitación
    PROCEDURE OBTENER_TAREAS_HABITACION(p_id_habitacion IN NUMBER);

    -- Función para verificar si una tarea de limpieza existe
    FUNCTION EXISTE_TAREA_LIMPIEZA(p_id_limpieza_habitacion IN NUMBER) RETURN BOOLEAN;
END LIMPIEZA_HABITACION_PKG;
/

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

        -- Verificar si la habitación existe
        SELECT COUNT(*)
        INTO v_habitacion_existente
        FROM HABITACION_TB
        WHERE ID_HABITACION = p_id_habitacion;

        IF v_habitacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'La habitación especificada no existe.');
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

    -- Procedimiento para listar todas las tareas de limpieza de una habitación
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
        -- Obtener las tareas de limpieza asociadas a la habitación
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

    -- Función para verificar si una tarea de limpieza existe
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
/

--Agregar

BEGIN
    LIMPIEZA_HABITACION_PKG.AGREGAR_TAREA_LIMPIEZA(
        p_id_empleado => 2,
        p_id_habitacion => 2,
        p_estado_tarea => 'Pendiente',
        p_fecha => SYSDATE
    );
END;
/

--Actualizar

BEGIN
    LIMPIEZA_HABITACION_PKG.ACTUALIZAR_TAREA_LIMPIEZA(
        p_id_limpieza_habitacion => 1,
        p_estado_tarea => 'Completada'
    );
END;
/

--Eliminar

BEGIN
    LIMPIEZA_HABITACION_PKG.ELIMINAR_TAREA_LIMPIEZA(p_id_limpieza_habitacion => 1);
END;
/

--Obtener

BEGIN
    LIMPIEZA_HABITACION_PKG.OBTENER_TAREAS_HABITACION(p_id_habitacion => 2);
END;
/

--Verificar

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := LIMPIEZA_HABITACION_PKG.EXISTE_TAREA_LIMPIEZA(p_id_limpieza_habitacion => 2);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('La tarea de limpieza existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('La tarea de limpieza no existe.');
    END IF;
END;
/

---- Tabla SERVICIO_MULTIPLE_TB

CREATE OR REPLACE PACKAGE SERVICIO_MULTIPLE_PKG IS
    -- Procedimiento para agregar un servicio múltiple
    PROCEDURE AGREGAR_SERVICIO_MULTIPLE(
        p_id_habitacion IN NUMBER
    );

    -- Procedimiento para eliminar un servicio múltiple
    PROCEDURE ELIMINAR_SERVICIO_MULTIPLE(p_id_servicio_multiple IN NUMBER);

    -- Procedimiento para listar todos los servicios múltiples asociados a una habitación
    PROCEDURE OBTENER_SERVICIOS_MULTIPLES(p_id_habitacion IN NUMBER);

    -- Función para verificar si un servicio múltiple existe
    FUNCTION EXISTE_SERVICIO_MULTIPLE(p_id_servicio_multiple IN NUMBER) RETURN BOOLEAN;
END SERVICIO_MULTIPLE_PKG;
/

CREATE OR REPLACE PACKAGE BODY SERVICIO_MULTIPLE_PKG IS

    -- Procedimiento para agregar un servicio múltiple
    PROCEDURE AGREGAR_SERVICIO_MULTIPLE(
        p_id_habitacion IN NUMBER
    ) IS
        v_habitacion_existente NUMBER;
    BEGIN
        -- Verificar si la habitación existe
        SELECT COUNT(*)
        INTO v_habitacion_existente
        FROM HABITACION_TB
        WHERE ID_HABITACION = p_id_habitacion;

        IF v_habitacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'La habitación especificada no existe.');
        END IF;

        -- Insertar el servicio múltiple
        INSERT INTO SERVICIO_MULTIPLE_TB (
            ID_SERVICIO_MULTIPLE, ID_HABITACION
        ) VALUES (
            ID_SERVICIO_MULTIPLE_SEQ.NEXTVAL, p_id_habitacion
        );
    END AGREGAR_SERVICIO_MULTIPLE;

    -- Procedimiento para eliminar un servicio múltiple
    PROCEDURE ELIMINAR_SERVICIO_MULTIPLE(p_id_servicio_multiple IN NUMBER) IS
        v_servicio_existente NUMBER;
    BEGIN
        -- Verificar si el servicio múltiple existe
        SELECT COUNT(*)
        INTO v_servicio_existente
        FROM SERVICIO_MULTIPLE_TB
        WHERE ID_SERVICIO_MULTIPLE = p_id_servicio_multiple;

        IF v_servicio_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El servicio múltiple especificado no existe.');
        END IF;

        -- Eliminar el servicio múltiple
        DELETE FROM SERVICIO_MULTIPLE_TB
        WHERE ID_SERVICIO_MULTIPLE = p_id_servicio_multiple;
    END ELIMINAR_SERVICIO_MULTIPLE;

    -- Procedimiento para listar todos los servicios múltiples asociados a una habitación
    PROCEDURE OBTENER_SERVICIOS_MULTIPLES(p_id_habitacion IN NUMBER) IS
        CURSOR c_servicios IS
            SELECT ID_SERVICIO_MULTIPLE, ID_HABITACION
            FROM SERVICIO_MULTIPLE_TB
            WHERE ID_HABITACION = p_id_habitacion;

        v_id_servicio_multiple NUMBER;
        v_id_habitacion NUMBER;
    BEGIN
        -- Obtener los servicios múltiples asociados a la habitación
        OPEN c_servicios;
        LOOP
            FETCH c_servicios INTO v_id_servicio_multiple, v_id_habitacion;
            EXIT WHEN c_servicios%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('ID Servicio Múltiple: ' || v_id_servicio_multiple || 
                                 ', ID Habitación: ' || v_id_habitacion);
        END LOOP;
        CLOSE c_servicios;
    END OBTENER_SERVICIOS_MULTIPLES;

    -- Función para verificar si un servicio múltiple existe
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
/

--Agregar

BEGIN
    SERVICIO_MULTIPLE_PKG.AGREGAR_SERVICIO_MULTIPLE(
        p_id_habitacion => 2
    );
END;
/

--Eliminar

BEGIN
    SERVICIO_MULTIPLE_PKG.ELIMINAR_SERVICIO_MULTIPLE(p_id_servicio_multiple => 1);
END;
/

--Obtener 

BEGIN
    SERVICIO_MULTIPLE_PKG.OBTENER_SERVICIOS_MULTIPLES(p_id_habitacion => 2);
END;
/

--Verificar

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := SERVICIO_MULTIPLE_PKG.EXISTE_SERVICIO_MULTIPLE(p_id_servicio_multiple => 2);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('El servicio múltiple existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El servicio múltiple no existe.');
    END IF;
END;
/

--- Tabla CLIENTE_TB

CREATE OR REPLACE PACKAGE CLIENTE_PKG IS
    -- Procedimiento para agregar un cliente
    PROCEDURE AGREGAR_CLIENTE(
        p_id_persona IN NUMBER
    );

    -- Procedimiento para eliminar un cliente
    PROCEDURE ELIMINAR_CLIENTE(p_id_cliente IN NUMBER);

    -- Procedimiento para listar todos los clientes
    PROCEDURE OBTENER_CLIENTES;

    -- Función para verificar si un cliente existe
    FUNCTION EXISTE_CLIENTE(p_id_cliente IN NUMBER) RETURN BOOLEAN;
END CLIENTE_PKG;
/

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

    -- Función para verificar si un cliente existe
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
/

--Agregar

BEGIN
    CLIENTE_PKG.AGREGAR_CLIENTE(
        p_id_persona => 22
    );
END;
/

--Eliminar

BEGIN
    CLIENTE_PKG.ELIMINAR_CLIENTE(p_id_cliente => 1);
END;
/

--Obtener 

BEGIN
    CLIENTE_PKG.OBTENER_CLIENTES;
END;
/

--Verificar

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := CLIENTE_PKG.EXISTE_CLIENTE(p_id_cliente => 2);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('El cliente existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El cliente no existe.');
    END IF;
END;
/

--- Tabla RESERVACION_HABITACION_TB

CREATE OR REPLACE PACKAGE RESERVACION_HABITACION_PKG IS
    -- Procedimiento para agregar una reservación
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

    -- Procedimiento para actualizar una reservación
    PROCEDURE ACTUALIZAR_RESERVACION(
        p_id_reservacion_habitacion IN NUMBER,
        p_metodo_pago IN NVARCHAR2,
        p_descuento IN NUMBER,
        p_total_pagar IN NUMBER,
        p_fecha_entrada IN DATE,
        p_fecha_salida IN DATE
    );

    -- Procedimiento para eliminar una reservación
    PROCEDURE ELIMINAR_RESERVACION(p_id_reservacion_habitacion IN NUMBER);

    -- Procedimiento para listar todas las reservaciones
    PROCEDURE OBTENER_RESERVACIONES;

    -- Función para verificar si una reservación existe
    FUNCTION EXISTE_RESERVACION(p_id_reservacion_habitacion IN NUMBER) RETURN BOOLEAN;
END RESERVACION_HABITACION_PKG;
/

CREATE OR REPLACE PACKAGE BODY RESERVACION_HABITACION_PKG IS

    -- Procedimiento para agregar una reservación
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
        -- Verificar si la habitación existe
        SELECT COUNT(*)
        INTO v_habitacion_existente
        FROM HABITACION_TB
        WHERE ID_HABITACION = p_id_habitacion;

        IF v_habitacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'La habitación especificada no existe.');
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

        -- Insertar la reservación
        INSERT INTO RESERVACION_HABITACION_TB (
            ID_RESERVACION_HABITACION, ID_HABITACION, ID_CLIENTE, ID_HORARIO, 
            METODO_PAGO, DESCUENTO, TOTAL_PAGAR, FECHA_ENTREDA, FECHA_SALIDA
        ) VALUES (
            ID_RESERVACION_HABITACION_SEQ.NEXTVAL, p_id_habitacion, p_id_cliente, p_id_horario, 
            p_metodo_pago, p_descuento, p_total_pagar, p_fecha_entrada, p_fecha_salida
        );
    END AGREGAR_RESERVACION;

    -- Procedimiento para actualizar una reservación
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
        -- Verificar si la reservación existe
        SELECT COUNT(*)
        INTO v_reservacion_existente
        FROM RESERVACION_HABITACION_TB
        WHERE ID_RESERVACION_HABITACION = p_id_reservacion_habitacion;

        IF v_reservacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'La reservación especificada no existe.');
        END IF;

        -- Actualizar la reservación
        UPDATE RESERVACION_HABITACION_TB
        SET METODO_PAGO = p_metodo_pago,
            DESCUENTO = p_descuento,
            TOTAL_PAGAR = p_total_pagar,
            FECHA_ENTREDA = p_fecha_entrada,
            FECHA_SALIDA = p_fecha_salida
        WHERE ID_RESERVACION_HABITACION = p_id_reservacion_habitacion;
    END ACTUALIZAR_RESERVACION;

    -- Procedimiento para eliminar una reservación
    PROCEDURE ELIMINAR_RESERVACION(p_id_reservacion_habitacion IN NUMBER) IS
        v_reservacion_existente NUMBER;
    BEGIN
        -- Verificar si la reservación existe
        SELECT COUNT(*)
        INTO v_reservacion_existente
        FROM RESERVACION_HABITACION_TB
        WHERE ID_RESERVACION_HABITACION = p_id_reservacion_habitacion;

        IF v_reservacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20005, 'La reservación especificada no existe.');
        END IF;

        -- Eliminar la reservación
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

            DBMS_OUTPUT.PUT_LINE('ID Reservación: ' || v_id_reservacion || 
                                 ', Habitación: ' || v_id_habitacion || 
                                 ', Cliente: ' || v_id_cliente);
            DBMS_OUTPUT.PUT_LINE('Método Pago: ' || v_metodo_pago || 
                                 ', Descuento: ' || v_descuento || 
                                 ', Total: ' || v_total_pagar);
            DBMS_OUTPUT.PUT_LINE('Entrada: ' || TO_CHAR(v_fecha_entrada, 'YYYY-MM-DD') || 
                                 ', Salida: ' || TO_CHAR(v_fecha_salida, 'YYYY-MM-DD'));
            DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
        END LOOP;
        CLOSE c_reservaciones;
    END OBTENER_RESERVACIONES;

    -- Función para verificar si una reservación existe
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
/

--Agregar

BEGIN
    RESERVACION_HABITACION_PKG.AGREGAR_RESERVACION(
        p_id_habitacion => 2,
        p_id_cliente => 2,
        p_id_horario => 2,
        p_metodo_pago => 'Tarjeta',
        p_descuento => 10.00,
        p_total_pagar => 500.00,
        p_fecha_entrada => TO_DATE('2024-12-20', 'YYYY-MM-DD'),
        p_fecha_salida => TO_DATE('2024-12-25', 'YYYY-MM-DD')
    );
END;
/

--Actualizar

BEGIN
    RESERVACION_HABITACION_PKG.ACTUALIZAR_RESERVACION(
        p_id_reservacion_habitacion => 1,
        p_metodo_pago => 'Efectivo',
        p_descuento => 15.00,
        p_total_pagar => 450.00,
        p_fecha_entrada => TO_DATE('2024-12-21', 'YYYY-MM-DD'),
        p_fecha_salida => TO_DATE('2024-12-26', 'YYYY-MM-DD')
    );
END;
/

--Eliminar

BEGIN
    RESERVACION_HABITACION_PKG.ELIMINAR_RESERVACION(p_id_reservacion_habitacion => 1);
END;
/

--Obtener

BEGIN
    RESERVACION_HABITACION_PKG.OBTENER_RESERVACIONES;
END;
/

--Verificar

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := RESERVACION_HABITACION_PKG.EXISTE_RESERVACION(p_id_reservacion_habitacion => 2);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('La reservación existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('La reservación no existe.');
    END IF;
END;
/

--- Tabla RESERVACION_RESTAURANTE_TB

CREATE OR REPLACE PACKAGE RESERVACION_RESTAURANTE_PKG IS
    -- Procedimiento para agregar una reservación en el restaurante
    PROCEDURE AGREGAR_RESERVACION_RESTAURANTE(
        p_id_cliente IN NUMBER,
        p_hora_entrada IN NVARCHAR2,
        p_fecha_reservacion IN DATE
    );

    -- Procedimiento para actualizar una reservación en el restaurante
    PROCEDURE ACTUALIZAR_RESERVACION_RESTAURANTE(
        p_id_reservacion_restaurante IN NUMBER,
        p_hora_entrada IN NVARCHAR2,
        p_fecha_reservacion IN DATE
    );

    -- Procedimiento para eliminar una reservación en el restaurante
    PROCEDURE ELIMINAR_RESERVACION_RESTAURANTE(p_id_reservacion_restaurante IN NUMBER);

    -- Procedimiento para listar todas las reservaciones en el restaurante
    PROCEDURE OBTENER_RESERVACIONES_RESTAURANTE;

    -- Función para verificar si una reservación existe
    FUNCTION EXISTE_RESERVACION_RESTAURANTE(p_id_reservacion_restaurante IN NUMBER) RETURN BOOLEAN;
END RESERVACION_RESTAURANTE_PKG;
/

CREATE OR REPLACE PACKAGE BODY RESERVACION_RESTAURANTE_PKG IS

    -- Procedimiento para agregar una reservación en el restaurante
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

        -- Insertar la reservación
        INSERT INTO RESERVACION_RESTAURANTE_TB (
            ID_RESERVACION_RESTAURANTE, ID_CLIENTE, HORA_ENTRADA, FECHA_RESRVACION
        ) VALUES (
            ID_RESERVACION_RESTAURANTE_SEQ.NEXTVAL, p_id_cliente, p_hora_entrada, p_fecha_reservacion
        );
    END AGREGAR_RESERVACION_RESTAURANTE;

    -- Procedimiento para actualizar una reservación en el restaurante
    PROCEDURE ACTUALIZAR_RESERVACION_RESTAURANTE(
        p_id_reservacion_restaurante IN NUMBER,
        p_hora_entrada IN NVARCHAR2,
        p_fecha_reservacion IN DATE
    ) IS
        v_reservacion_existente NUMBER;
    BEGIN
        -- Verificar si la reservación existe
        SELECT COUNT(*)
        INTO v_reservacion_existente
        FROM RESERVACION_RESTAURANTE_TB
        WHERE ID_RESERVACION_RESTAURANTE = p_id_reservacion_restaurante;

        IF v_reservacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'La reservación especificada no existe.');
        END IF;

        -- Actualizar la reservación
        UPDATE RESERVACION_RESTAURANTE_TB
        SET HORA_ENTRADA = p_hora_entrada,
            FECHA_RESRVACION = p_fecha_reservacion
        WHERE ID_RESERVACION_RESTAURANTE = p_id_reservacion_restaurante;
    END ACTUALIZAR_RESERVACION_RESTAURANTE;

    -- Procedimiento para eliminar una reservación en el restaurante
    PROCEDURE ELIMINAR_RESERVACION_RESTAURANTE(p_id_reservacion_restaurante IN NUMBER) IS
        v_reservacion_existente NUMBER;
    BEGIN
        -- Verificar si la reservación existe
        SELECT COUNT(*)
        INTO v_reservacion_existente
        FROM RESERVACION_RESTAURANTE_TB
        WHERE ID_RESERVACION_RESTAURANTE = p_id_reservacion_restaurante;

        IF v_reservacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'La reservación especificada no existe.');
        END IF;

        -- Eliminar la reservación
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

            DBMS_OUTPUT.PUT_LINE('ID Reservación: ' || v_id_reservacion || 
                                 ', Cliente: ' || v_nombre || ' ' || v_primer_apellido || ' ' || v_segundo_apellido);
            DBMS_OUTPUT.PUT_LINE('Hora Entrada: ' || v_hora_entrada || 
                                 ', Fecha Reservación: ' || TO_CHAR(v_fecha_reservacion, 'YYYY-MM-DD'));
            DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
        END LOOP;
        CLOSE c_reservaciones;
    END OBTENER_RESERVACIONES_RESTAURANTE;

    -- Función para verificar si una reservación existe
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
/

--Agregar

BEGIN
    RESERVACION_RESTAURANTE_PKG.AGREGAR_RESERVACION_RESTAURANTE(
        p_id_cliente => 2,
        p_hora_entrada => '19:00',
        p_fecha_reservacion => TO_DATE('2024-12-20', 'YYYY-MM-DD')
    );
END;
/

--Actualizar

BEGIN
    RESERVACION_RESTAURANTE_PKG.ACTUALIZAR_RESERVACION_RESTAURANTE(
        p_id_reservacion_restaurante => 1,
        p_hora_entrada => '20:00',
        p_fecha_reservacion => TO_DATE('2024-12-21', 'YYYY-MM-DD')
    );
END;
/

--Eliminar

BEGIN
    RESERVACION_RESTAURANTE_PKG.ELIMINAR_RESERVACION_RESTAURANTE(p_id_reservacion_restaurante => 1);
END;
/

--Obtener 

BEGIN
    RESERVACION_RESTAURANTE_PKG.OBTENER_RESERVACIONES_RESTAURANTE;
END;
/

--Verificar

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := RESERVACION_RESTAURANTE_PKG.EXISTE_RESERVACION_RESTAURANTE(p_id_reservacion_restaurante => 2);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('La reservación existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('La reservación no existe.');
    END IF;
END;
/

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

    -- Función para verificar si una factura existe
    FUNCTION EXISTE_FACTURA(p_id_fact_restaurante IN NUMBER) RETURN BOOLEAN;
END FAC_RESTAURANTE_PKG;
/

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
        -- Verificar si la reservación del restaurante existe
        SELECT COUNT(*)
        INTO v_reservacion_existente
        FROM RESERVACION_RESTAURANTE_TB
        WHERE ID_RESERVACION_RESTAURANTE = p_id_reservacion_restaurante;

        IF v_reservacion_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'La reservación especificada no existe.');
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
                                 ', ID Reservación: ' || v_id_reservacion || 
                                 ', Cliente: ' || v_nombre || ' ' || v_primer_apellido || ' ' || v_segundo_apellido);
            DBMS_OUTPUT.PUT_LINE('Descuento: ' || v_descuento || 
                                 ', Total Pago: ' || v_total_pago || 
                                 ', Método Pago: ' || v_metodo_pago);
            DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
        END LOOP;
        CLOSE c_facturas;
    END OBTENER_FACTURAS;

    -- Función para verificar si una factura existe
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
/

--Agregar

BEGIN
    FAC_RESTAURANTE_PKG.AGREGAR_FACTURA(
        p_id_reservacion_restaurante => 2,
        p_descuento => 10.00,
        p_total_pago => 90.00,
        p_metodo_pago => 'Tarjeta'
    );
END;
/

--Actualizar

BEGIN
    FAC_RESTAURANTE_PKG.ACTUALIZAR_FACTURA(
        p_id_fact_restaurante => 1,
        p_descuento => 5.00,
        p_total_pago => 95.00,
        p_metodo_pago => 'Efectivo'
    );
END;
/

--Eliminar

BEGIN
    FAC_RESTAURANTE_PKG.ELIMINAR_FACTURA(p_id_fact_restaurante => 1);
END;
/

--Obtener

BEGIN
    FAC_RESTAURANTE_PKG.OBTENER_FACTURAS;
END;
/

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := FAC_RESTAURANTE_PKG.EXISTE_FACTURA(p_id_fact_restaurante => 2);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('La factura existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('La factura no existe.');
    END IF;
END;
/

-- Tabla PLATILLO_MULTIPLE_TB


CREATE OR REPLACE PACKAGE PLATILLO_MULTIPLE_PKG IS
    -- Procedimiento para agregar un platillo múltiple
    PROCEDURE AGREGAR_PLATILLO_MULTIPLE(
        p_id_platillo IN NUMBER,
        p_id_fact_restaurante IN NUMBER
    );

    -- Procedimiento para eliminar un platillo múltiple
    PROCEDURE ELIMINAR_PLATILLO_MULTIPLE(p_id_platillo_multiple IN NUMBER);

    -- Procedimiento para listar todos los platillos múltiples asociados a una factura
    PROCEDURE OBTENER_PLATILLOS_MULTIPLES(p_id_fact_restaurante IN NUMBER);

    -- Función para verificar si un platillo múltiple existe
    FUNCTION EXISTE_PLATILLO_MULTIPLE(p_id_platillo_multiple IN NUMBER) RETURN BOOLEAN;
END PLATILLO_MULTIPLE_PKG;
/

CREATE OR REPLACE PACKAGE BODY PLATILLO_MULTIPLE_PKG IS

    -- Procedimiento para agregar un platillo múltiple
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

        -- Insertar el platillo múltiple
        INSERT INTO PLATILLO_MULTIPLE_TB (
            ID_PLATILLO_MULTIPLE, ID_PLATILLO, ID_FACT_RESTAURANTE
        ) VALUES (
            ID_PLATILLO_MULTIPLE_SEQ.NEXTVAL, p_id_platillo, p_id_fact_restaurante
        );
    END AGREGAR_PLATILLO_MULTIPLE;

    -- Procedimiento para eliminar un platillo múltiple
    PROCEDURE ELIMINAR_PLATILLO_MULTIPLE(p_id_platillo_multiple IN NUMBER) IS
        v_platillo_multiple_existente NUMBER;
    BEGIN
        -- Verificar si el platillo múltiple existe
        SELECT COUNT(*)
        INTO v_platillo_multiple_existente
        FROM PLATILLO_MULTIPLE_TB
        WHERE ID_PLATILLO_MULTIPLE = p_id_platillo_multiple;

        IF v_platillo_multiple_existente = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'El registro de platillo múltiple especificado no existe.');
        END IF;

        -- Eliminar el platillo múltiple
        DELETE FROM PLATILLO_MULTIPLE_TB
        WHERE ID_PLATILLO_MULTIPLE = p_id_platillo_multiple;
    END ELIMINAR_PLATILLO_MULTIPLE;

    -- Procedimiento para listar todos los platillos múltiples asociados a una factura
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

            DBMS_OUTPUT.PUT_LINE('ID Platillo Múltiple: ' || v_id_platillo_multiple || 
                                 ', Nombre: ' || v_nombre || 
                                 ', Precio: ' || v_precio || 
                                 ', ID Factura: ' || v_id_factura);
        END LOOP;
        CLOSE c_platillos;
    END OBTENER_PLATILLOS_MULTIPLES;

    -- Función para verificar si un platillo múltiple existe
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
/

--Agregar

BEGIN
    PLATILLO_MULTIPLE_PKG.AGREGAR_PLATILLO_MULTIPLE(
        p_id_platillo => 2,
        p_id_fact_restaurante => 2
    );
END;
/

--Eliminar

BEGIN
    PLATILLO_MULTIPLE_PKG.ELIMINAR_PLATILLO_MULTIPLE(p_id_platillo_multiple => 1);
END;
/

--Obtener 

BEGIN
    PLATILLO_MULTIPLE_PKG.OBTENER_PLATILLOS_MULTIPLES(p_id_fact_restaurante => 2);
END;
/

--Verificar

DECLARE
    v_existe BOOLEAN;
BEGIN
    v_existe := PLATILLO_MULTIPLE_PKG.EXISTE_PLATILLO_MULTIPLE(p_id_platillo_multiple => 2);
    IF v_existe THEN
        DBMS_OUTPUT.PUT_LINE('El registro de platillo múltiple existe.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El registro de platillo múltiple no existe.');
    END IF;
END;
/









