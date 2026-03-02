const path = require("path");

module.exports = {
  STEP_BIN: `"C:/step_0.28.7/bin/step.exe"`,
  ROOT_CA: "C:/Users/Dell/Documents/step-ca-ui/ca/root_ca.crt",
  PASS_FILE: "C:/step_0.28.7/prov-pass.txt",
  CERTS_DIR: path.join(__dirname, "certs"), 
  PROVISIONER: "admin@wacman.com",
  CA_URL: "https://127.0.0.1:8443"
};
