const express = require("express");
const router = express.Router();
const db = require("../db");

// ✅ Middleware to check admin access
function ensureAdmin(req, res, next) {
  if (req.isAuthenticated() && req.user.role === "ADMIN") {
    return next();
  }
  return res.redirect("/login");
}

// ================== ADMIN DASHBOARD ==================
router.get("/admin/dashboard", ensureAdmin, (req, res) => {
  // Fetch all required data
  const statsQuery = `
    SELECT
      (SELECT COUNT(*) FROM users) AS totalUsers,
      (SELECT COUNT(*) FROM users WHERE role='ADMIN') AS admins,
      (SELECT COUNT(*) FROM users WHERE role='CA_MANAGER') AS managers,
      (SELECT COUNT(*) FROM certificates) AS certificates,
      (SELECT COUNT(*) FROM audit_logs) AS logs
  `;

  const usersQuery =
    "SELECT username, role, created_at FROM users";

  const logsQuery =
    "SELECT username, action, timestamp FROM audit_logs ORDER BY timestamp DESC LIMIT 50";

  const supportQuery =
    "SELECT user, message, created_at FROM support_messages ORDER BY created_at DESC";

  db.query(statsQuery, (err, statsResult) => {
    if (err) {
      console.error("Error fetching stats:", err);
      return res.status(500).send("DB Error (stats)");
    }

    db.query(usersQuery, (err, usersResult) => {
      if (err) {
        console.error("Error fetching users:", err);
        return res.status(500).send("DB Error (users)");
      }

      db.query(logsQuery, (err, logsResult) => {
        if (err) {
          console.error("Error fetching logs:", err);
          return res.status(500).send("DB Error (logs)");
        }

        db.query(supportQuery, (err, messagesResult) => {
          if (err) {
            console.error("Error fetching support messages:", err);
            return res.status(500).send("DB Error (support)");
          }

          res.render("admindashboard", {
            user: req.user,
            stats: statsResult[0],
            allUsers: usersResult,
            logs: logsResult,
            messages: messagesResult,
          });
        });
      });
    });
  });
});

module.exports = router;
