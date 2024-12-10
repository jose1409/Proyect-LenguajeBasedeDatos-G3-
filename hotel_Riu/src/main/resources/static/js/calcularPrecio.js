function calcularPrecio() {
    let habitacionSelect = document.getElementById('floatingHabitacion');
    let precio = habitacionSelect.options[habitacionSelect.selectedIndex]?.dataset.precio; // Obtener el precio desde data-precio
    
    let descuento = document.getElementById('floatingDescuento').value;
    let fecha1 = document.getElementById('floatingFechaEntrada').value;
    let fecha2 = document.getElementById('floatingFechaSalida').value;
    let total = document.getElementById('floatingTotalPagar');

    // Verificar que las fechas no sean null, vacías o inválidas
    if (!fecha1 || !fecha2) {
        alert('Por favor, selecciona ambas fechas (entrada y salida) antes de calcular el precio.');
        return;
    }

    // Opcional: Verificar que la fecha de entrada no sea mayor que la de salida
    if (new Date(fecha1) > new Date(fecha2)) {
        alert('La fecha de entrada no puede ser posterior a la fecha de salida.');
        return;
    }

    // Ejecutar la solicitud AJAX si todas las verificaciones pasan
    $.ajax({
        type: "GET",
        url: `/reservacionHabitacion/precioTotal/${encodeURIComponent(precio)}/${encodeURIComponent(descuento)}/${encodeURIComponent(fecha1)}/${encodeURIComponent(fecha2)}`,
        success: function (data) {
            total.value = data;
        },
        error: function () {
            alert('Error al calcular el precio.');
        }
    });
}
