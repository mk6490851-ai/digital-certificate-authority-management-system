
const express = require("express");
const bcrypt = require("bcryptjs");
const db = require("../db");
const { logAction } = require("../middleware/auditLogger");

const router = express.Router();

// Render forgot page
router.get("/forgot", (req, res) => {
  res.render("forgot", { error: null, message: null });
});

// Handle password reset
router.post("/forgot", async (req, res) => {
  const { username, newPassword, confirmPassword } = req.body;

  if (!username || !newPassword || !confirmPassword) {
    return res.render("forgot", { error: "All fields are required", message: null });
  }

  if (newPassword !== confirmPassword) {
    return res.render("forgot", { error: "Passwords do not match", message: null });
  }

  try {
    const [user] = await db.query("SELECT * FROM users WHERE username = ?", [username]);

    if (!user || user.length === 0) {
      return res.render("forgot", { error: "User not found", message: null });
    }

    const hashedPassword = await bcrypt.hash(newPassword, 10);
    await db.query("UPDATE users SET password = ? WHERE username = ?", [hashedPassword, username]);

    res.render("forgot", { error: null, message: "Password updated successfully! You can now login." });
  } catch (err) {
    console.error("Password reset error:", err);
    res.render("forgot", { error: "Something went wrong, please try again.", message: null });
  }
});

module.exports = router;
