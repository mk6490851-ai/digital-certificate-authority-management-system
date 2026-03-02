
// routes/registerRoutes.js
const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const crypto = require("crypto");
const fs = require("fs");
const path = require("path");

const USERS_FILE = path.join(__dirname, "../data/users.json");

// ============ Helper functions ============
function loadUsers() {
  if (!fs.existsSync(USERS_FILE)) return [];
  return JSON.parse(fs.readFileSync(USERS_FILE));
}

function saveUsers(users) {
  fs.writeFileSync(USERS_FILE, JSON.stringify(users, null, 2));
}

// ============ Nodemailer setup ============
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "your_email@gmail.com", // ⚠️ change this
    pass: "your_app_password",    // ⚠️ create an App Password in Gmail
  },
});

// ===============================
// 🧩 REGISTER + OTP
// ===============================
router.get("/register", (req, res) => {
  res.render("register", { error: null });
});

router.post("/register", (req, res) => {
  const { username, email, phone, password, confirmPassword } = req.body;

  if (password !== confirmPassword) {
    return res.render("register", { error: "Passwords do not match!" });
  }

  let users = loadUsers();
  if (users.find((u) => u.email === email)) {
    return res.render("register", { error: "Email already registered!" });
  }

  const hashedPassword = bcrypt.hashSync(password, 10);
  const otp = crypto.randomInt(100000, 999999).toString();

  const newUser = {
    id: Date.now(),
    username,
    email,
    phone,
    password: hashedPassword,
    verified: false,
    otp,
  };

  users.push(newUser);
  saveUsers(users);

  // Send OTP email
  const mailOptions = {
    from: "CA Portal <your_email@gmail.com>",
    to: email,
    subject: "Your OTP for CA Portal Verification",
    text: `Your OTP is ${otp}. It will expire in 5 minutes.`,
  };

  transporter.sendMail(mailOptions, (err) => {
    if (err) {
      console.error("❌ Error sending OTP:", err);
      return res.render("register", { error: "Failed to send OTP email.",message:null });
    }
    res.redirect(`/verify-otp?email=${encodeURIComponent(email)}`);
  });
});

// ===============================
// 🧩 VERIFY OTP
// ===============================
router.get("/verify-otp", (req, res) => {
  const { email } = req.query;
  res.render("otp", { email, error: null });
});

router.post("/verify-otp", (req, res) => {
  const { email, otp } = req.body;
  let users = loadUsers();
  const user = users.find((u) => u.email === email);

  if (!user) return res.render("otp", { email, error: "User not found." });
  if (user.otp !== otp) return res.render("otp", { email, error: "Invalid OTP." });

  user.verified = true;
  delete user.otp;
  saveUsers(users);

  res.render("login", { message: "✅ Account verified! Please log in.", error: null });
});

// ===============================
// 🧩 LOGIN
// ===============================
router.get("/login", (req, res) => {
  res.render("login", { error: null, message: null });
});

router.post("/login", (req, res) => {
  const { username, password } = req.body;
  const users = loadUsers();
  const user = users.find((u) => u.username === username);

  if (!user) return res.render("login", { error: "User not found!", message: null });
  if (!user.verified)
    return res.render("login", { error: "Email not verified yet!", message: null });
  if (!bcrypt.compareSync(password, user.password))
    return res.render("login", { error: "Invalid password!", message: null });

  res.redirect("/dashboard");
});

// ===============================
// 🧩 FORGOT PASSWORD (Token-based)
// ===============================
router.get("/forgot-password", (req, res) => {
  res.render("forgot", { error: null, message: null });
});

router.post("/forgot-password", (req, res) => {
  const { email } = req.body;
  let users = loadUsers();
  const user = users.find((u) => u.email === email);

  if (!user) return res.render("forgot", { error: "Email not found!", message: null });

  // 🔥 Create secure reset token
  const resetToken = crypto.randomBytes(20).toString("hex");
  const resetTokenExpiry = Date.now() + 1000 * 60 * 15; // 15 mins

  user.resetToken = resetToken;
  user.resetTokenExpiry = resetTokenExpiry;
  saveUsers(users);

  const resetLink = `http://localhost:3000/reset-password?token=${resetToken}`;

  const mailOptions = {
    from: "CA Portal <your_email@gmail.com>",
    to: email,
    subject: "Password Reset Request",
    text: `You requested a password reset. Click this link: ${resetLink}\n\nThis link expires in 15 minutes.`,
  };

  transporter.sendMail(mailOptions, (err) => {
    if (err) {
      console.error("Error sending reset email:", err);
      return res.render("forgot", { error: "Failed to send email.", message: null });
    }
    res.render("forgot", { message: "Reset link sent to your email!", error: null });
  });
});

// ===============================
// 🧩 RESET PASSWORD FORM
// ===============================
router.get("/reset-password", (req, res) => {
  const { token } = req.query;
  res.render("reset", { token, error: null, message: null });
});

router.post("/reset-password", (req, res) => {
  const { token, password, confirmPassword } = req.body;
  let users = loadUsers();
  const user = users.find((u) => u.resetToken === token);

  if (!user) return res.render("reset", { error: "Invalid or expired token.", message: null });
  if (Date.now() > user.resetTokenExpiry)
    return res.render("reset", { error: "Token expired. Request again.", message: null });
  if (password !== confirmPassword)
    return res.render("reset", { error: "Passwords do not match!", message: null });

  user.password = bcrypt.hashSync(password, 10);
  delete user.resetToken;
  delete user.resetTokenExpiry;
  saveUsers(users);

  res.render("login", { message: "✅ Password reset successful! Please log in.", error: null });
});

module.exports = router;
