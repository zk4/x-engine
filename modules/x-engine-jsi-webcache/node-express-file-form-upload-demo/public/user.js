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

function getImage() {
  var xhr = new XMLHttpRequest();
  xhr.open(
    "GET",
    "https://i.imgur.com/sBJOoTm.png",
    true
  );

  xhr.responseType = "blob";

  xhr.onload = function(e) {
    if (this.status == 200) {
      var blob = this.response;
      document.getElementById("myImage").src = window.URL.createObjectURL(blob);
    }
  };

  xhr.onerror = function(e) {
    alert(
      "Error " + e.target.status + " occurred while receiving the document."
    );
  };

  xhr.send();
}

