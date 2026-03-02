// middleware/auditLogger.js
const db = require("../db");

// ✅ Centralized Audit Logger
async function logAction(username, action, details = null) {
  try {
    await db.query(
      "INSERT INTO audit_logs (username, action, details, timestamp) VALUES (?, ?, ?, NOW())",
      [username, action, details]
    );
  } catch (err) {
    console.error("❌ Audit Log Error:", err.message);
  }
}

module.exports = { logAction };

