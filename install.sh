#!/bin/bash

echo "Setting up Bluetooth Auto-Cleanup for Cluster Workstations..."

# Create directories
mkdir -p ~/scripts
mkdir -p ~/.config/systemd/user

# Create the cleanup script
cat > ~/scripts/bt_cleanup_bg.sh << 'EOF'
#!/bin/bash
echo "Starting Bluetooth cleanup at $(date)" >> ~/bt_cleanup.log

DEVICES=$(bluetoothctl paired-devices | awk '{print $2}')
if [ -n "$DEVICES" ]; then
    for MAC in $DEVICES; do
        echo "Removing $MAC" >> ~/bt_cleanup.log
        bluetoothctl disconnect "$MAC" &>/dev/null
        bluetoothctl remove "$MAC" &>/dev/null
    done
fi
EOF

chmod +x ~/scripts/bt_cleanup_bg.sh

# Create the systemd service
cat > ~/.config/systemd/user/bt-cleanup.service << 'EOF'
[Unit]
Description=Forget all Bluetooth devices on logout
PartOf=graphical-session.target

[Service]
Type=oneshot
RemainAfterExit=true
ExecStop=/bin/bash %h/scripts/bt_cleanup_bg.sh

[Install]
WantedBy=graphical-session.target
EOF

# Enable and start the service
systemctl --user daemon-reload
systemctl --user enable --now bt-cleanup.service

echo "Success!"
