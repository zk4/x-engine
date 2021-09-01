"use strict";

var fs = require("fs");
var StreamZip = require("node-stream-zip");

var zip = new StreamZip({
  file: "../../zip/com.zkty.microapp.home.2.zip",
  storeEntries: true,
});

zip.on("error", function(err) {
  console.error("[ERROR]", err);
});

zip.on("ready", function() {
  console.log("All entries read: " + zip.entriesCount);
});

zip.on("entry", function(entry) {
  if ("/" === entry.name[entry.name.length - 1]) {
    return;
  }

  zip.stream(entry.name, function(err, stream) {
    if (err) {
      console.error("Error:", err.toString());
      return;
    }

    stream.on("error", function(err) {
      console.log("[ERROR]", err);
      return;
    });

    var string = "";
    stream.on("data", function(data) {
      string += data.toString();
    });

    stream.on("end", function() {
      if (entry.name === "microapp.json") {
        let microappJson = JSON.parse(string);
        console.log("id:", microappJson.id);
        console.log("version:", microappJson.version);
      }
    });
  });
});

