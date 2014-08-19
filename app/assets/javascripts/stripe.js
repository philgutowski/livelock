$(function() {

  var totalPrice = function() {
    var prices = 0;
    $("input:checked").each(function() {
      prices += parseInt($(this).attr("data-price"), 10);
    });
    return prices;
  };

  var $form = $("form#new_booking");

  var handler = StripeCheckout.configure({
    key: window.stripe_key,
      token: function(response) {
        $("#token").val(response.id);
        $form.unbind("submit");
        $form.submit();
      }
  });

  $("input[type=checkbox]").on("click", function(){
    $("#total-price").text(totalPrice() / 100);
  });

  $form.submit(function(event){
    event.preventDefault();
    if ( $( ".required" ).val().length === 0 ) {
      console.log("There are empty fields in the form");
      $(".form-error").text("This field is required");
      return false;
    } else {
      handler.open({
        name: 'Shipyard Rehearsals',
        description: 'Studio Sessions',
        amount: totalPrice()
      });
    }
  });
});
