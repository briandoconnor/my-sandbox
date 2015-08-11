#!/bin/bash

HOSTS_FILE="./hosts"
ROSTER_FILE="./roster"
INVENTORY_FILE="./inventory"

read -d '' HOSTS_HEAD <<EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

EOF

read -d '' INVENTORY_GROUPS <<EOF
[ambari]
ambari
[zoo-name]
zoo-name
[kafka]
kafka0[1:2]
[spark-store]
spark-store0[1:3]


EOF

echo -n > ${ROSTER_FILE}
echo -n > ${INVENTORY_FILE}
echo "${HOSTS_HEAD}" > ${HOSTS_FILE}

for HOST in ambari zoo-name kafka0{1..2} spark-store0{1..3}
do
    IP=$(terraform output ${HOST}.ip)
    echo "${IP} ${HOST}" >> ${HOSTS_FILE}
    echo "${HOST} ansible_ssh_host=${IP} ansible_ssh_user=root" >> ${INVENTORY_FILE}

    read -d '' ROSTER <<EOF
${HOST}:
  host: ${IP}
  user: root
  mine_functions:
    network.ip_addrs:
      interface: eth0
EOF

    echo "${ROSTER}" >> ${ROSTER_FILE}

    ssh-keygen -R ${IP} &> /dev/null

done

echo "${INVENTORY_GROUPS}" >> ${INVENTORY_FILE}
