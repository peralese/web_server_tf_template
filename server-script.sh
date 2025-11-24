#!/bin/bash
set -euo pipefail

sudo yum -y update

sudo yum install -y yum-utils

sudo rpm --import https://pkg.osquery.io/rpm/GPG
sudo yum-config-manager --add-repo https://pkg.osquery.io/rpm/osquery-s3-rpm.repo
sudo yum install -y osquery
sudo systemctl enable osqueryd
sudo systemctl start osqueryd
sudo systemctl is-active --quiet osqueryd

sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl is-active --quiet nginx

if command -v firewall-cmd >/dev/null 2>&1 && sudo firewall-cmd --state >/dev/null 2>&1; then
  sudo firewall-cmd --permanent --add-service=http
  sudo firewall-cmd --reload
fi

sudo tee /usr/share/nginx/html/index.html >/dev/null <<'EOF'
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>BluePrint test</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #0f172a;
      color: #e2e8f0;
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      margin: 0;
    }
    .card {
      background: #1e293b;
      border: 1px solid #334155;
      border-radius: 12px;
      padding: 32px 40px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.35);
      max-width: 640px;
      width: 100%;
      text-align: center;
    }
    h1 {
      margin: 0 0 12px;
      font-size: 28px;
      letter-spacing: -0.5px;
    }
    p {
      margin: 0 0 18px;
      line-height: 1.6;
      color: #cbd5e1;
    }
    code {
      background: #0b1220;
      padding: 4px 8px;
      border-radius: 6px;
      font-size: 0.95em;
      color: #7dd3fc;
    }
    .badge {
      display: inline-block;
      padding: 6px 12px;
      border-radius: 999px;
      background: #22c55e33;
      color: #22c55e;
      font-weight: 700;
      letter-spacing: 0.5px;
      font-size: 12px;
      text-transform: uppercase;
      margin-bottom: 14px;
    }
  </style>
</head>
<body>
  <main class="card">
    <div class="badge">Nginx is live</div>
    <h1>Test of Blueprint application</h1>
    <p>Your server is up and serving content via <code>nginx</code>. Feel free to customize this page by updating <code>/usr/share/nginx/html/index.html</code>.</p>
    <p>Deployed automatically by <strong>server-script.sh</strong>.</p>
  </main>
</body>
</html>
EOF
