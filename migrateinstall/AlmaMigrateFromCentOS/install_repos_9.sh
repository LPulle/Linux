dnf config-manager --set-enabled crb
dnf config-manager --set-enabled nfv
dnf config-manager --set-enabled plus
dnf config-manager --set-enabled resilientstorage
dnf config-manager --set-enabled rt
dnf config-manager --set-enabled sap
dnf config-manager --set-enabled saphana
dnf config-manager --set-enabled epel-testing
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y
dnf install --nogpgcheck https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y
dnf install --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-9.noarch.rpm -y
dnf install http://rpms.remirepo.net/enterprise/remi-release-9.rpm -y
dnf group install "Development Tools" -y
dnf group install "High Availability" -y
rpm -Uvh https://packages.microsoft.com/config/rhel/9/packages-microsoft-prod.rpm
curl https://repo.almalinux.org/elevate/testing/elevate-testing.repo -o /etc/yum.repos.d/elevate-testing.repo
rpm --import https://repo.almalinux.org/elevate/RPM-GPG-KEY-ELevate
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
dnf install https://www.elrepo.org/elrepo-release-9.el9.elrepo.noarch.rpm -y
dnf upgrade --refresh -y
#dnf install almalinux-release-testing -y
