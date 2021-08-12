
$("#myForm").submit(function(e) {
  e.preventDefault();
  var formData = new FormData(this);

  $.ajax({
    url: "/upload",
    type: "POST",
    data: formData,
    success: function(data) {
      alert(data);
    },
    cache: false,
    contentType: false,
    processData: false,
  });
});

