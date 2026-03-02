const express = require("express");
const db = require("../db");
const { loadAllCAs } = require("../helpers");
const { logAction } = require("../middleware/auditLogger");
const moment = require("moment-timezone");

const router = express.Router();

/**
 * ==============================
 * DASHBOARD ROUTE
 * ==============================
 * Role-based rendering:
 *  - USER
 *  - ADMIN
 *  - CA_MANAGER / MANAGER
 * ==============================
 */
router.get("/dashboard", async (req, res) => {
  if (!req.isAuthenticated()) return res.redirect("/login");

  try {
    const role = req.user.role;
    const username = req.user.username;

    // ===================== USER =====================
    if (role === "USER") {
      try {
        // ✅ Fetch user certificates
        const [certs] = await db.query(
          "SELECT * FROM certificates WHERE owner = ? ORDER BY issued_at DESC",
          [username]
        );

        // Identify expiring soon (within 24 hours)
        const expiringSoon = certs.filter((c) => {
          if (!c.expiryDate) return false;
          const hoursLeft = moment(c.expiryDate).diff(moment(), "hours");
          return hoursLeft > 0 && hoursLeft <= 24;
        });

        //  Fetch support messages
        const [messages] = await db.query(
          "SELECT id, message, created_at, reply, replied_at FROM support_messages WHERE user = ? ORDER BY created_at DESC",
          [username]
        );

        return res.render("userdashboard", {
          user: req.user,
          certs,
          messages,
          expiringSoon,
        });
      } catch (err) {
        console.error("Error loading USER dashboard:", err);
        return res.status(500).send("Error loading user dashboard");
      }
    }

    // ===================== ADMIN =====================
    if (role === "ADMIN") {
      const [usersTable] = await db.query(
        "SELECT id, username, role, created_at FROM users"
      );
      const [staffTable] = await db.query(
        "SELECT id, username, role, created_at FROM staff"
      );
      const allUsers = [...usersTable, ...staffTable];

      const [logCount] = await db.query("SELECT COUNT(*) as total FROM audit_logs");
      const [logs] = await db.query(
        "SELECT * FROM audit_logs ORDER BY timestamp DESC LIMIT 200"
      );

      const [certificates] = await db.query("SELECT * FROM certificates");
      const [messages] = await db.query(
        "SELECT * FROM support_messages ORDER BY created_at DESC"
      );

      const stats = {
        totalUsers: allUsers.length,
        admins: allUsers.filter((u) => u.role === "ADMIN").length,
        managers: allUsers.filter(
          (u) => u.role === "CA_MANAGER" || u.role === "MANAGER"
        ).length,
        certificates: certificates.length,
        logs: logCount[0]?.total || 0,
      };

      return res.render("admindashboard", {
        user: req.user,
        certificates,
        allUsers,
        stats,
        logs,
        messages,
      });
    }

    // ===================== MANAGER / CA_MANAGER =====================
    if (role === "CA_MANAGER" || role === "MANAGER") {
      const [pendingRequests] = await db.query(
        "SELECT * FROM requests WHERE status = 'PENDING' ORDER BY created_at DESC"
      );
      const [acceptedRequests] = await db.query(
        "SELECT * FROM requests WHERE status = 'ACCEPTED' ORDER BY created_at DESC"
      );
      const [rejectedRequests] = await db.query(
        "SELECT * FROM requests WHERE status = 'REJECTED' ORDER BY created_at DESC"
      );

      const [revokedCertificates] = await db.query(
        "SELECT * FROM certificates WHERE status = 'REVOKED' ORDER BY issued_at DESC"
      );
      const [renewedCertificates] = await db.query(
        "SELECT * FROM certificates WHERE status = 'RENEWED' ORDER BY issued_at DESC"
      );
      const [certificates] = await db.query(
        "SELECT * FROM certificates ORDER BY issued_at DESC"
      );

      const [messages] = await db.query(
        "SELECT * FROM support_messages ORDER BY created_at DESC"
      );

      let caInfo = [];
      try {
        if (typeof loadAllCAs === "function") {
          caInfo = await loadAllCAs();
        }
      } catch {
        // ignore silently
      }

      const message = req.session?.message;
      if (req.session) delete req.session.message;

      return res.render("managerdashboard", {
        user: req.user,
        certificates,
        pendingRequests,
        acceptedRequests,
        rejectedRequests,
        revokedCertificates,
        renewedCertificates,
        caInfo,
        messages,
        message,
      });
    }

    // ===================== UNKNOWN ROLE =====================
    return res.status(403).send("Role not recognized");
  } catch (err) {
    console.error("Error loading dashboard:", err);
    return res
      .status(500)
      .send("Error loading dashboard: " + (err.message || err));
  }
});

module.exports = router;
