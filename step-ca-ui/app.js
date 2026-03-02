const express = require("express");
const session = require("express-session");
const passport = require("passport");
const path = require("path");
const favicon = require("serve-favicon");
require("dotenv").config();
require("./certificateExpiryNotifier");
require("./certificateExpiryWatcher");

const { importAllCAs } = require("./scripts/importCAs");
const { importAllCerts } = require("./scripts/importCerts");

const db = require("./db");
require("./config/passport");

const app = express();

/* ======================
   View Engine
====================== */
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

/* ======================
   Middlewares
====================== */
app.use(express.static(path.join(__dirname, "public")));
app.use(favicon(path.join(__dirname, "public", "c-a.png")));
app.use(express.urlencoded({ extended: false }));
app.use(express.urlencoded({ extended: true }));
app.use(express.json()); 

app.use(
  session({
    secret: process.env.SESSION_SECRET || "secret",
    resave: false,
    saveUninitialized: false,
  })
);

app.use(passport.initialize());
app.use(passport.session());

/* ======================
   Routes
====================== */
const authRoutes = require("./routes/auth");
const staffRoutes = require("./routes/staff");
const dashboardRoutes = require("./routes/dashboard");
const requestRoutes = require("./routes/requests");
const certRoutes = require("./routes/certificates");
const usersRoutes = require("./routes/users");
const supportRoutes = require("./routes/support");
const registerRoutes = require("./routes/registerRoutes");
const forgotRoutes = require("./routes/forgotRoutes");
const staffForgotRoutes = require("./routes/staffForgotRoutes");
const staffRegisterRoutes = require("./routes/staffRegisterRoutes");

app.use("/", authRoutes);
app.use("/", staffRoutes);
app.use("/", dashboardRoutes);
app.use("/", requestRoutes);
app.use("/", certRoutes);
app.use("/", usersRoutes);
app.use("/", supportRoutes);
app.use("/", registerRoutes);
app.use("/", forgotRoutes);
app.use("/", staffForgotRoutes);
app.use("/", staffRegisterRoutes);
/* ======================
   Start Server
====================== */
const PORT = process.env.PORT || 3000;

(async () => {
  try {
    await importAllCAs();
    await importAllCerts();

    app.listen(PORT, () => {
      console.log(`✅ UI running on http://localhost:${PORT}`);
    });
  } catch (err) {
    console.error("❌ Startup failed:", err.message);
  }
})();
