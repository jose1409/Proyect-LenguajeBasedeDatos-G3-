--Funciones
    
--Parte de Funciones con cursor

--Funcion Verificar disponibilidad de una habitacion(1)

CREATE OR REPLACE FUNCTION verificar_disponibilidad (
    habitacion_id   NUMBER,
    fecha_consulta  DATE
) RETURN VARCHAR2 IS

    CURSOR c_reservaciones IS
    SELECT
        id_habitacion
    FROM
        reservacion_habitacion_tb
    WHERE
            id_habitacion = habitacion_id
        AND NOT ( fecha_salida <= fecha_consulta
                  OR fecha_entreda >= fecha_consulta + 1 );

    v_habitacion_reservada NUMBER;
BEGIN
    OPEN c_reservaciones;
    FETCH c_reservaciones INTO v_habitacion_reservada;
    CLOSE c_reservaciones;
    IF v_habitacion_reservada IS NOT NULL THEN
        RETURN 'No Disponible';
    ELSE
        RETURN 'Disponible';
    END IF;
END;
/

--Ver resultado

DECLARE
    resultado VARCHAR2(20);
BEGIN
    resultado := verificar_disponibilidad(10, TO_DATE('2024-12-25', 'YYYY-MM-DD'));
    dbms_output.put_line('La habitación 10 está ' || resultado);
END;
/

--Funcion Encontrar metodo de pago mas utilizado(2)

CREATE OR REPLACE FUNCTION metodo_pago_mas_utilizado RETURN VARCHAR2 IS

    CURSOR c_metodos_pago IS
    SELECT
        metodo_pago,
        COUNT(*) AS frecuencia
    FROM
        fac_restaurante_tb
    GROUP BY
        metodo_pago
    ORDER BY
        frecuencia DESC;

    v_metodo_pago            fac_restaurante_tb.metodo_pago%TYPE;
    v_frecuencia             NUMBER;
    v_metodo_pago_mas_usado  VARCHAR2(100);
BEGIN
    OPEN c_metodos_pago;
    FETCH c_metodos_pago INTO
        v_metodo_pago,
        v_frecuencia;
    IF c_metodos_pago%found THEN
        v_metodo_pago_mas_usado := v_metodo_pago;
    ELSE
        v_metodo_pago_mas_usado := 'No hay métodos de pago registrados';
    END IF;

    CLOSE c_metodos_pago;
    RETURN v_metodo_pago_mas_usado;
END;
/

--Ver resultado

DECLARE
    v_metodo_usado VARCHAR2(100);
BEGIN
    v_metodo_usado := metodo_pago_mas_utilizado;
    dbms_output.put_line('El método de pago más utilizado es: ' || v_metodo_usado);
END;
/


--Funcion Calcular los ingresos de un platillo en especifico(3)

CREATE OR REPLACE FUNCTION ingresos_por_platillo (
    id_platillo NUMBER
) RETURN NUMBER IS

    CURSOR c_facturas IS
    SELECT
        f.total_pago
    FROM
             fac_restaurante_tb f
        JOIN platillo_multiple_tb pm ON f.id_fact_restaurante = pm.id_fact_restaurante
    WHERE
        pm.id_platillo = id_platillo;

    v_total_ingresos  NUMBER := 0;
    v_pago_factura    NUMBER;
BEGIN
    OPEN c_facturas;
    LOOP
        FETCH c_facturas INTO v_pago_factura;
        EXIT WHEN c_facturas%notfound;
        v_total_ingresos := v_total_ingresos + v_pago_factura;
    END LOOP;

    CLOSE c_facturas;
    RETURN v_total_ingresos;
END;
/


--Ver resultado

DECLARE
    v_ingresos NUMBER;
BEGIN
    v_ingresos := ingresos_por_platillo(1);
    dbms_output.put_line('Total de ingresos generados por el platillo 1: ' || to_char(v_ingresos, '999,999,999.99'));
END;
/


--Funcion para Contar las Veces que un Platillo ha sido Pedido(4)


CREATE OR REPLACE FUNCTION contar_pedidos_platillo (
    id_platillo NUMBER
) RETURN NUMBER IS

    CURSOR c_pedidos IS
    SELECT
        id_platillo
    FROM
        platillo_multiple_tb
    WHERE
        id_platillo = id_platillo;

    v_contador     NUMBER := 0;
    v_platillo_id  NUMBER;
BEGIN
    OPEN c_pedidos;
    LOOP
        FETCH c_pedidos INTO v_platillo_id;
        EXIT WHEN c_pedidos%notfound;
        v_contador := v_contador + 1;
    END LOOP;

    CLOSE c_pedidos;
    RETURN v_contador;
END;
/

--Ver resultado

DECLARE
    v_num_pedidos NUMBER;
BEGIN
    v_num_pedidos := contar_pedidos_platillo(1);
    dbms_output.put_line('El platillo con ID 1 ha sido pedido '
                         || v_num_pedidos
                         || ' veces.');
END;
/


--Funcion para obtener la ultima fecha de salida de un cliente(5)

CREATE OR REPLACE FUNCTION ultima_fecha_salida (
    cliente_id NUMBER
) RETURN DATE IS

    CURSOR c_fechas_salida IS
    SELECT
        rh.fecha_salida
    FROM
             reservacion_habitacion_tb rh
        JOIN cliente_tb c ON rh.id_cliente = c.id_cliente
    WHERE
        c.id_cliente = cliente_id
    ORDER BY
        rh.fecha_salida DESC;

    v_ultima_fecha DATE;
BEGIN
    OPEN c_fechas_salida;
    FETCH c_fechas_salida INTO v_ultima_fecha;
    CLOSE c_fechas_salida;
    RETURN v_ultima_fecha;
END;
/

--Ver resultado

DECLARE
    v_fecha_salida DATE;
BEGIN
    v_fecha_salida := ultima_fecha_salida(2);
    IF v_fecha_salida IS NOT NULL THEN
        dbms_output.put_line('La última fecha de salida del cliente 2 es: ' || to_char(v_fecha_salida, 'DD-MON-YYYY'));
    ELSE
        dbms_output.put_line('No hay registros de salida para el cliente 2.');
    END IF;

END;
/

--Funcion para calcular el ingreso total de reservaciones por mes(6)


CREATE OR REPLACE FUNCTION ingresos_reservaciones_mes (
    anio  NUMBER,
    mes   NUMBER
) RETURN NUMBER IS

    CURSOR c_pagos IS
    SELECT
        total_pagar
    FROM
        reservacion_habitacion_tb
    WHERE
            EXTRACT(YEAR FROM fecha_entreda) = anio
        AND EXTRACT(MONTH FROM fecha_entreda) = mes;

    v_total_ingresos    NUMBER := 0;
    v_pago_reservacion  NUMBER;
BEGIN
    OPEN c_pagos;
    LOOP
        FETCH c_pagos INTO v_pago_reservacion;
        EXIT WHEN c_pagos%notfound;
        v_total_ingresos := v_total_ingresos + v_pago_reservacion;
    END LOOP;

    CLOSE c_pagos;
    RETURN v_total_ingresos;
END;
/

--Ver Resultado

DECLARE
    v_ingresos NUMBER;
BEGIN
    v_ingresos := ingresos_reservaciones_mes(2024, 12);
    dbms_output.put_line('Total de ingresos en diciembre de 2024: ' || to_char(v_ingresos, '999,999,999.99'));
END;
/

--Funcion para verificar el metodo de pago de un cliente(7)

CREATE OR REPLACE FUNCTION verificar_metodo_pago_cliente (
    cliente_id  NUMBER,
    metodo      VARCHAR2
) RETURN VARCHAR2 IS

    CURSOR c_metodo_pago IS
    SELECT
        metodo_pago
    FROM
        reservacion_habitacion_tb
    WHERE
            id_cliente = cliente_id
        AND metodo_pago = metodo;

    v_metodo_pago NVARCHAR2(100);
BEGIN
    OPEN c_metodo_pago;
    FETCH c_metodo_pago INTO v_metodo_pago;
    CLOSE c_metodo_pago;
    IF v_metodo_pago IS NOT NULL THEN
        RETURN 'Sí';
    ELSE
        RETURN 'No';
    END IF;
END;
/

--Ver Resultado

DECLARE
    resultado VARCHAR2(2);
BEGIN
    resultado := verificar_metodo_pago_cliente(123, 'Tarjeta');
    dbms_output.put_line('¿El cliente 123 ha usado tarjeta? ' || resultado);
END;
/

--Funcion para calcular el ingreso total de un dia en restaurante(8)

CREATE OR REPLACE FUNCTION calcular_ingreso_diario (
    fecha DATE
) RETURN NUMBER IS

    CURSOR c_pagos IS
    SELECT
        total_pagar
    FROM
        reservacion_habitacion_tb
    WHERE
        trunc(fecha_entreda) = trunc(fecha);

    v_total_ingresos  NUMBER := 0;
    v_pago_actual     NUMBER;
BEGIN
    OPEN c_pagos;
    LOOP
        FETCH c_pagos INTO v_pago_actual;
        EXIT WHEN c_pagos%notfound;
        v_total_ingresos := v_total_ingresos + v_pago_actual;
    END LOOP;

    CLOSE c_pagos;
    RETURN v_total_ingresos;
END;
/

--Ver Resultado

DECLARE
    v_ingresos_del_dia NUMBER;
BEGIN
    v_ingresos_del_dia := calcular_ingreso_diario(TO_DATE('2024-12-20', 'YYYY-MM-DD'));
    dbms_output.put_line('Ingresos totales el 20 de diciembre de 2024: ' || to_char(v_ingresos_del_dia, '999,999,999.99'));
END;
/

--Funcion para contar el total de habitaciones reservadas por un cliente(9)

CREATE OR REPLACE FUNCTION contar_habitaciones_cliente (
    cliente_id NUMBER
) RETURN NUMBER IS

    CURSOR c_reservaciones IS
    SELECT
        id_habitacion
    FROM
        reservacion_habitacion_tb
    WHERE
        id_cliente = cliente_id;

    v_contador       NUMBER := 0;
    v_habitacion_id  NUMBER;
BEGIN
    OPEN c_reservaciones;
    LOOP
        FETCH c_reservaciones INTO v_habitacion_id;
        EXIT WHEN c_reservaciones%notfound;
        v_contador := v_contador + 1;
    END LOOP;

    CLOSE c_reservaciones;
    RETURN v_contador;
END;
/

--Ver resultado

DECLARE
    v_num_habitaciones NUMBER;
BEGIN
    v_num_habitaciones := contar_habitaciones_cliente(2);
    dbms_output.put_line('El cliente 2 ha reservado '
                         || v_num_habitaciones
                         || ' habitaciones en total.');
END;
/

--Calcular promedio de instacia de los clientes(10)

CREATE OR REPLACE FUNCTION promedio_estancia RETURN NUMBER IS

    CURSOR c_estancias IS
    SELECT
        fecha_entreda,
        fecha_salida
    FROM
        reservacion_habitacion_tb;

    v_total_dias         NUMBER := 0;
    v_contador           NUMBER := 0;
    v_fecha_entrada      DATE;
    v_fecha_salida       DATE;
    v_duracion_estancia  NUMBER;
BEGIN
    OPEN c_estancias;
    LOOP
        FETCH c_estancias INTO
            v_fecha_entrada,
            v_fecha_salida;
        EXIT WHEN c_estancias%notfound;
        v_duracion_estancia := v_fecha_salida - v_fecha_entrada;
        v_total_dias := v_total_dias + v_duracion_estancia;
        v_contador := v_contador + 1;
    END LOOP;

    CLOSE c_estancias;
    IF v_contador > 0 THEN
        RETURN v_total_dias / v_contador;
    ELSE
        RETURN 0;
    END IF;
END;
/

--Ver resultado

DECLARE
    v_promedio_estancia NUMBER;
BEGIN
    v_promedio_estancia := promedio_estancia;
    dbms_output.put_line('El promedio de estancia de los clientes es de '
                         || v_promedio_estancia
                         || ' días.');
END;
/

--Funcion para contar reservaciones en un periodo en especifico(11)

CREATE OR REPLACE FUNCTION contar_reservaciones_periodo (
    fecha_inicio  DATE,
    fecha_fin     DATE
) RETURN NUMBER IS

    CURSOR c_reservaciones IS
    SELECT
        id_reservacion_habitacion
    FROM
        reservacion_habitacion_tb
    WHERE
            fecha_entreda >= fecha_inicio
        AND fecha_entreda <= fecha_fin;

    v_contador        NUMBER := 0;
    v_reservacion_id  NUMBER;
BEGIN
    OPEN c_reservaciones;
    LOOP
        FETCH c_reservaciones INTO v_reservacion_id;
        EXIT WHEN c_reservaciones%notfound;
        v_contador := v_contador + 1;
    END LOOP;

    CLOSE c_reservaciones;
    RETURN v_contador;
END;
/

--Ver resultado

DECLARE
    v_num_reservaciones NUMBER;
BEGIN
    v_num_reservaciones := contar_reservaciones_periodo(TO_DATE('2024-10-05', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'));

    dbms_output.put_line('Número total de reservaciones en octubre a diciembre del 2024: ' || v_num_reservaciones);
END;
/

--Funcion para hacer una lista de las habitaciones mas reservadas(12)

CREATE OR REPLACE FUNCTION contar_reservaciones_por_habitacion RETURN SYS_REFCURSOR IS
    rc_reservaciones SYS_REFCURSOR;
BEGIN
    OPEN rc_reservaciones FOR SELECT
                                  id_habitacion,
                                  COUNT(*) AS num_reservaciones
                              FROM
                                  reservacion_habitacion_tb
                              GROUP BY
                                  id_habitacion
                              ORDER BY
                                  num_reservaciones DESC;

    RETURN rc_reservaciones;
END;
/

--Ver resultado

DECLARE
    rc_result            SYS_REFCURSOR;
    v_id_habitacion      NUMBER;
    v_num_reservaciones  NUMBER;
BEGIN
    rc_result := contar_reservaciones_por_habitacion;
    LOOP
        FETCH rc_result INTO
            v_id_habitacion,
            v_num_reservaciones;
        EXIT WHEN rc_result%notfound;
        dbms_output.put_line('Habitación ID: '
                             || v_id_habitacion
                             || ' ha sido reservada '
                             || v_num_reservaciones
                             || ' veces.');

    END LOOP;

    CLOSE rc_result;
END;
/

--Funciones sin cursor


--Funcion para obtner el total pagado por un cliente(13)

CREATE OR REPLACE FUNCTION obtener_total_pagado_cliente (
    cliente_id NUMBER
) RETURN NUMBER IS
    v_total_pagado NUMBER := 0;
BEGIN
    SELECT
        SUM(total_pagar)
    INTO v_total_pagado
    FROM
        reservacion_habitacion_tb
    WHERE
        id_cliente = cliente_id;

    RETURN v_total_pagado;
EXCEPTION
    WHEN no_data_found THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE;
END;
/

--Ver resultado

DECLARE
    v_total NUMBER;
BEGIN
    v_total := obtener_total_pagado_cliente(2);  -- Supongamos que 123 es el ID del cliente
    dbms_output.put_line('Total pagado por el cliente 2: ' || v_total);
END;
/

--Funcion para obtener los clientes entre fechas en especifico(14)


CREATE OR REPLACE FUNCTION listar_clientes_reservaciones (
    fecha_inicio  DATE,
    fecha_fin     DATE
) RETURN SYS_REFCURSOR IS
    rc_clientes SYS_REFCURSOR;
BEGIN
    OPEN rc_clientes FOR SELECT DISTINCT
                             c.id_cliente,
                             p.nombre,
                             p.primer_apellido,
                             p.segundo_apellido
                         FROM
                                  cliente_tb c
                             JOIN persona_tb                 p ON c.id_persona = p.id_persona
                             JOIN reservacion_habitacion_tb  rh ON c.id_cliente = rh.id_cliente
                         WHERE
                             rh.fecha_entreda BETWEEN fecha_inicio AND fecha_fin
                         ORDER BY
                             p.nombre,
                             p.primer_apellido,
                             p.segundo_apellido;

    RETURN rc_clientes;
END;
/

--Ver resultado

DECLARE
    rc_result           SYS_REFCURSOR;
    v_id_cliente        NUMBER;
    v_nombre            VARCHAR2(100);
    v_primer_apellido   VARCHAR2(100);
    v_segundo_apellido  VARCHAR2(100);
BEGIN
    rc_result := listar_clientes_reservaciones(TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'));

    LOOP
        FETCH rc_result INTO
            v_id_cliente,
            v_nombre,
            v_primer_apellido,
            v_segundo_apellido;
        EXIT WHEN rc_result%notfound;
        dbms_output.put_line(v_id_cliente
                             || ' - '
                             || v_nombre
                             || ' '
                             || v_primer_apellido
                             || ' '
                             || v_segundo_apellido);

    END LOOP;

    CLOSE rc_result;
END;
/

--Funcion para obtener el total de clientes unicos(15)


CREATE OR REPLACE FUNCTION obtener_total_clientes_unicos RETURN NUMBER IS
    v_total_clientes NUMBER;
BEGIN
    SELECT
        COUNT(DISTINCT id_cliente)
    INTO v_total_clientes
    FROM
        reservacion_habitacion_tb;

    RETURN v_total_clientes;
END;
/


--Ver resultado

DECLARE
    v_num_clientes NUMBER;
BEGIN
    v_num_clientes := obtener_total_clientes_unicos;
    DBMS_OUTPUT.PUT_LINE('Número total de clientes únicos: ' || v_num_clientes);
END;


















