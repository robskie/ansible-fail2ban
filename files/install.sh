#!/bin/bash
# This script will install Fail2Ban.

# Download
fail2ban_version=$1
download_url=https://github.com/fail2ban/fail2ban/archive/$fail2ban_version.tar.gz
curl -O -L --silent --fail $download_url
if [ $? -ne 0 ]
then
  echo "Can't download Fail2Ban version $fail2ban_version"
  echo "Check if the following download URL is correct:"
  echo "$download_url"
  exit 1
fi

# Extract and install
tar xf $fail2ban_version.tar.gz
cd fail2ban-$fail2ban_version
sudo python setup.py --quiet install --prefix=/usr/local

# Copy init script
cp files/debian-initd /etc/init.d/fail2ban

# Disable iptables "--wait" option if unsupported
iptables_version=$2
if [[ "$iptables_version" < "1.4.20"  ]]
then
  sed -i 's/^\(lockingopt =\).*/\1/' /etc/fail2ban/action.d/iptables-common.conf
fi

# Cleanup
rm -rf $fail2ban_version.tar.gz fail2ban-$fail2ban_version
