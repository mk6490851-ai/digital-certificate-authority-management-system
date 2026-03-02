const express = require("express");
const passport = require("passport");
const bcrypt = require("bcryptjs");
const db = require("../db");
const { logAction } = require("../middleware/auditLogger");

const router = express.Router();

// ===================== LOGIN =====================
router.get("/login", (req, res) => {
  res.render("login", { error: req.query.error || null });
});

router.post(
  "/login",
  passport.authenticate("user-local", {
    failureRedirect: "/login?error=1", 
  }),
  async (req, res) => {
    try {
      // ✅ audit log 
      await logAction(
        req.user.username,
        "USER_LOGIN",
        `User ${req.user.username} logged in`
      );
    } catch (err) {
      console.error("Audit log error:", err);
    }
    res.redirect("/dashboard");
  }
);

// ===================== REGISTER =====================
router.get("/register", (req, res) => {
  res.render("register", { error: null });
});

router.post("/register", async (req, res) => {
  const { username, phone, email, password, confirmPassword } = req.body;
  if (!username || !phone || !email || !password || !confirmPassword) {
    return res.render("register", { error: "All fields are required" });
  }

  if (password !== confirmPassword) {
    return res.render("register", { error: "Passwords do not match" });
  }

  try {
    const [existingUser] = await db.query(
      "SELECT * FROM users WHERE email = ? OR username = ?",
      [email, username]
    );

    if (existingUser.length > 0) {
      return res.render("register", {
        error: "Username or Email already registered",
      });
    }
    const hashedPassword = await bcrypt.hash(password, 10);
    await db.query(
      "INSERT INTO users (username, phone, email, password, role, created_at) VALUES (?,?,?,?,?,NOW())",
      [username, phone, email, hashedPassword, "USER"]
    );

    // ✅ Audit log
    await logAction(
      username,
      "USER_REGISTERED",
      `New user registered: ${username}`
    );

    res.redirect("/login");
  } catch (err) {
    console.error("Register Error:", err);
    res.render("register", { error: "Something went wrong, try again." });
  }
});

// ===================== LOGOUT =====================
router.get("/logout", async (req, res) => {
  const user = req.user; 

  req.logout(async () => {
    try {
      if (user) {
        await logAction(
          user.username,
          "USER_LOGOUT",
          `${user.role} ${user.username} logged out`
        );
      }
    } catch (err) {
      console.error("Audit log error (logout):", err);
    }

    if (user && (user.role === "ADMIN" || user.role === "CA_MANAGER")) {
      return res.redirect("/staff/login"); 
    }
    return res.redirect("/login"); 
  });
});

module.exports = router;
