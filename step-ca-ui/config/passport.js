const passport = require("passport");
const LocalStrategy = require("passport-local").Strategy;
const bcrypt = require("bcryptjs");
const db = require("../db"); // mysql connection

/* ================= Passport Local Strategy (Users) ================= */
passport.use(
  "user-local",
  new LocalStrategy(
    { usernameField: "username", passwordField: "password" },
    async (username, password, done) => {
      try {
        const [rows] = await db.query("SELECT * FROM users WHERE username = ?", [
          username,
        ]);
        if (rows.length === 0) {
          return done(null, false, { message: "User not found" });
        }

        const user = rows[0];
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
          return done(null, false, { message: "Invalid password" });
        }

        return done(null, { ...user, type: "user" });
      } catch (err) {
        return done(err);
      }
    }
  )
);

/* ================= Passport Local Strategy (Staff: Admin/Manager) ================= */
passport.use(
  "staff-local",
  new LocalStrategy(
    { usernameField: "username", passwordField: "password" },
    async (username, password, done) => {
      try {
        const [rows] = await db.query("SELECT * FROM staff WHERE username = ?", [
          username,
        ]);
        if (rows.length === 0) {
          return done(null, false, { message: "Staff not found" });
        }

        const staff = rows[0];
        const isMatch = await bcrypt.compare(password, staff.password);
        if (!isMatch) {
          return done(null, false, { message: "Invalid password" });
        }

        return done(null, { ...staff, type: "staff" });
      } catch (err) {
        return done(err);
      }
    }
  )
);

// ================= Serialize / Deserialize =================
passport.serializeUser((user, done) => {
  done(null, { id: user.id, type: user.type });
});

passport.deserializeUser(async (obj, done) => {
  try {
    if (obj.type === "user") {
      const [rows] = await db.query("SELECT * FROM users WHERE id = ?", [obj.id]);
      if (rows.length === 0) return done(null, false);
      return done(null, rows[0]);
    } else if (obj.type === "staff") {
      const [rows] = await db.query("SELECT * FROM staff WHERE id = ?", [obj.id]);
      if (rows.length === 0) return done(null, false);
      return done(null, rows[0]);
    }
    done(null, false);
  } catch (err) {
    done(err);
  }
});

module.exports = passport;
