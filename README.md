# mscode-vps-infra

Infrastructure configuration for the morinscode.dev VPS.

This repository manages:

- Main reverse proxy
- Shared Docker networks
- Landing page infrastructure
- TLS certificates
- Deployment-related configuration

Application code lives in separate repositories.

## Certificate renewal

TLS certificates are renewed through the Certbot container.

The renewal script and systemd units are stored in:

```text
scripts/renew-certificates.sh
systemd/morinscode-cert-renew.service
systemd/morinscode-cert-renew.timer
```

### Install the renewal script

```bash
sudo cp scripts/renew-certificates.sh \
  /usr/local/bin/renew-morinscode-certificates

sudo chmod +x \
  /usr/local/bin/renew-morinscode-certificates
```

### Install the systemd units

```bash
sudo cp systemd/morinscode-cert-renew.service \
  /etc/systemd/system/

sudo cp systemd/morinscode-cert-renew.timer \
  /etc/systemd/system/
```

### Enable the renewal timer

Reload systemd and enable the timer:

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now morinscode-cert-renew.timer
```

Verify the timer:

```bash
systemctl status morinscode-cert-renew.timer
systemctl list-timers --all | grep morinscode
```

### Test certificate renewal

Run a simulated renewal:

```bash
sudo docker compose run --rm certbot renew --dry-run
```

The renewal script currently assumes the infrastructure repository is located at:

```text
/home/moe/projects/mscode-vps-infra
```
