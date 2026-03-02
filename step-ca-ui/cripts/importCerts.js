const { importAllCerts } = require("../helpers");

module.exports = async function () {
  try {
    await importAllCerts();
  } catch {
    // silent
  }
};

module.exports = { importAllCerts };
