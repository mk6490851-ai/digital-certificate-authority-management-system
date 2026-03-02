const db = require("./db");
const nodemailer = require("nodemailer");
const cron = require("node-cron");

// ✅ Email transporter setup
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

// ✅ Function to mark expired certificates and notify users
async function checkAndMarkExpired() {
  try {
    // Get all active certificates
    const [certs] = await db.query(`
      SELECT c.serial, c.owner, c.expiryDate, c.status, u.email AS userEmail, u.username
      FROM certificates c
      JOIN users u ON c.owner = u.username
      WHERE c.status = 'ACTIVE'
    `);

    const now = new Date();
    const newlyExpired = [];

    for (const cert of certs) {
      const expiry = new Date(cert.expiryDate);

      if (expiry <= now) {
        // Mark as expired
        await db.query("UPDATE certificates SET status = 'EXPIRED' WHERE serial = ?", [cert.serial]);
        newlyExpired.push(cert);

        console.log(`⚰️ Certificate ${cert.serial} (${cert.owner}) marked as expired`);

        // Send email to user
        if (cert.userEmail) {
          const userMail = {
            from: `"Digital CA System" <${process.env.EMAIL_USER}>`,
            to: cert.userEmail,
            subject: "Your Certificate Has Expired",
            html: `
              <h3>Hello ${cert.username},</h3>
              <p>This is to inform you that your certificate has <strong>expired</strong>.</p>
              <table border="1" cellspacing="0" cellpadding="6" style="border-collapse:collapse;">
                <tr><th>Serial Number</th><td>${cert.serial}</td></tr>
                <tr><th>Expiry Date</th><td>${new Date(cert.expiryDate).toLocaleString()}</td></tr>
              </table>
              <p>Please contact the CA management if you need to renew it.</p>
              <br><p>— <strong>WCA Management System</strong></p>
            `,
          };

          try {
            await transporter.sendMail(userMail);
            console.log(`📧 Expiry email sent to user ${cert.username} (${cert.userEmail})`);
          } catch (err) {
            console.error(`❌ Failed to send expiry email to ${cert.username}:`, err);
          }
        }
      }
    }

    return newlyExpired;
  } catch (err) {
    console.error("❌ Error checking expired certificates:", err);
    return [];
  }
}

// ✅ Daily summary email to admin at 1:15 PM
async function sendDailyExpiredEmail() {
  try {
    const [expiredToday] = await db.query(`
      SELECT c.serial, c.owner, c.expiryDate, u.email AS userEmail
      FROM certificates c
      JOIN users u ON c.owner = u.username
      WHERE DATE(c.expiryDate) = CURDATE() OR (c.status = 'EXPIRED' AND DATE(c.expiryDate) = CURDATE())
    `);

    if (expiredToday.length === 0) {
      console.log("📭 No expired certificates today — skipping admin email.");
      return;
    }

    const rows = expiredToday.map(
      c => `<tr><td>${c.serial}</td><td>${c.owner}</td><td>${c.userEmail}</td><td>${new Date(c.expiryDate).toLocaleString()}</td></tr>`
    ).join("");

    const htmlBody = `
      <h3>Daily Expired Certificates Report</h3>
      <p>The following certificates expired today:</p>
      <table border="1" cellspacing="0" cellpadding="6" style="border-collapse:collapse;">
        <tr style="background:#eee;"><th>Serial</th><th>Owner</th><th>Email</th><th>Expiry Date</th></tr>
        ${rows}
      </table>
      <p>This is an automated notification from the WCA Management System.</p>
    `;

    const mailOptions = {
      from: `"WCA Management System" <${process.env.EMAIL_USER}>`,
      to: process.env.ADMIN_EMAIL || process.env.EMAIL_USER,
      subject: "Daily Expired Certificates Summary",
      html: htmlBody,
    };

    await transporter.sendMail(mailOptions);
    console.log(`📧 Admin summary email sent (${expiredToday.length} certificates).`);
  } catch (err) {
    console.error("❌ Error sending daily expiry email:", err);
  }
}

// ✅ Run expiry check every minute
setInterval(checkAndMarkExpired, 60 * 1000);

// ✅ Run daily summary email at 1:15 PM
cron.schedule("59 19 * * *", async () => {
  console.log("🕚 Running 11:15 PM daily expiry summary job...");
  await sendDailyExpiredEmail();
});

console.log("🔁 Certificate expiry watcher + email notifier running...");
