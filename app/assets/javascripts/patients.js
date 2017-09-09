$(document).on('turbolinks:load', function() {
    $('#patients-table').bootstrapTable({
        onClickRow: function (row, $element) {
          window.location = $element.data('url');
        }
    });

    $('#pp_same').change(function() {
        if(this.checked) {
            $('#present_address').prop("disabled", true);
        } else {
            $('#present_address').prop("disabled", false);
        }
    });
});
