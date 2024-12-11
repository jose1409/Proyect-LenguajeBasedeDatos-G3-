function loadComponent(url, type) {
        $.ajax({
            url: url,
            type: type,
            success: function(data) {
                $('#content-container').html(data);
            },
            error: function() {
                alert('Error loading component');
            }
        });
    }

