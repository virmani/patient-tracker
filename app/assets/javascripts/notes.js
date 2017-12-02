$(document).on('turbolinks:load', function() {

    var diagnoses = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.whitespace,
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        prefetch: {
            url: '/typeahead/diagnoses',
            ttl: 30000
        }
      });
  
      var surgeries = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.whitespace,
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        prefetch: {
            url: '/typeahead/surgeries',
            ttl: 30000
        }
      });
  
      $('#diagnosis-div .typeahead').typeahead({
        hint: true,
        highlight: true,
        minLength: 1
      },
      {
        name: 'diagnosis',
        source: diagnoses
      });    
  
      $('#surgeries-div .typeahead').typeahead({
        hint: true,
        highlight: true,
        minLength: 1
      },
      {
        name: 'surgery',
        source: surgeries
      });    
});
