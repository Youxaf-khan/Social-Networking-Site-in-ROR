$(document).on("turbolinks:load", function () {

  $("#hehe").on("click", function(event) {
    event.preventDefault()

    $Rails.ajax({
      type: $(this).data("type"),
      url: $(this).data("url"),
      data: {
        id: "hasan",
      },
      // data: "your_form_data",
      success: function(result) {
      // Append the result to a table or list, $("list").append(result)
      },
    })
  });

});
