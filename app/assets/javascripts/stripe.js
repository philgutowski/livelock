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
    handler.open({
      name: 'Shipyard Rehearsals',
      description: 'Studio Sessions',
      amount: totalPrice()
    });
  });
});
