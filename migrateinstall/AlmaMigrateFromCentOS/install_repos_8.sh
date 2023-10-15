#!/bin/bash
dnf install epel-release -y
yum config-manager --set-enabled powertools
dnf config-manager --set-enabled crb
dnf config-manager --set-enabled nfv
dnf config-manager --set-enabled plus
dnf config-manager --set-enabled resilientstorage
dnf config-manager --set-enabled rt
dnf config-manager --set-enabled sap
dnf config-manager --set-enabled saphana
dnf config-manager --set-enabled epel-testing
dnf install rpmfusion-free-release -y
dnf install --nogpgcheck https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
dnf install --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm -y
dnf install http://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
rpm -Uvh https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
dnf group install "Development Tools" -y
dnf group install "High Availability" -y
dnf install dnf-utils -y
dnf groupupdate core -y
dnf groupupdate sound-and-video -y
dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
curl https://repo.almalinux.org/elevate/testing/elevate-testing.repo -o /etc/yum.repos.d/elevate-testing.repo
rpm --import https://repo.almalinux.org/elevate/RPM-GPG-KEY-ELevate
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
dnf install https://www.elrepo.org/elrepo-release-8.el9.elrepo.noarch.rpm
sudo dnf upgrade --refresh -y
