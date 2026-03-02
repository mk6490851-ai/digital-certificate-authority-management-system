const express = require("express");
const cron = require("node-cron");
const db = require("./db");
const nodemailer = require("nodemailer");
require("dotenv").config();
const router = express.Router();

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL_USER, 
    pass: process.env.EMAIL_PASS, 
  },
});

cron.schedule("30 00 * * *", async () => {
  console.log(" Running 1:30pm certificate expiry check...");

  try {
    // Find certificates expiring within the next 2 days
    const [certs] = await db.query(`
      SELECT c.serial, c.owner ,c.fileName, c.expiryDate, u.email, u.username
      FROM certificates c
      JOIN users u ON c.owner = u.username
      WHERE c.expiryDate BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 2 DAY)
    `);

    if (certs.length === 0) {
      console.log(" No expiring certificates today.");
      return;
    }

    for (const cert of certs) {
      const mailOptions = {
        from: `"WCA Management System" <${process.env.EMAIL_USER}>`,
        to: cert.email,
        subject: `⚠️ Your Certificate is Expiring Soon`,
        html: `
          <h3>Hello</h3>
          <p>This is a reminder that your certificate is about to expire soon.</p>
          <ul>
            <li><strong>Serial Number:</strong> ${cert.serial}</li>
            <li><strong>Common Name:</strong> ${cert.fileName}</li>
            <li><strong>Expiry Date:</strong> ${new Date(cert.expiryDate).toLocaleString()}</li>
          </ul>
          <p>Please renew your certificate before it expires to avoid disruption.</p>
          <br>
          <p>Regards,<br><strong>WCA Management System</strong></p>
        `,
      };

      try {
        await transporter.sendMail(mailOptions);
        console.log(` Reminder sent to ${cert.email}`);
      } catch (mailErr) {
        console.error(` Failed to send email to ${cert.email}:`, mailErr);
      }
    }
  } catch (err) {
    console.error(" Error checking expiring certificates:", err);
  }
});
module.exports = router;