const { importAllCAs } = require("../helpers");

module.exports = async function () {
  try {
    await importAllCAs();
  } catch {
    // silent
  }
};
module.exports = { importAllCAs };
