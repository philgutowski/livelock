$(function() {

  var handler = StripeCheckout.configure({
    key: window.stripe_key,
    // image: '/square-image.png',
    token: function(token) {
      // Use the token to create the charge with a server-side script.
      // You can access the token ID with `token.id`
    }
  });

  $("form#new_booking").submit(function(event){
    event.preventDefault();
    $.ajax({
      url: "/costs",
      method: "POST"
    })
    .done(function(cost) {
      handler.open({
        name: 'Demo Site',
        description: 'Studio Session',
        amount: cost
      })
    })
  });
  });
