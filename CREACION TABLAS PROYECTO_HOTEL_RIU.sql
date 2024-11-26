
------------------------ Tabla SERVICIO_TB
CREATE TABLE SERVICIO_TB (
    id_servicio NUMBER(20) NOT NULL,
    nombre NVARCHAR2(100) NOT NULL,
    CONSTRAINT id_servicio PRIMARY KEY (id_servicio) USING INDEX (CREATE INDEX ID_SERVICIO_IDX ON SERVICIO_TB(id_servicio))
);

-- Secuencia y Trigger para la tabla SERVICIO_TB
CREATE SEQUENCE ID_SERVICIO_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_SERVICIO_AUTOINCREMENTO_TRG
BEFORE INSERT ON SERVICIO_TB
FOR EACH ROW
BEGIN
  SELECT ID_SERVICIO_SEQ.NEXTVAL INTO :NEW.id_servicio FROM DUAL;
END;


/

------------------------ Tabla DIRECCION_TB
CREATE TABLE DIRECCION_TB (
    ID_DIRECCION NUMBER(30) NOT NULL,
    PROVINCIA NVARCHAR2(100) NOT NULL,
    CANTON NVARCHAR2(100) NOT NULL,
    DISTRITO NVARCHAR2(100) NOT NULL,
    DIRECCION_DETALLADA NVARCHAR2(100) NOT NULL,
    CONSTRAINT ID_DIRECCION PRIMARY KEY (ID_DIRECCION) USING INDEX (CREATE INDEX ID_DIRECCION_IDX ON DIRECCION_TB(ID_DIRECCION))
);
-- Secuencia y Trigger para la tabla DIRECCION_TB
CREATE SEQUENCE ID_DIRECCION_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_DIRECCION_AUTOINCREMENTO_TRG
BEFORE INSERT ON DIRECCION_TB
FOR EACH ROW
BEGIN
  SELECT ID_DIRECCION_SEQ.NEXTVAL INTO :NEW.ID_DIRECCION FROM DUAL;
END;
/

------------------------ Tabla HORARIO_TB
CREATE TABLE HORARIO_TB (
    ID_HORARIO NUMBER(30) NOT NULL,
    FECHA_HORARIO DATE NOT NULL,
    HORA_APERTURA NVARCHAR2(50) NOT NULL,
    HORA_CIERRE NVARCHAR2(50) NOT NULL,
    CONSTRAINT ID_HORARIO PRIMARY KEY (ID_HORARIO) USING INDEX (CREATE INDEX ID_HORARIO_IDX ON HORARIO_TB(ID_HORARIO))
);

-- Secuencia y Trigger para la tabla HORARIO_TB
CREATE SEQUENCE ID_HORARIO_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_HORARIO_AUTOINCREMENTO_TRG
BEFORE INSERT ON HORARIO_TB
FOR EACH ROW
BEGIN
  SELECT ID_HORARIO_SEQ.NEXTVAL INTO :NEW.ID_HORARIO FROM DUAL;
END;

/

------------------------ Tabla HOTEL_TB
CREATE TABLE HOTEL_TB (
    ID_HOTEL NUMBER(30) NOT NULL,
    ID_DIRECCION NUMBER(30),
    ID_HORARIO NUMBER(30),
    NOMBRE NVARCHAR2(100) NOT NULL,
    TELEFONO NVARCHAR2(100) NOT NULL,
    CORREO NVARCHAR2(100) NOT NULL,
    CONSTRAINT PK_HOTEL PRIMARY KEY (ID_HOTEL),
    CONSTRAINT FK_DIRECCION FOREIGN KEY (ID_DIRECCION) REFERENCES DIRECCION_TB(ID_DIRECCION),
    CONSTRAINT FK_HORARIO FOREIGN KEY (ID_HORARIO) REFERENCES HORARIO_TB(ID_HORARIO)
);

-- Secuencia y Trigger para la tabla HOTEL_TB
CREATE SEQUENCE ID_HOTEL_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_HOTEL_AUTOINCREMENTO_TRG
BEFORE INSERT ON HOTEL_TB
FOR EACH ROW
BEGIN
  SELECT ID_HOTEL_SEQ.NEXTVAL INTO :NEW.ID_HOTEL FROM DUAL;
END;

/
------------------------ Tabla SERVICIO_HOTEL_TAB
CREATE TABLE SERVICIO_HOTEL_TAB (
    ID_SERVICIO_HOTEL NUMBER(30) NOT NULL,
    ID_HOTEL NUMBER(30),
    NOMBRE NVARCHAR2(100) NOT NULL,
    ESTADO NVARCHAR2(100) NOT NULL,
    CONSTRAINT PK_SERVICIO_HOTEL PRIMARY KEY (ID_SERVICIO_HOTEL),
    CONSTRAINT FK_HOTEL_SH FOREIGN KEY (ID_HOTEL) REFERENCES HOTEL_TB(ID_HOTEL)
);

-- Secuencia y Trigger para la tabla SERVICIO_HOTEL_TB
CREATE SEQUENCE ID_SERVICIO_HOTEL_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_SERVICIO_HOTEL_AUTOINCREMENTO_TRG
BEFORE INSERT ON SERVICIO_HOTEL_TAB
FOR EACH ROW
BEGIN
  SELECT ID_SERVICIO_HOTEL_SEQ.NEXTVAL INTO :NEW.ID_SERVICIO_HOTEL FROM DUAL;
END;

/
------------------------ Tabla RESTAURANTE_TB
CREATE TABLE RESTAURANTE_TB (
    ID_RESTAURANTE NUMBER(30) NOT NULL,
    ID_HOTEL NUMBER(30) NOT NULL,
    NOMBRE NVARCHAR2(100) NOT NULL,
    CONSTRAINT ID_RESTAURANTE PRIMARY KEY (ID_RESTAURANTE) USING INDEX (CREATE INDEX ID_RESTAURANTE_IDX ON RESTAURANTE_TB(ID_RESTAURANTE)),
    CONSTRAINT FK_HOTEL FOREIGN KEY (ID_HOTEL) REFERENCES HOTEL_TB(ID_HOTEL)
);

-- Secuencia y Trigger para la tabla FIDE_DIRECCION_COMPLETA_TB
CREATE SEQUENCE ID_RESTAURANTE_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_RESTAURANTE_AUTOINCREMENTO_TRG
BEFORE INSERT ON RESTAURANTE_TB
FOR EACH ROW
BEGIN
  SELECT ID_RESTAURANTE_SEQ.NEXTVAL INTO :NEW.ID_RESTAURANTE FROM DUAL;
END;

/

------------------------ Tabla PLATILLO_TB
CREATE TABLE PLATILLO_TB (
    ID_PLATILLO NUMBER(30) NOT NULL,
    ID_RESTAURANTE NUMBER(30),
    NOMBRE NVARCHAR2(100) NOT NULL,
    PRECIO NUMBER,
    CANTIDAD NUMBER,
    CONSTRAINT ID_PLATILLO PRIMARY KEY (ID_PLATILLO) USING INDEX (CREATE INDEX ID_PLATILLO_IDX ON PLATILLO_TB(ID_PLATILLO)),
    CONSTRAINT FK_RESTAURANTE FOREIGN KEY (ID_RESTAURANTE) REFERENCES RESTAURANTE_TB(ID_RESTAURANTE)
);


-- Secuencia y Trigger para la tabla PLATILLO_TB
CREATE SEQUENCE ID_PLATILLO_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_PLATILLO_AUTOINCREMENTO_TRG
BEFORE INSERT ON PLATILLO_TB
FOR EACH ROW
BEGIN
  SELECT ID_PLATILLO_SEQ.NEXTVAL INTO :NEW.ID_PLATILLO FROM DUAL;
END;
/

------------------------ Tabla HABITACION_TB
CREATE TABLE HABITACION_TB (
	ID_HABITACION NUMBER(30) NOT NULL,
	ID_HOTEL NUMBER(30) NOT NULL,
	NUMERO_HABITACION NUMBER(30) NOT NULL,
	PRECIO NUMBER NOT NULL,
    DESCRIPCION NVARCHAR2(150) NOT NULL,
    ESTADO_LIMPIEZA NVARCHAR2(100) NOT NULL,
    CAPACIDAD NUMBER(30) NOT NULL,
    CONSTRAINT ID_HABITACION PRIMARY KEY (ID_HABITACION) USING INDEX (CREATE INDEX ID_HABITACION_IDX ON HABITACION_TB(ID_HABITACION)),
    CONSTRAINT FK_HOTEL_H FOREIGN KEY (ID_HOTEL) REFERENCES HOTEL_TB(ID_HOTEL)
);

-- Secuencia y Trigger para la tabla HABITACION_TB
CREATE SEQUENCE ID_HABITACION_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_HABITACION_AUTOINCREMENTO_TRG
BEFORE INSERT ON HABITACION_TB
FOR EACH ROW
BEGIN
  SELECT ID_HABITACION_SEQ.NEXTVAL INTO :NEW.ID_HABITACION FROM DUAL;
END;

/

------------------------ Tabla PERSONA_TB
CREATE TABLE PERSONA_TB (
    ID_PERSONA NUMBER(30) NOT NULL,
    TIPO_DOCUMENTO NVARCHAR2(100) NOT NULL,
    CEDULA NVARCHAR2(100) NOT NULL,
    TELEFONO NVARCHAR2(100) NOT NULL,
    CORREO NVARCHAR2(100) NOT NULL,
    NOMBRE NVARCHAR2(100) NOT NULL,
    PRIMER_APELLIDO NVARCHAR2(100) NOT NULL,
    SEGUNDO_APELLIDO NVARCHAR2(100) NOT NULL,
    CONSTRAINT ID_PERSONA PRIMARY KEY (ID_PERSONA) USING INDEX (CREATE INDEX ID_PERSONA_IDX ON PERSONA_TB(ID_PERSONA))
);

-- Secuencia y Trigger para la tabla PERSONA_TB
CREATE SEQUENCE ID_PERSONA_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_PERSONA_AUTOINCREMENTO_TRG
BEFORE INSERT ON PERSONA_TB
FOR EACH ROW
BEGIN
  SELECT ID_PERSONA_SEQ.NEXTVAL INTO :NEW.ID_PERSONA FROM DUAL;
END;

/

------------------------ Tabla EMPLEADO_TB
CREATE TABLE EMPLEADO_TB (
    ID_EMPLEADO NUMBER(30) NOT NULL,
    ID_HOTEL NUMBER(30) NOT NULL,
    ID_PERSONA NUMBER(30) NOT NULL,
    ESTADO NVARCHAR2(100) NOT NULL,
    PUESTO NVARCHAR2(150) NOT NULL,
    SALARIO NUMBER NOT NULL,
    FECHA_INGRESO DATE NOT NULL,
    CONSTRAINT ID_EMPLEADO PRIMARY KEY (ID_EMPLEADO) USING INDEX (CREATE INDEX ID_EMPLEADO_IDX ON EMPLEADO_TB(ID_EMPLEADO)),
    CONSTRAINT FK_HOTEL_E FOREIGN KEY (ID_HOTEL) REFERENCES HOTEL_TB(ID_HOTEL),
    CONSTRAINT FK_PERSONA_E FOREIGN KEY (ID_PERSONA) REFERENCES PERSONA_TB(ID_PERSONA)
);

-- Secuencia y Trigger para la tabla EMPLEADO_TB
CREATE SEQUENCE ID_EMPLEADO_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_EMPLEADO_AUTOINCREMENTO_TRG
BEFORE INSERT ON EMPLEADO_TB
FOR EACH ROW
BEGIN
  SELECT ID_EMPLEADO_SEQ.NEXTVAL INTO :NEW.ID_EMPLEADO FROM DUAL;
END;

/

------------------------ Tabla LIMPIEZA_HABITACION_TB
CREATE TABLE LIMPIEZA_HABITACION_TB (
    ID_LIMPIEZA_HABITACION NUMBER(30) NOT NULL,
    ID_EMPLEADO NUMBER(30) NOT NULL,
    ID_HABITACION NUMBER(30) NOT NULL,
    ESTADO_TAREA NVARCHAR2(100) NOT NULL,
    FECHA DATE NOT NULL,
    CONSTRAINT ID_LIMPIEZA_HABITACION PRIMARY KEY (ID_LIMPIEZA_HABITACION) USING INDEX (CREATE INDEX ID_LIMPIEZA_HABITACION_IDX ON LIMPIEZA_HABITACION_TB(ID_LIMPIEZA_HABITACION)),
    CONSTRAINT FK_EMPLEADO_L FOREIGN KEY (ID_EMPLEADO) REFERENCES EMPLEADO_TB(ID_EMPLEADO),
    CONSTRAINT FK_HABITACION_L FOREIGN KEY (ID_HABITACION) REFERENCES HABITACION_TB(ID_HABITACION)
);

-- Secuencia y Trigger para la tabla LIMPIEZA_HABITACION_TB
CREATE SEQUENCE ID_LIMPIEZA_HABITACION_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_LIMPIEZA_HABITACION_AUTOINCREMENTO_TRG
BEFORE INSERT ON LIMPIEZA_HABITACION_TB
FOR EACH ROW
BEGIN
  SELECT ID_LIMPIEZA_HABITACION_SEQ.NEXTVAL INTO :NEW.ID_LIMPIEZA_HABITACION FROM DUAL;
END;

/

------------------------ Tabla SERVICIO_MULTIPLE_TB
CREATE TABLE SERVICIO_MULTIPLE_TB (
    ID_SERVICIO_MULTIPLE NUMBER(30) NOT NULL,
    ID_HABITACION NUMBER(30),   
    CONSTRAINT ID_SERVICIO_MULTIPLE PRIMARY KEY (ID_SERVICIO_MULTIPLE) USING INDEX (CREATE INDEX ID_SERVICIO_MULTIPLE_IDX ON SERVICIO_MULTIPLE_TB(ID_SERVICIO_MULTIPLE)),
    CONSTRAINT FK_HABITACION_SM FOREIGN KEY (ID_HABITACION) REFERENCES HABITACION_TB(ID_HABITACION)
);

-- Secuencia y Trigger para la tabla SERVICIO_MULTIPLE_TB
CREATE SEQUENCE ID_SERVICIO_MULTIPLE_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_SERVICIO_MULTIPLE_AUTOINCREMENTO_TRG
BEFORE INSERT ON SERVICIO_MULTIPLE_TB
FOR EACH ROW
BEGIN
  SELECT ID_SERVICIO_MULTIPLE_SEQ.NEXTVAL INTO :NEW.ID_SERVICIO_MULTIPLE FROM DUAL;
END;

/

------------------------ Tabla CLIENTE_TB
CREATE TABLE CLIENTE_TB (
    ID_CLIENTE NUMBER(30) NOT NULL,
    ID_PERSONA NUMBER(30)NOT NULL,
    CONSTRAINT ID_CLIENTE PRIMARY KEY (ID_CLIENTE) USING INDEX (CREATE INDEX ID_CLIENTE_IDX ON CLIENTE_TB(ID_CLIENTE)),
    CONSTRAINT FK_PERSONA FOREIGN KEY (ID_PERSONA) REFERENCES PERSONA_TB(ID_PERSONA)
);

-- Secuencia y Trigger para la tabla ID_CLIENTE
CREATE SEQUENCE ID_CLIENTE_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_CLIENTE_AUTOINCREMENTO_TRG
BEFORE INSERT ON CLIENTE_TB
FOR EACH ROW
BEGIN
  SELECT ID_CLIENTE_SEQ.NEXTVAL INTO :NEW.ID_CLIENTE FROM DUAL;
END;

/

------------------------ Tabla RESERVACION_HABITACION_TB
CREATE TABLE RESERVACION_HABITACION_TB (
    ID_RESERVACION_HABITACION NUMBER(30) NOT NULL,
    ID_HABITACION NUMBER(30) NOT NULL,
    ID_CLIENTE NUMBER(30) NOT NULL,
    ID_HORARIO NUMBER(30) NOT NULL,
    METODO_PAGO NVARCHAR2(100) NOT NULL,
    DESCUENTO NUMBER NOT NULL,
    TOTAL_PAGAR NUMBER NOT NULL,
    FECHA_ENTREDA DATE NOT NULL,
    FECHA_SALIDA DATE NOT NULL,
    CONSTRAINT ID_RESERVACION_HABITACION PRIMARY KEY (ID_RESERVACION_HABITACION) USING INDEX (CREATE INDEX ID_RESERVACION_HABITACION_IDX ON RESERVACION_HABITACION_TB(ID_RESERVACION_HABITACION)),
    CONSTRAINT FK_HORARIO_R FOREIGN KEY (ID_HORARIO) REFERENCES HORARIO_TB(ID_HORARIO),
    CONSTRAINT FK_HABITACION_R FOREIGN KEY (ID_HABITACION) REFERENCES HABITACION_TB(ID_HABITACION),
    CONSTRAINT FK_CLIENTE_R FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE_TB(ID_CLIENTE)
);

-- Secuencia y Trigger para la tabla RESERVACION_HABITACION_TB
CREATE SEQUENCE ID_RESERVACION_HABITACION_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_RESERVACION_HABITACION_AUTOINCREMENTO_TRG
BEFORE INSERT ON RESERVACION_HABITACION_TB
FOR EACH ROW
BEGIN
  SELECT ID_RESERVACION_HABITACION_SEQ.NEXTVAL INTO :NEW.ID_RESERVACION_HABITACION FROM DUAL;
END;

/

------------------------ Tabla RESERVACION_RESTAURANTE_TB
CREATE TABLE RESERVACION_RESTAURANTE_TB (
    ID_RESERVACION_RESTAURANTE NUMBER(30) NOT NULL,
    ID_CLIENTE NUMBER NOT NULL,
    HORA_ENTRADA NVARCHAR2(50) NOT NULL, 
    FECHA_RESRVACION DATE NOT NULL,
    CONSTRAINT ID_RESERVACION_RESTAURANTE PRIMARY KEY (ID_RESERVACION_RESTAURANTE)USING INDEX (CREATE INDEX ID_RESERVACION_RESTAURANTE_IDX ON RESERVACION_RESTAURANTE_TB(ID_RESERVACION_RESTAURANTE)),
    CONSTRAINT FK_CLIENTE FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE_TB(ID_CLIENTE)
);

-- Secuencia y Trigger para la tabla RESERVACION_RESTAURANTE_TB
CREATE SEQUENCE ID_RESERVACION_RESTAURANTE_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_RESERVACION_RESTAURANTE_AUTOINCREMENTO_TRG
BEFORE INSERT ON RESERVACION_RESTAURANTE_TB
FOR EACH ROW
BEGIN
  SELECT ID_RESERVACION_RESTAURANTE_SEQ.NEXTVAL INTO :NEW.ID_RESERVACION_RESTAURANTE FROM DUAL;
END;

/

------------------------ Tabla FAC_RESTAURANTE_TB
CREATE TABLE FAC_RESTAURANTE_TB (
    ID_FACT_RESTAURANTE NUMBER(30) NOT NULL,
    ID_RESERVACION_RESTAURANTE NUMBER(30) NOT NULL,
    DESCUENTO NUMBER NOT NULL,
    TOTAL_PAGO NUMBER NOT NULL, 
    METODO_PAGO NVARCHAR2(100) NOT NULL,
    CONSTRAINT ID_FACT_RESTAURANTE PRIMARY KEY (ID_FACT_RESTAURANTE)USING INDEX (CREATE INDEX ID_FACT_RESTAURANTE_IDX ON FAC_RESTAURANTE_TB(ID_FACT_RESTAURANTE)),
    CONSTRAINT FK_RESERVACION_RESTAURANTE FOREIGN KEY (ID_RESERVACION_RESTAURANTE) REFERENCES RESERVACION_RESTAURANTE_TB(ID_RESERVACION_RESTAURANTE)
);

-- Secuencia y Trigger para la tabla FAC_RESTAURANTE_TB
CREATE SEQUENCE ID_FACT_RESTAURANTE_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_FACT_RESTAURANTE_AUTOINCREMENTO_TRG
BEFORE INSERT ON FAC_RESTAURANTE_TB
FOR EACH ROW
BEGIN
  SELECT ID_FACT_RESTAURANTE_SEQ.NEXTVAL INTO :NEW.ID_FACT_RESTAURANTE FROM DUAL;
END;

/

------------------------ Tabla PLATILLO_MULTIPLE_TB
CREATE TABLE PLATILLO_MULTIPLE_TB (
    ID_PLATILLO_MULTIPLE NUMBER(30) NOT NULL,
    ID_PLATILLO NUMBER(30) NOT NULL,
    ID_FACT_RESTAURANTE NUMBER(30) NOT NULL,
    CONSTRAINT ID_PLATILLO_MULTIPLE PRIMARY KEY (ID_PLATILLO_MULTIPLE) USING INDEX (CREATE INDEX ID_PLATILLO_MULTIPLE_IDX ON PLATILLO_MULTIPLE_TB(ID_PLATILLO_MULTIPLE)),
    CONSTRAINT FK_PLATILLO FOREIGN KEY (ID_PLATILLO) REFERENCES PLATILLO_TB(ID_PLATILLO),
    CONSTRAINT FK_FACT_RESTAURANTE FOREIGN KEY (ID_FACT_RESTAURANTE) REFERENCES FAC_RESTAURANTE_TB(ID_FACT_RESTAURANTE)
);

-- Secuencia y Trigger para la tabla PLATILLO_MULTIPLE_TB
CREATE SEQUENCE ID_PLATILLO_MULTIPLE_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER ID_PLATILLO_MULTIPLE_AUTOINCREMENTO_TRG
BEFORE INSERT ON PLATILLO_MULTIPLE_TB
FOR EACH ROW
BEGIN
  SELECT ID_PLATILLO_MULTIPLE_SEQ.NEXTVAL INTO :NEW.ID_PLATILLO_MULTIPLE FROM DUAL;
END;

/

--Procedimentos Almacenados de Persona
CREATE OR REPLACE PROCEDURE insertar_persona( p_tipo_documento IN NVARCHAR2, p_cedula IN NVARCHAR2,
p_telefono IN NVARCHAR2, p_correo IN NVARCHAR2, p_nombre IN NVARCHAR2, p_primer_apellido IN NVARCHAR2,
p_segundo_apellido IN NVARCHAR2) 
AS
BEGIN
    INSERT INTO PERSONA_TB (
        TIPO_DOCUMENTO, CEDULA, TELEFONO, CORREO, NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO
    ) VALUES (
        p_tipo_documento, p_cedula, p_telefono, p_correo, p_nombre, p_primer_apellido, p_segundo_apellido
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al insertar persona: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE consultar_persona (p_id_persona IN NUMBER) 
AS
    p_tipo_documento NVARCHAR2(100);
    p_cedula NVARCHAR2(100);
    p_telefono NVARCHAR2(100);
    p_correo NVARCHAR2(100);
    p_nombre NVARCHAR2(100);
    p_primer_apellido NVARCHAR2(100);
    p_segundo_apellido NVARCHAR2(100);
BEGIN
    SELECT TIPO_DOCUMENTO, CEDULA, TELEFONO, CORREO, NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO
    INTO p_tipo_documento, p_cedula, p_telefono, p_correo, p_nombre, p_primer_apellido, p_segundo_apellido
    FROM PERSONA_TB
    WHERE ID_PERSONA = p_id_persona;

    DBMS_OUTPUT.PUT_LINE('Datos de la Persona:');
    DBMS_OUTPUT.PUT_LINE('Tipo de Documento: ' || p_tipo_documento);
    DBMS_OUTPUT.PUT_LINE('Cédula: ' || p_cedula);
    DBMS_OUTPUT.PUT_LINE('Teléfono: ' || p_telefono);
    DBMS_OUTPUT.PUT_LINE('Correo: ' || p_correo);
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || p_nombre);
    DBMS_OUTPUT.PUT_LINE('Primer Apellido: ' || p_primer_apellido);
    DBMS_OUTPUT.PUT_LINE('Segundo Apellido: ' || p_segundo_apellido);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos para el ID de persona proporcionado');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;



CREATE OR REPLACE PROCEDURE eliminar_persona ( p_id_persona IN NUMBER) 
AS
BEGIN
    DELETE FROM PERSONA_TB
    WHERE ID_PERSONA = p_id_persona;

    DBMS_OUTPUT.PUT_LINE('Persona con ID ' || p_id_persona || ' ha sido eliminada.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos para el ID de persona proporcionado');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE actualizar_persona (p_id_persona IN NUMBER, p_tipo_documento IN NVARCHAR2,
p_cedula IN NVARCHAR2, p_telefono IN NVARCHAR2, p_correo IN NVARCHAR2, p_nombre IN NVARCHAR2,
p_primer_apellido IN NVARCHAR2, p_segundo_apellido IN NVARCHAR2) 
AS
BEGIN
    UPDATE PERSONA_TB
    SET TIPO_DOCUMENTO   = p_tipo_documento,
        CEDULA           = p_cedula,
        TELEFONO         = p_telefono,
        CORREO           = p_correo,
        NOMBRE           = p_nombre,
        PRIMER_APELLIDO  = p_primer_apellido,
        SEGUNDO_APELLIDO = p_segundo_apellido
    WHERE ID_PERSONA = p_id_persona;

    DBMS_OUTPUT.PUT_LINE('La persona con ID ' || p_id_persona || ' ha sido actualizada.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos para el ID de persona proporcionado');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

--Procedimientos Almacenados de Empleado

CREATE OR REPLACE PROCEDURE insertar_empleado(p_id_hotel IN NUMBER, p_id_persona IN NUMBER,
p_estado IN NVARCHAR2, p_puesto IN NVARCHAR2, p_salario IN NUMBER, p_fecha_ingreso IN DATE) 
AS
BEGIN
    INSERT INTO EMPLEADO_TB (ID_HOTEL, ID_PERSONA, ESTADO, PUESTO, SALARIO, FECHA_INGRESO) 
    VALUES (p_id_hotel, p_id_persona, p_estado, p_puesto, p_salario, p_fecha_ingreso);
    DBMS_OUTPUT.PUT_LINE('Empleado insertado correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al insertar empleado: ' || SQLERRM);
END;


CREATE OR REPLACE PROCEDURE consultar_empleado(p_id_empleado IN NUMBER) 
AS
    p_id_hotel NUMBER;
    p_id_persona NUMBER;
    p_estado NVARCHAR2(100);
    p_puesto NVARCHAR2(150);
    p_salario NUMBER;
    p_fecha_ingreso DATE;
BEGIN
    SELECT ID_HOTEL, ID_PERSONA, ESTADO, PUESTO, SALARIO, FECHA_INGRESO
    INTO p_id_hotel, p_id_persona, p_estado, p_puesto, p_salario, p_fecha_ingreso
    FROM EMPLEADO_TB
    WHERE ID_EMPLEADO = p_id_empleado;

    DBMS_OUTPUT.PUT_LINE('Datos del Empleado:');
    DBMS_OUTPUT.PUT_LINE('ID Hotel: ' || p_id_hotel);
    DBMS_OUTPUT.PUT_LINE('ID Persona: ' || p_id_persona);
    DBMS_OUTPUT.PUT_LINE('Estado: ' || p_estado);
    DBMS_OUTPUT.PUT_LINE('Puesto: ' || p_puesto);
    DBMS_OUTPUT.PUT_LINE('Salario: ' || p_salario);
    DBMS_OUTPUT.PUT_LINE('Fecha de Ingreso: ' || p_fecha_ingreso);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos para el ID de empleado proporcionado');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


CREATE OR REPLACE PROCEDURE eliminar_empleado( p_id_empleado IN NUMBER) 
AS
BEGIN
    DELETE FROM EMPLEADO_TB
    WHERE ID_EMPLEADO = p_id_empleado;
    DBMS_OUTPUT.PUT_LINE('Empleado con ID ' || p_id_empleado || ' ha sido eliminado.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos para el ID de empleado proporcionado');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;


CREATE OR REPLACE PROCEDURE actualizar_empleado(p_id_empleado IN NUMBER, p_id_hotel IN NUMBER,
p_id_persona IN NUMBER, p_estado IN NVARCHAR2, p_puesto IN NVARCHAR2, p_salario IN NUMBER,
p_fecha_ingreso IN DATE) 
AS
BEGIN
    UPDATE EMPLEADO_TB
    SET ID_HOTEL       = p_id_hotel,
        ID_PERSONA     = p_id_persona,
        ESTADO         = p_estado,
        PUESTO         = p_puesto,
        SALARIO        = p_salario,
        FECHA_INGRESO  = p_fecha_ingreso
    WHERE ID_EMPLEADO = p_id_empleado;
    DBMS_OUTPUT.PUT_LINE('El empleado con ID ' || p_id_empleado || ' ha sido actualizado.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos para el ID de empleado proporcionado');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;



--Procedimientos Almacenados de Cliente

CREATE OR REPLACE TRIGGER ID_CLIENTE_AUTOINCREMENTO_TRG
BEFORE INSERT ON CLIENTE_TB
FOR EACH ROW
BEGIN
  SELECT ID_CLIENTE_SEQ.NEXTVAL INTO :NEW.ID_CLIENTE FROM DUAL;
END;


CREATE OR REPLACE PROCEDURE insertar_cliente(p_id_persona IN NUMBER) 
AS
BEGIN
    INSERT INTO CLIENTE_TB (ID_PERSONA) 
        VALUES (p_id_persona);
    DBMS_OUTPUT.PUT_LINE('Cliente insertado correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al insertar cliente: ' || SQLERRM);
END;



CREATE OR REPLACE PROCEDURE consultar_cliente(p_id_cliente IN NUMBER) 
AS 
p_id_persona NUMBER;
BEGIN
    SELECT ID_PERSONA
    INTO p_id_persona
    FROM CLIENTE_TB
    WHERE ID_CLIENTE = p_id_cliente;
    DBMS_OUTPUT.PUT_LINE('Datos del Cliente:');
    DBMS_OUTPUT.PUT_LINE('ID Persona: ' || p_id_persona);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos para el ID de cliente proporcionado');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE eliminar_cliente(
    p_id_cliente IN NUMBER
) AS
BEGIN
    DELETE FROM CLIENTE_TB
    WHERE ID_CLIENTE = p_id_cliente;

    DBMS_OUTPUT.PUT_LINE('Cliente con ID ' || p_id_cliente || ' ha sido eliminado.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos para el ID de cliente proporcionado');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

------------------------ Vistas

create or replace view V_INFO_HOTEL
AS
SELECT H.ID_HOTEL, H.NOMBRE, H.TELEFONO, H.CORREO, 
D.PROVINCIA || ' ' || D.CANTON || ' ' || D.DISTRITO || ' ' || D.DIRECCION_DETALLADA, HR.ID_HORARIO
FROM HOTEL_TB H INNER JOIN  DIRECCION_TB D 
ON H.ID_DIRECCION = D.ID_DIRECCION
INNER JOIN HORARIO_TB HR 
ON H.ID_HORARIO = HR.ID_HORARIO;
/
----

create or replace view V_SERVICIOS_HOTEL
AS
SELECT SM.ID_HABITACION, H.NUMERO_HABITACION, S.ID_SERVICIO, S.NOMBRE NOMBRE_SERVICIO
FROM servicio_multiple_tb SM
INNER JOIN servicio_tb S ON sm.id_servicio_multiple = S.ID_SERVICIO
INNER JOIN HABITACION_TB H ON SM.ID_HABITACION = H.ID_HABITACION;
/
-----

create or replace view V_RESERVACION
as 
SELECT RH.ID_RESERVACION_HABITACION, H.NUMERO_HABITACION, RH.METODO_PAGO,RH.DESCUENTO,
RH.TOTAL_PAGAR,RH.FECHA_ENTREDA,RH.FECHA_SALIDA, P.CEDULA, P.NOMBRE || ' ' || P.PRIMER_APELLIDO
FROM RESERVACION_HABITACION_TB RH
JOIN HABITACION_TB H ON RH.ID_HABITACION = H.ID_HABITACION
JOIN CLIENTE_TB C ON RH.ID_CLIENTE = C.ID_CLIENTE
JOIN PERSONA_TB P ON P.ID_PERSONA = C.ID_PERSONA;

/
-----
CREATE OR REPLACE VIEW VISTA_EMPLEADOS_DETALLE AS
SELECT e.ID_EMPLEADO, e.ID_HOTEL, p.NOMBRE, p.PRIMER_APELLIDO,
p.SEGUNDO_APELLIDO, p.CEDULA, e.PUESTO, e.SALARIO,
e.FECHA_INGRESO, e.ESTADO
FROM EMPLEADO_TB e
JOIN 
PERSONA_TB p ON e.ID_PERSONA = p.ID_PERSONA;
/
	---
CREATE OR REPLACE VIEW VISTA_CLIENTES AS
SELECT c.ID_CLIENTE, p.NOMBRE, p.PRIMER_APELLIDO,
p.SEGUNDO_APELLIDO, p.CEDULA, p.CORREO, p.TELEFONO
FROM 
CLIENTE_TB c
JOIN 
PERSONA_TB p ON c.ID_PERSONA = p.ID_PERSONA;




