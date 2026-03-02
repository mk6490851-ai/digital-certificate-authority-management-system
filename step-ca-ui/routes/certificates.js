const express = require("express");
const path = require("path");
const fs = require("fs");
const { execSync } = require("child_process");
const moment = require("moment-timezone");
const { inspectCert } = require("../helpers");  
const { CERTS_DIR, STEP_BIN, CA_URL, PROVISIONER, PASS_FILE, ROOT_CA } = require("../config");
const db = require("../db");
const { logAction } = require("../middleware/auditLogger");

const router = express.Router();

// ==========================================================
// MANAGER: Revoke certificate
// ==========================================================
router.post("/certificates/revoke/:id", async (req, res) => {
  if (!req.isAuthenticated() || req.user.role !== "CA_MANAGER") {
    return res.sendStatus(403);
  }

  try {
    const certFile = req.params.id;
    const certPath = path.join(CERTS_DIR, certFile);

    if (!fs.existsSync(certPath)) {
      return res.status(404).send("Certificate not found");
    }
   // 🔍 Get certificate info
    const certJson = inspectCert(certPath);
    const serial = certJson.serial_number;

    // ✅  Generate revocation token
    const tokenCmd = `${STEP_BIN} ca token ${serial} --revoke --provisioner "${PROVISIONER}" --ca-url "${CA_URL}" --root "${ROOT_CA}" --password-file "${PASS_FILE}"`;
    const token = execSync(tokenCmd, { encoding: "utf8", shell: true }).trim();

    // ✅ Revoke the certificate using the token
    const revokeCmd = `${STEP_BIN} ca revoke ${serial} --token "${token}" --ca-url "${CA_URL}" --root "${ROOT_CA}"`;
    execSync(revokeCmd, { stdio: "inherit", shell: true });

    await db.query("UPDATE certificates SET status='REVOKED' WHERE serial=?", [
      certJson.serial_number,
    ]);

    // ✅ Audit log
    await logAction(
      req.user.username,
      "CERT_REVOKED",
      `Manager ${req.user.username} revoked certificate (Serial=${certJson.serial_number}, Owner=${certJson.subject?.common_name || "Unknown"})`
    );

    res.redirect("/dashboard?status=revoked");
  } catch (err) {
    console.error("Error revoking certificate:", err.message);
    res.status(500).send("Error revoking certificate");
  }
});
// ==========================================================
// MANAGER: Renew certificate
// ==========================================================
router.post("/certificates/renew/:id", async (req, res) => {
  if (!req.isAuthenticated() || req.user.role !== "CA_MANAGER") {
    return res.sendStatus(403);
  }

  try {
    const certFile = req.params.id; 
    const certPath = path.join(CERTS_DIR, certFile);
    const keyPath = certPath.replace(".crt", ".key");
    const newCertPath = certPath.replace(".crt", "-renewed.crt");

    // Run step-ca renew
    execSync(
      `${STEP_BIN} ca renew "${certPath}" "${keyPath}" --ca-url "${CA_URL}" --root "${ROOT_CA}" --password-file "${PASS_FILE}" --out "${newCertPath}"`,
      { stdio: "inherit", shell: true }
    );

    // Inspect renewed certificate
    const certJson = inspectCert(newCertPath);

    const expiryDate = certJson.validity?.end
      ? moment(certJson.validity.end).tz("Asia/Karachi").format("YYYY-MM-DD HH:mm:ss")
      : null;

    const renewedFileName = path.basename(newCertPath);

    // ✅ Update existing certificate record 
    await db.query(
      `UPDATE certificates 
       SET fileName = ?, status = 'RENEWED', expiryDate = ? 
       WHERE fileName = ?`,
      [renewedFileName, expiryDate, certFile]
    );

    // ✅ Audit log
    await logAction(
      req.user.username,
      "CERT_RENEWED",
      `Manager ${req.user.username} renewed certificate (OldFile=${certFile}, NewFile=${renewedFileName}, Owner=${certJson.subject?.common_name || "Unknown"})`
    );

    res.redirect("/dashboard?status=renewed");
  } catch (err) {
    console.error("❌ Error renewing certificate:", err.message);
    res.status(500).send("Error renewing certificate");
  }
});
// ==========================================================
// USER: View own certificates
// ==========================================================
router.get("/my-certificates", async (req, res) => {
  if (!req.isAuthenticated()) return res.redirect("/login");

  try {
    // 🟢 Join certificates with requests to get only that user's certs
    const [rows] = await db.query(
      `SELECT c.id, c.fileName, c.status, c.expiryDate, c.issuer, c.serial, c.issued_at,
              r.subject, r.id AS request_id
       FROM certificates c
       JOIN requests r ON c.request_id = r.id
       WHERE r.user = ? 
       ORDER BY c.issued_at DESC`,
      [req.user.username]   // current logged in user
    );

    // ✅ Audit log
    await logAction(
      req.user.username,
      "CERTS_VIEWED",
      `User ${req.user.username} viewed their certificates (count=${rows.length})`
    );

    res.render("userDashboard", { certs: rows, user: req.user });
  } catch (err) {
    console.error("Error fetching user certificates:", err.message);
    res.status(500).send("Error fetching certificates");
  }
});

// ==========================================================
// USER: Download own .crt file
// ==========================================================
router.get("/certs/download/:id", async (req, res) => {
  if (!req.isAuthenticated()) return res.redirect("/login");

  try {
    const [rows] = await db.query(
      "SELECT * FROM certificates WHERE id=? AND owner=?",
      [req.params.id, req.user.username]
    );

    if (!rows || rows.length === 0) {
      return res.status(404).send("Certificate not found");
    }

    const certFile = rows[0].fileName;
    const certPath = path.join(CERTS_DIR, certFile);

    if (!fs.existsSync(certPath)) {
      return res.status(404).send("Certificate file missing");
    }

    // ✅ Audit log
    await logAction(
      req.user.username,
      "CERT_DOWNLOADED",
      `User ${req.user.username} downloaded certificate (File=${certFile}, ID=${req.params.id})`
    );

    res.download(certPath, certFile);
  } catch (err) {
    console.error("Error downloading certificate:", err.message);
    res.status(500).send("Error downloading certificate");
  }
});

module.exports = router;

