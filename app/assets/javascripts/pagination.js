$(function() {
  $(".icon-arrow-right").click(function() {
    console.log("hey");
  });

  $("#next").on("ajax:success", function() {
  console.log("clicked");
  });
});
