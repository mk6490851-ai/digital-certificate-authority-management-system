const express = require("express");
const bcrypt = require("bcryptjs");
const crypto = require("crypto");
const nodemailer = require("nodemailer");
const db = require("../db");
const { logAction } = require("../middleware/auditLogger");

const router = express.Router();

// ====================== ✉️ Email Transporter ======================
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

// ====================== 1️⃣ Forgot Password Form ======================
router.get("/staff/forgot", (req, res) => {
  res.render("staffForgot", { error: null, message: null });
});

// ====================== 2️⃣ Handle Forgot Password Request ======================
router.post("/staff/forgot", async (req, res) => {
  const { username, email } = req.body;

  if (!username || !email) {
    return res.render("staffForgot", { error: "All fields required", message: null });
  }

  try {
    // Find staff
    const [staff] = await db.query("SELECT * FROM staff WHERE username = ? AND email = ?", [
      username,
      email,
    ]);

    if (!staff || staff.length === 0) {
      return res.render("staffForgot", { error: "No matching staff found", message: null });
    }

    const staffData = staff[0];

    // Generate reset token and expiry (1 hour)
    const token = crypto.randomBytes(32).toString("hex");
    const expiry = new Date(Date.now() + 3600000);

    await db.query("UPDATE staff SET reset_token = ?, reset_expires = ? WHERE id = ?", [
      token,
      expiry,
      staffData.id,
    ]);

    // Send reset email
    const resetLink = `${process.env.BASE_URL}/staff/reset/${token}`;
    const mailOptions = {
      from: `"WCA Management System" <${process.env.EMAIL_USER}>`,
      to: staffData.email,
      subject: "Reset Your Staff Password - WCA Management System",
      html: `
        <h3>Hello ${staffData.username},</h3>
        <p>You requested a password reset. Click below to set a new password:</p>
        <p><a href="${resetLink}" style="color:blue;">Reset Password</a></p>
        <p>This link will expire in 1 hour.</p>
        <br><p>Best regards,<br><strong>WCA Management System</strong></p>
      `,
    };

    await transporter.sendMail(mailOptions);

    await logAction(
      staffData.username,
      "STAFF_PASSWORD_RESET_REQUEST",
      `Password reset email sent to ${staffData.email}`
    );

    res.render("staffForgot", {
      message: "A password reset link has been sent to your email.",
      error: null,
    });
  } catch (err) {
    console.error("❌ Error in password reset request:", err);
    res.render("staffForgot", { error: "Something went wrong", message: null });
  }
});

// ====================== 3️⃣ Reset Password Page ======================
router.get("/staff/reset/:token", async (req, res) => {
  const { token } = req.params;

  try {
    const [staff] = await db.query(
      "SELECT * FROM staff WHERE reset_token = ? AND reset_expires > NOW()",
      [token]
    );

    if (!staff || staff.length === 0) {
      return res.send("Invalid or expired token");
    }

    res.render("resetStaffPassword", { token, error: null, msg: null });
  } catch (err) {
    console.error(err);
    res.send("Error verifying token");
  }
});

// ====================== 4️⃣ Handle Password Reset Submission ======================
router.post("/staff/reset/:token", async (req, res) => {
  const { token } = req.params;
  const { newPassword, confirmPassword } = req.body;

  if (newPassword !== confirmPassword) {
    return res.render("resetStaffPassword", { token, error: "Passwords do not match", msg: null });
  }

  try {
    const [staff] = await db.query(
      "SELECT * FROM staff WHERE reset_token = ? AND reset_expires > NOW()",
      [token]
    );

    if (!staff || staff.length === 0) {
      return res.send("Invalid or expired token");
    }

    const hashedPassword = await bcrypt.hash(newPassword, 10);

    await db.query(
      "UPDATE staff SET password = ?, reset_token = NULL, reset_expires = NULL WHERE id = ?",
      [hashedPassword, staff[0].id]
    );
  // Render page with success message (shows alert)
    res.render("resetStaffPassword", { token: null, error: null, msg: "success" });
  } catch (err) {
    console.error("❌ Error resetting password:", err);
    res.render("resetStaffPassword", { token, error: "Error resetting password", msg: null });
  }
});

module.exports = router;

