# Cluster Bluetooth Auto-Cleanup 🎧

Ever logged out of a cluster iMac, walked away, and suddenly heard someone else's audio blasting through your headphones because you forgot to unpair them? 

Since we don't have root access to globally flush Bluetooth cache on shared workstations, this tool uses a local `systemd` user service to automatically disconnect and forget all your paired Bluetooth devices the exact moment you click **Log Out** in GNOME.

## Installation

Run this single command in your terminal to download and execute the setup script:

```bash
curl -sL [https://raw.githubusercontent.com/ayfadli/cluster-bluetooth-cleanup/main/install.sh](https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/cluster-bluetooth-cleanup/main/install.sh) | bash
