

$("#arrayForm").submit(function(e) {
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

// $("#textAndArrayForm").submit(function (e) {
//   e.preventDefault();
//   var formData = new FormData();
//   formData.append("name", "cwz");
//   $.ajax({
//     url: "/upload",
//     type: "POST",
//     data: formData,
//     success: function (data) {
//       alert(data);
//     },
//     cache: false,
//     contentType: false,
//     processData: false,
//   });
// });
