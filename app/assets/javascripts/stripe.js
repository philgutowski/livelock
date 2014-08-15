$(function() {

  var totalPrice = function() {
    var prices = 0;
    $("input:checked").each(function() {
      prices += (
        parseInt($(this).attr("data-price"), 10)
      );
    });
    return prices;
  };

  var handler = StripeCheckout.configure({
    key: window.stripe_key,
    // image: '/square-image.png',
    token: function(token) {
      // Use the token to create the charge with a server-side script.
      // You can access the token ID with `token.id`
      console.log("here 1");
      $("#token").val(token);
      console.log("here 2");
      $("form#new_booking").unbind("submit");
      console.log("here 3");
      $("form#new_booking").submit();
      console.log("here 4");
    }
  });

  $( "input[type=checkbox]" ).on( "click", function(){
    $("#total-price").text(totalPrice() / 100);
  });

  $("form#new_booking").submit(function(event){
    event.preventDefault();
    handler.open({
      name: 'Shipyard Rehearsals',
      description: 'Studio Sessions',
      amount: totalPrice()
    })
  });
});
