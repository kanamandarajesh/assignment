#!/bin/bash

# Function to highlight differences
highlight() {
    if [ "$1" != "$2" ]; then
        echo -e "\e[31m$1\e[0m"
    else
        echo "$1"
    fi
}

# Server Uptime
uptime=$(uptime -p)

# Last Server Reboot Timestamp
last_reboot=$(who -b | awk '{print $3, $4}')

# Server Local Time Zone
timezone=$(date +"%Z")
expected_timezone="IST"

# Last 10 installed packages with dates
installed_packages=$(rpm -qa --last | head -n 10)

# OS version
os_version=$(cat /etc/redhat-release)
expected_os_version="Red Hat"

# Kernel version
kernel_version=$(uname -r)

# CPU
cpu_cores=$(grep -c ^processor /proc/cpuinfo)
cpu_clock_speed=$(lscpu | grep "CPU MHz" | awk '{print $3}')
cpu_architecture=$(lscpu | grep "Architecture" | awk '{print $2}')
expected_cpu_architecture="x86_64"

# Disk
disk_info=$(df -h)

# Private and Public IP
private_ip=$(hostname -I)
public_ip=$(curl -s ifconfig.me)

# Private and Public DNS or Hostname
hostname=$(hostname)
public_dns=$(dig +short $(hostname -f))

# Networking
bandwidth=$(ifstat 1 1 | tail -n 1)
os_firewall=$(iptables -L)
network_firewall=$(firewall-cmd --list-all)

# CPU Utilization
cpu_utilization=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# RAM Utilization
ram_utilization=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Storage Utilization
storage_utilization=$(df -h | grep /dev/ | awk '{print $5}' | sed 's/%//')

# Password Expiry
password_expiry=$(chage -l $(whoami) | grep "Password expires" | awk -F': ' '{print $2}')

# Print Report
echo "Server Uptime: $uptime"
echo "Last Server Reboot Timestamp: $last_reboot"
echo "Server Local Time Zone: $(highlight "$timezone" "$expected_timezone")"
echo "Last 10 installed packages with dates:"
echo "$installed_packages"
echo "OS version: $(highlight "$os_version" "$expected_os_version")"
echo "Kernel version: $kernel_version"
echo "CPU - Virtual cores: $cpu_cores"
echo "CPU - Clock speed: $cpu_clock_speed MHz"
echo "CPU - Architecture: $(highlight "$cpu_architecture" "$expected_cpu_architecture")"
echo "Disk - Mounted/Unmounted volumes, type, storage:"
echo "$disk_info"
echo "Private IP: $private_ip"
echo "Public IP: $public_ip"
echo "Hostname: $hostname"
echo "Public DNS or Hostname: $public_dns"
echo "Networking - Bandwidth: $bandwidth"
echo "Networking - OS Firewall (Allowed Ports & Protocols):"
echo "$os_firewall"
echo "Networking - Network Firewall (Allowed Ports & Protocols):"
echo "$network_firewall"
echo "CPU - Utilization: $(highlight "$cpu_utilization%" "Less than 60%")"
echo "RAM - Utilization: $(highlight "$ram_utilization%" "Less than 60%")"
echo "Storage Utilization: $(highlight "$storage_utilization%" "Less than 60%")"
echo "Current User Password Expiry: $password_expiry"
