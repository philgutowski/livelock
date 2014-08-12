// <script src="https://checkout.stripe.com/checkout.js"></script>
// <button id="customButton">Purchase</button>
function(){
  var handler = StripeCheckout.configure({
    key: 'pk_test_6pRNASCoBOKtIshFeQd4XMUh',
    image: '/square-image.png',
    token: function(token) {
      // Use the token to create the charge with a server-side script.
      // You can access the token ID with `token.id`
    }
  });

  //document.getElementById('customButton').addEventListener('click', function(e) {
  $("#customButton").click(function(event){
    // Open Checkout with further options
    handler.open({
      name: 'Demo Site',
      description: '2 widgets ($20.00)',
      amount: 2000
    });
    e.preventDefault();
  });
}();
