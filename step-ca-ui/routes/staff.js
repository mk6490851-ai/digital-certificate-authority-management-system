const express = require("express");
const bcrypt = require("bcryptjs");
const passport = require("passport");
const db = require("../db");
const { logAction } = require("../middleware/auditLogger");

const router = express.Router();

// ===================== GET Routes =====================

// Staff Register page
router.get("/staff/register", (req, res) => {
  res.render("staff_register", { error: null, message: null });
});

// Staff Login page
router.get("/staff/login", (req, res) => {
  const errorMsg =
    req.query.error === "1"
      ? "Invalid username or password"
      : req.query.error || null;
  const message = req.query.message || null;

  res.render("staff_login", { error: errorMsg, message });
});

// ===================== POST Routes =====================

// Staff Register
router.post("/staff/register", async (req, res) => {
  const { username, phone, email, password, confirmPassword, role } = req.body;

  try {
    // ✅ Password confirmation
    if (password !== confirmPassword) {
      return res.render("staff_register", {
        error: "Passwords do not match",
        message: null,
      });
    }

    // ✅ Valid roles check
    const validRoles = ["ADMIN", "CA_MANAGER"];
    if (!validRoles.includes(role.toUpperCase())) {
      return res.render("staff_register", {
        error: "Invalid role selected",
        message: null,
      });
    }

    // ✅ Check if username/email already exists
    const [existingUser] = await db.query(
      "SELECT * FROM staff WHERE username = ? OR email = ?",
      [username, email]
    );

    if (existingUser.length > 0) {
      return res.render("staff_register", {
        error: "Username or Email already taken",
        message: null,
      });
    }

    // ✅ Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // ✅ Insert staff into DB
    await db.query(
      "INSERT INTO staff (username, phone, email, password, role, created_at) VALUES (?,?,?,?,?,NOW())",
      [username, phone, email, hashedPassword, role.toUpperCase()]
    );

    // ✅ Audit log
    await logAction(
      username,
      "STAFF_REGISTERED",
      `New staff registered: ${username} (${role.toUpperCase()})`
    );

    // ✅ Redirect with success message
    res.redirect(
      "/staff/login?message=Registration successful! You can now log in."
    );
  } catch (err) {
    console.error("❌ Error registering staff:", err);
    res.render("staff_register", {
      error: "Something went wrong, please try again.",
      message: null,
    });
  }
});

// Staff Login
router.post(
  "/staff/login",
  passport.authenticate("staff-local", {
    failureRedirect: "/staff/login?error=1",
  }),
  async (req, res) => {
    try {
      await logAction(
        req.user.username,
        "STAFF_LOGIN",
        `Staff ${req.user.username} logged in (${req.user.role})`
      );
    } catch (err) {
      console.error("Audit log error (staff login):", err);
    }
    res.redirect("/dashboard");
  }
);

// Staff Logout
router.get("/staff/logout", (req, res) => {
  const staff = req.user; // preserve staff info

  req.logout(async () => {
    try {
      if (staff) {
        await logAction(
          staff.username,
          "STAFF_LOGOUT",
          `Staff ${staff.username} logged out (${staff.role})`
        );
      }
    } catch (err) {
      console.error("Audit log error (staff logout):", err);
    }

    res.redirect("/staff/login?message=You have been logged out successfully.");
  });
});

module.exports = router;
