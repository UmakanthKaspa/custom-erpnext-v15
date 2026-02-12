# ERPNext v15 + Healthcare + Payments

A ready-to-run ERPNext setup with Healthcare and Payments apps. Just set your passwords and start.

**You need:** [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed. That's it.

---

## Option 1: Automatic (recommended)

```bash
bash setup.sh
```

It will ask for your passwords, then start everything for you.

---

## Option 2: Manual

```bash
# Copy the password template
cp .env.example .env

# Open .env and change the passwords
#   Windows: notepad .env
#   Mac/Linux: nano .env

# Start
docker compose up -d
```

---

## After starting

- Wait **3-5 minutes** for first-time setup
- Open **http://localhost:3000**
- Login: **Administrator**
- Password: whatever you set as ADMIN_PASSWORD

Check progress:
```bash
docker compose logs -f create-site
```

---

## Stop / Start / Restart

```bash
docker compose down        # Stop (your data is saved)
docker compose up -d       # Start again
docker compose restart     # Restart
```

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Page not loading | Wait 3-5 minutes, the site is still being created |
| 502 Bad Gateway | Backend is still starting, wait 1-2 more minutes |
| Wrong password | Check your `.env` file — ADMIN_PASSWORD is your login password |
| Port 3000 in use | Change the port in `docker-compose.yml` |

---
Image: https://hub.docker.com/r/umakanthkaspa/custom-erpnext-v15
