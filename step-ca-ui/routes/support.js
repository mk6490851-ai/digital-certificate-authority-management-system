const express = require("express");
const router = express.Router();
const db = require("../db");
const { logAction } = require("../middleware/auditLogger");

// ================== Middlewares ==================
function ensureUser(req, res, next) {
  if (req.isAuthenticated() && req.user.role === "USER") {
    return next();
  }
  return res.redirect("/login");
}

function ensureManager(req, res, next) {
  if (req.isAuthenticated() && req.user.role === "CA_MANAGER") {
    return next();
  }
  return res.redirect("/login");
}

// ================== USER: Send Support Message ==================
router.post("/support", ensureUser, async (req, res) => {
  try {
    const { message } = req.body;

    if (!message || message.trim() === "") {
      return res.status(400).send("Message is required");
    }

    // ✅ Insert message into DB
    const [result] = await db.query(
      "INSERT INTO support_messages (user, message, created_at) VALUES (?, ?, NOW())",
      [req.user.username, message]
    );

    // ✅ Audit log
    await logAction(
      req.user.username,
      "SUPPORT_MESSAGE_SENT",
      `User ${req.user.username} sent support message (ID=${result.insertId}): "${message.substring(0, 80)}"`
    );

    res.redirect("/dashboard?msg=support_sent");
  } catch (err) {
    console.error("Error saving support message:", err.message);
    res.status(500).send("Error sending support message");
  }
});

// ================== MANAGER: Reply to Support Message ==================
router.post("/support/reply/:id", ensureManager, async (req, res) => {
  const { id } = req.params;
  const { reply } = req.body;

  try {
    if (!reply || reply.trim() === "") {
      return res.redirect("/dashboard?msg=reply_empty");
    }

    // ✅ Get the original user message
    const [rows] = await db.query(
      "SELECT user, message FROM support_messages WHERE id = ?",
      [id]
    );

    if (rows.length === 0) {
      return res.status(404).send("Message not found");
    }

    const originalUser = rows[0].user;
    const originalMessage = rows[0].message;

    // ✅ Update reply in DB
    await db.query(
      "UPDATE support_messages SET reply = ?, replied_at = NOW() WHERE id = ?",
      [reply, id]
    );

    // ✅ Audit log
    await logAction(
      req.user.username,
      "SUPPORT_MESSAGE_REPLIED",
      `Manager ${req.user.username} replied to ${originalUser}'s message (ID=${id}): "${reply.substring(0, 80)}"`
    );

    res.redirect("/dashboard?status=replied");
  } catch (err) {
    console.error("Error saving reply:", err.message);
    res.status(500).send("Error saving reply");
  }
});

module.exports = router;
