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

    // constructs the suggestion engine
    var districts = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      // `states` is an array of state names defined in "The Basics"
      prefetch: '../typeahead/districts'
    });

  $('#district-div .typeahead').typeahead({
        hint: true,
        highlight: true,
        minLength: 1
      },
      {
        name: 'districts',
        source: districts
      });    
});
