var xhr = new XMLHttpRequest();
xhr.open("GET", "https://i.imgur.com/sBJOoTm.png", true);

xhr.responseType = "blob";

debugger
xhr.onload = function(e) {
  if (this.status == 200) {
    var blob = this.response;
    document.getElementById("myImage").src = window.URL.createObjectURL(blob);
  }
};

xhr.onerror = function(e) {
  alert("Error " + e.target.status + " occurred while receiving the document.");
};

xhr.send();

