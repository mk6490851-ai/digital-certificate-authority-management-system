const express = require("express");
const path = require("path");
const { execSync } = require("child_process");
const {  inspectCert } = require("../helpers");
const { CERTS_DIR, STEP_BIN, CA_URL, ROOT_CA ,PASS_FILE} = require("../config");
const db = require("../db");
const { logAction } = require("../middleware/auditLogger");
const moment = require("moment-timezone");
const router = express.Router();

/**
 * =======================================
 * USER: Submit new certificate request
 * =======================================
 */
router.post("/certificates/request", async (req, res) => {
  if (!req.isAuthenticated() || req.user.role !== "USER") return res.sendStatus(403);

  const { subject } = req.body;

  try {
    // Save request
    await db.query(
      "INSERT INTO requests (user, subject, status, created_at) VALUES (?, ?, 'PENDING', NOW())",
      [req.user.username, subject]
    );

    // ✅ Audit log
    await logAction(
      req.user.username,
      "REQUEST_SUBMITTED",
      `User ${req.user.username} submitted a new certificate request (subject=${subject})`
    );

    res.redirect("/dashboard?msg=request_submitted");
  } catch (err) {
    console.error("Error inserting request:", err.message);
    res.status(500).send("Error saving request");
  }
});

/**
 * =======================================
 * MANAGER: Dashboard (CA Manager view)
 * =======================================
 */
router.get("/dashboard", async (req, res) => {
  if (!req.isAuthenticated() || req.user.role !== "CA_MANAGER") return res.sendStatus(403);

  try {
    const [pendingRequests] = await db.query("SELECT * FROM requests WHERE status='PENDING'");
    const [acceptedRequests] = await db.query("SELECT * FROM requests WHERE status='ACCEPTED'");
    const [rejectedRequests] = await db.query("SELECT * FROM requests WHERE status='REJECTED'");
    const [renewedCertificates] = await db.query("SELECT * FROM certificates WHERE status='RENEWED'");
    const [revokedCertificates] = await db.query("SELECT * FROM certificates WHERE status='REVOKED'");
    const [certificates] = await db.query("SELECT * FROM certificates");

    // ✅ Audit log
    await logAction(
      req.user.username,
      "DASHBOARD_VIEWED",
      `Manager ${req.user.username} viewed the CA Manager dashboard`
    );

    res.render("managerdashboard", {
      user: req.user,
      pendingRequests,
      acceptedRequests,
      rejectedRequests,
      renewedCertificates,
      revokedCertificates,
      certificates,
    });
  } catch (err) {
    console.error("Error loading dashboard:", err.message);
    res.status(500).send("Error loading dashboard");
  }
});
/**
 * =======================================
 * MANAGER: Issue certificate (Accept request)
 * =======================================
 */
router.post("/requests/issue/:id", async (req, res) => {
  if (!req.isAuthenticated() || req.user.role !== "CA_MANAGER") return res.sendStatus(403);

  try {
    // 🟢 1. Get request from DB
    const [[request]] = await db.query("SELECT * FROM requests WHERE id=?", [req.params.id]);
    if (!request) return res.status(404).send("Request not found");

    const subject = request.subject;
    const certPath = path.join(CERTS_DIR, `${subject}.crt`);
    const keyPath = path.join(CERTS_DIR, `${subject}.key`);

    //  2. Run step-ca to issue certificate
    const cmd = `${STEP_BIN} ca certificate "${subject}" "${certPath}" "${keyPath}" --ca-url "${CA_URL}" --root "${ROOT_CA}" --not-after 720h --password-file "${PASS_FILE}"`;
    execSync(cmd, { stdio: "inherit", shell: true });

    //  3. Parse cert metadata
    const certJson = inspectCert(certPath);
    const expiryDate = certJson.validity?.end
      ? moment(certJson.validity.end).tz("Asia/Karachi").format("YYYY-MM-DD HH:mm:ss")
      : null;

    //  4. Update requests table (mark accepted)
    await db.query("UPDATE requests SET status='ACCEPTED' WHERE id=?", [req.params.id]);

    //  5. Insert certificate with request_id
    await db.query(
      `INSERT INTO certificates 
        (fileName, owner, status, expiryDate, issuer, serial, issued_at, request_id) 
       VALUES (?, ?, 'ACTIVE', ?, ?, ?, NOW(), ?)`,
      [
        `${subject}.crt`,                   
        request.user,                         
        expiryDate,                          
        certJson.issuer?.common_name || "N/A",
        certJson.serial_number,               
        request.id                         
      ]
    );

    // 🟢 6. Audit log
    await logAction(
      req.user.username,
      "CERT_ISSUED",
      `Manager ${req.user.username} issued certificate for Request #${request.id} (subject=${subject}, user=${request.user})`
    );

    res.redirect("/dashboard?status=issued");
  } catch (err) {
    console.error("Error issuing certificate:", err.message);
    res.status(500).send("Error issuing certificate");
  }
});

/**
 * =======================================
 * MANAGER: Reject certificate request
 * =======================================
 */
router.post("/requests/reject/:id", async (req, res) => {
  if (!req.isAuthenticated() || req.user.role !== "CA_MANAGER") return res.sendStatus(403);

  try {
    const [[request]] = await db.query("SELECT * FROM requests WHERE id=?", [req.params.id]);
    if (!request) return res.status(404).send("Request not found");

    // Update request status
    await db.query("UPDATE requests SET status='REJECTED' WHERE id=?", [req.params.id]);

    // ✅ Audit log
    await logAction(
      req.user.username,
      "REQUEST_REJECTED",
      `Manager ${req.user.username} rejected certificate request (id=${req.params.id}, subject=${request.subject}, user=${request.user})`
    );

    res.redirect("/dashboard?status=rejected");
  } catch (err) {
    console.error("Error rejecting request:", err.message);
    res.status(500).send("Error updating request");
  }
});

module.exports = router;
