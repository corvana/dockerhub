#!/bin/bash

export HOME="/gpdb"

source "/gpdb/.bashrc"

if [ -z "$MASTER_HOSTNAME" ]; then
  MASTER_HOSTNAME="$(hostname)"
fi

echo "$MASTER_HOSTNAME" > ./hostlist_singlenode

if [ -f "/gpmaster/gpsne-1/pg_hba.conf" ]; then
  echo "Skipping setup because we already have master files."
  gpssh-exkeys -f hostlist_singlenode
  gpstart -a
else
  cp $GPHOME/docs/cli_help/gpconfigs/gpinitsystem_singlenode .

  if [ -z "$DATABASE_NAME" ]; then
    DATABASE_NAME=warehouse
  fi
  sed -i "s/#DATABASE_NAME=warehouse/DATABASE_NAME=$DATABASE_NAME/g" gpinitsystem_singlenode

  sed -i "s/MASTER_HOSTNAME=.*/MASTER_HOSTNAME=$MASTER_HOSTNAME/g" gpinitsystem_singlenode
  gpssh-exkeys -f hostlist_singlenode
  gpinitsystem -c gpinitsystem_singlenode -a
  echo 'host     all         all           0.0.0.0/0  md5' >> /gpmaster/gpsne-1/pg_hba.conf
  gpstop -u -a

  if [ -n "$DATABASE_USER" ]; then
    echo "Will create db user $DATABASE_USER"
    if [ -n "$DATABASE_PASSWORD" ]; then
      psql -c "create user $DATABASE_USER with password '$DATABASE_PASSWORD';" "$DATABASE_NAME"
    else
      echo 'Must specify $DATABASE_PASSWORD if specifying $DATABASE_USER'
      exit 1
    fi
  fi
fi
journalctl -f
