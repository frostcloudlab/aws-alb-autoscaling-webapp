#!/bin/bash
set -eux

dnf update -y
dnf install -y nginx curl

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s \
  http://169.254.169.254/latest/meta-data/instance-id)

HOSTNAME_VALUE=$(hostname)

AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s \
  http://169.254.169.254/latest/meta-data/placement/availability-zone)

cat > /usr/share/nginx/html/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>AWS ALB Auto Scaling Web App</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background: #0f172a;
      color: #e5e7eb;
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
    }
    .card {
      background: #111827;
      border: 1px solid #374151;
      border-radius: 12px;
      padding: 2rem;
      width: min(90%, 700px);
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
    }
    h1 {
      margin-top: 0;
      color: #f9fafb;
    }
    .meta {
      margin-top: 1.5rem;
      display: grid;
      gap: 0.75rem;
    }
    .meta div {
      padding: 0.75rem 1rem;
      background: #1f2937;
      border-radius: 8px;
    }
    .label {
      font-weight: bold;
      color: #93c5fd;
    }
  </style>
</head>
<body>
  <div class="card">
    <h1>AWS Highly Available Web App</h1>
    <p>This page is being served by an EC2 instance behind an Application Load Balancer.</p>
    <div class="meta">
      <div><span class="label">Hostname:</span> ${HOSTNAME_VALUE}</div>
      <div><span class="label">Instance ID:</span> ${INSTANCE_ID}</div>
      <div><span class="label">Availability Zone:</span> ${AZ}</div>
      <div><span class="label">Deployment Version:</span> v1</div>
    </div>
  </div>
</body>
</html>
EOF

systemctl enable nginx
systemctl restart nginx
