const { exec } = require("child_process");

module.exports = {
  run: function (cmd, cb, ecb) {
    exec(cmd, (error, stdout, stderr) => {
      if(error || stderr)
        console.log(error,stderr)

      if (error) {
        if (ecb) {
          ecb(error, stderr);
        } else {
          console.log(`${error} ${stderr}`);
        }
        return;
      }
      cb(stdout);
    });
  },
};
