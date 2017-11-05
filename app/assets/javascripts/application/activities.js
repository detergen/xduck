$(document).ready(function(){
  $('.bdatepicker').datepicker({
    dateFormat: 'yy-mm-dd'
  });

  var setBankAccAutoSelect = function(organization_selector, bankacc_selector) {
    $(organization_selector).change(function(event) {
      var organizationId = event.target.value;
      $.get('/bankaccs?organization_id=' + organizationId, function(results) {
        var bankAccount = results && results[0];

        // Set the value, creating a new option if necessary
        if ($(bankacc_selector).find("option[value='" + bankAccount.id + "']").length) {
          $(bankacc_selector).val(bankAccount.id).trigger('change');
        } else { 
          // Create a DOM Option and pre-select by default
          var newOption = new Option(bankAccount.name, bankAccount.id, true, true);
          // Append it to the select
          $(bankacc_selector).append(newOption).trigger('change');
        }
      });
    });
  };

  setBankAccAutoSelect('.activity_from_organization_id', '.activity_from_bankacc_id select');
  setBankAccAutoSelect('.activity_to_organization_id', '.activity_to_bankacc_id select');
  
  $('.activity_from_bankacc_id select').select2({
    theme: "bootstrap",
    ajax: {
      url: window.location.origin + '/bankaccs',
      dataType: 'json',
      processResults: function (data) {
        console.log(data);
        return {
          results: $.map(data, function(a){
            return {id: a.id, text: a.name};
          })
        };
      },
      data: function (params) {
        var organization_id = $('#activity_from_organization_id').val();
        return {organization_id: organization_id};
      }
    }

  });

  $('.activity_to_bankacc_id select').select2({
    theme: "bootstrap",
    ajax: {
      url: window.location.origin + '/bankaccs',
      dataType: 'json',
      processResults: function (data) {
        return {
          results: $.map(data, function(a){
            return {id: a.id, text: a.name};
          })
        };
      },
      data: function (params) {
        var organization_id = $('#activity_to_organization_id').val();
        return {organization_id: organization_id};
      }
    }
  });

  $('#swith-organisations').click(function() {
    var fromOrganisationId = $('#activity_from_organization_id').val();
    var toOrganisationId = $('#activity_to_organization_id').val();

    $('#activity_from_organization_id').val(toOrganisationId);
    $('#activity_to_organization_id').val(fromOrganisationId);


    var fromBankAccs = $('#activity_from_bankacc_id').html();
    var toBankAccs = $('#activity_to_bankacc_id').html();

    $('#activity_from_bankacc_id').html(toBankAccs);
    $('#activity_to_bankacc_id').html(fromBankAccs);

  })
});
