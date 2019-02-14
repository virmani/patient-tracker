$(document).on('turbolinks:load', function() {
  $("#patient-search-select").val("1");
  var diagnoses_flag = false;
  var diagnoses_data = [];
  var select = $("#patient-search-select").val();
  $('#patient-search-select').on('change', function(e) {
    select = $("#patient-search-select").val();
    if(select == 2 && diagnoses_flag == false) {
        diagnoses_data = $.ajax({url: "/typeahead/search", success: function(result) {
          diagnoses_data = result;
        }, dataType:"json"});
        diagnoses_flag = true;
    }
  });

  $("#patient-search").on('keyup',function() {
    var val = this.value.toLowerCase();
    if(select == 1 || select == 3) {
      $("#patients-table tbody").find("tr").each(function(i) {
        var t = $($(this).find("td")[select]).text().toLowerCase();
        if(t.indexOf(val)!=0) {
          $(this).hide();
        }
        else {
          $(this).show();
        }
      });
    }
    else {
      if(select == 2) {
        var matched_el = [];
        for(i=0;i<diagnoses_data.length;i++) {
          var str = diagnoses_data[i][1].toLowerCase();
          if(str.indexOf(val) == 0) {
            matched_el.push(diagnoses_data[i][0]);
          }
        }
        $("#patients-table tbody").find("tr").each(function(i) {
          var el_id=parseInt($($(this).find("td")[0]).text());
          if(matched_el.indexOf(el_id) != -1) {
            $(this).show();
          }
          else {
            $(this).hide();
          }
        });
      }
    }
  });
});