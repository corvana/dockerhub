from nginx:stable

run apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get remove -y libtiff5 \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*
