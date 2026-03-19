const express = require("express");
const bcrypt = require("bcryptjs");
const crypto = require("crypto");
const nodemailer = require("nodemailer");
const db = require("../db");
const { logAction } = require("../middleware/auditLogger");
require("dotenv").config();

const router = express.Router();

// ================== EMAIL SETUP ==================
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

// ================== SEND OTP ==================
router.post("/staff/send-otp", async (req, res) => {
  const { email } = req.body;

  if (!email)
    return res.status(400).json({ success: false, message: "Email is required" });

  try {
    // ✅ check if already registered
    const [exists] = await db.query("SELECT * FROM staff WHERE email = ?", [email]);
    if (exists.length > 0) {
      return res.json({ success: false, message: "This email is already registered." });
    }

    // ✅ generate OTP and expiry
    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    const expiresAt = new Date(Date.now() + 60 * 60 * 1000); // 1 hour

    // ✅ remove old OTP, insert new one
    await db.query("DELETE FROM staff_otps WHERE email = ?", [email]);
    await db.query(
      "INSERT INTO staff_otps (email, otp, expires_at) VALUES (?,?,?)",
      [email, otp, expiresAt]
    );

    // ✅ send email
    await transporter.sendMail({
      from: `"WCA Management" <${process.env.EMAIL_USER}>`,
      to: email,
      subject: "Your Staff Registration OTP",
      html: `
        <h3>Your OTP for registration</h3>
        <p><b>${otp}</b> is your verification code. It will expire in <b>1 hour</b>.</p>
        <p>If you didn’t request this, ignore this email.</p>
      `,
    });

    return res.json({ success: true, message: "OTP sent successfully! Please check your email." });
  } catch (err) {
    console.error("Error sending OTP:", err);
    res.status(500).json({ success: false, message: "Error sending OTP. Try again later." });
  }
});

// ================== REGISTER ==================
router.post("/staff/register", async (req, res) => {
  const { username, phone, email, password, confirmPassword, otp, role } = req.body;

  //  Field validation
  if (!username || !phone || !email || !password || !confirmPassword || !otp || !role) {
    return res.render("staff_register", {
      error: "All fields are required.",
      message: null,
    });
  }

  if (password !== confirmPassword) {
    return res.render("staff_register", {
      error: "Passwords do not match.",
      message: null,
    });
  }

  try {
    // Verify OTP
    const [otpData] = await db.query(
      "SELECT * FROM staff_otps WHERE email = ? AND otp = ?",
      [email, otp]
    );

    if (otpData.length === 0) {
      return res.render("staff_register", {
        error: "Invalid OTP.",
        message: null,
      });
    }

    if (new Date(otpData[0].expires_at) < new Date()) {
      return res.render("staff_register", {
        error: "OTP expired.",
        message: null,
      });
    }

    // Hash password
    const hashed = await bcrypt.hash(password, 10);

    //  Insert into staff table
    await db.query(
      "INSERT INTO staff (username, phone, email, password, role, created_at) VALUES (?,?,?,?,?,NOW())",
      [username, phone, email, hashed, role.toUpperCase()]
    );

    // Remove OTP after success
    await db.query("DELETE FROM staff_otps WHERE email = ?", [email]);

    // Log action
    try {
      await logAction(
        username,
        "STAFF_REGISTER",
        `New staff (${role.toUpperCase()}) registered: ${username}`
      );
    } catch (logErr) {
      console.error("Audit log failed:", logErr);
    }

    //  Redirect to login with success message
    res.render("staff_login", {
      error: null,
      message: "Registration successful! You can now login.",
    });
  } catch (err) {
    console.error("❌ Registration error:", err);
    res.render("staff_register", {
      error: "Server error. Try again later.",
      message: null,
    });
  }
});

module.exports = router;
