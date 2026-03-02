const fs = require("fs");
const path = require("path");
const { execSync } = require("child_process");
const moment = require("moment-timezone");
const db = require("./db");
const { STEP_BIN, ROOT_CA, CERTS_DIR } = require("./config");

// Intermediate CA path
const INTERMEDIATE_CA = path.join(__dirname, "ca", "intermediate_ca.crt");

function inspectCert(certPath) {
  const out = execSync(
    `${STEP_BIN} certificate inspect "${certPath}" --format json`,
    { encoding: "utf8", shell: true }
  );
  return JSON.parse(out);
}

/**
 * Import a CA cert into DB (skip if fingerprint already exists)
 */
async function importCA(certPath) {
  try {
    const output = execSync(
      `${STEP_BIN} certificate inspect "${certPath}" --format json`,
      { encoding: "utf8", shell: true }
    );
    const certJson = JSON.parse(output);

    const fingerprint = execSync(
      `${STEP_BIN} certificate fingerprint "${certPath}"`,
      { encoding: "utf8", shell: true }
    ).trim();

    const createdOn = certJson.validity?.start
      ? moment(certJson.validity.start).tz("Asia/Karachi").format("YYYY-MM-DD HH:mm:ss")
      : null;

    const expiryOn = certJson.validity?.end
      ? moment(certJson.validity.end).tz("Asia/Karachi").format("YYYY-MM-DD HH:mm:ss")
      : null;

    const status =
      expiryOn && new Date(expiryOn) < new Date() ? "EXPIRED" : "ACTIVE";

    const name = certJson.subject?.common_name || path.basename(certPath);

    // ✅ Check if CA with same fingerprint already exists
    const [existing] = await db.query("SELECT id FROM ca WHERE fingerprint = ?", [fingerprint]);
    if (existing.length > 0) {
      return; // skip
    }

    await db.query(
      `INSERT INTO ca (name, issuer, fingerprint, serial, expiryOn, createdOn, status)
       VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [
        name,
        certJson.issuer?.common_name || "N/A",
        fingerprint,
        certJson.serial_number || "N/A",
        expiryOn,
        createdOn,
        status,
      ]
    );
  } catch {
    // silent
  }
}

async function importAllCAs() {
  await importCA(ROOT_CA);
  await importCA(INTERMEDIATE_CA);
}

/**
 * Import all certificates from CERTS_DIR into DB (skip if serial already exists)
 */
async function importAllCerts() {
  try {
    if (!fs.existsSync(CERTS_DIR)) return;

    const certFiles = fs.readdirSync(CERTS_DIR).filter(f => f.endsWith(".crt"));
    if (certFiles.length === 0) return;

    for (const file of certFiles) {
      const certPath = path.join(CERTS_DIR, file);

      try {
        const certJson = inspectCert(certPath);

        const subjectCN = Array.isArray(certJson.subject?.common_name)
          ? certJson.subject.common_name[0]
          : certJson.subject?.common_name || "Unknown";

        const issuedAt = certJson.validity?.start
          ? moment(certJson.validity.start).tz("Asia/Karachi").format("YYYY-MM-DD HH:mm:ss")
          : null;

        const expiryDate = certJson.validity?.end
          ? moment(certJson.validity.end).tz("Asia/Karachi").format("YYYY-MM-DD HH:mm:ss")
          : null;

        const serial = certJson.serial_number;
        const issuer = certJson.issuer?.common_name || "Unknown";

        let status = "EXPIRED";
        if (issuedAt && expiryDate) {
          const now = new Date();
          if (now >= new Date(certJson.validity.start) && now <= new Date(certJson.validity.end)) {
            status = "ACTIVE";
          }
        }

        // ✅ Check if certificate with same serial already exists
        const [existing] = await db.query("SELECT id FROM certificates WHERE serial = ?", [serial]);
        if (existing.length > 0) {
          continue; // skip
        }

        await db.query(
          `INSERT INTO certificates (fileName, owner, status, expiryDate, issuer, serial, issued_at)
           VALUES (?, ?, ?, ?, ?, ?, ?)`,
          [file, subjectCN, status, expiryDate, issuer, serial, issuedAt]
        );
      } catch {
        // silent
      }
    }
  } catch {
    // silent
  }
}

async function loadAllCAs() {
  const [rows] = await db.query("SELECT * FROM ca");
  return rows;
}

module.exports = {
  inspectCert,
  importCA,
  importAllCAs,
  importAllCerts,
  loadAllCAs,
  CERTS_DIR,
};
