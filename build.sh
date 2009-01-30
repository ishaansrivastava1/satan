#!/bin/sh

# Répertoire de travail
SH_BASE="${SH_BASE:-`pwd`}"

#Scripts de live-helper
. "${LH_BASE:-/usr/share/live-helper}"/functions.sh

#Génération de la documentation
. "${SH_BASE}"/scripts/doc.sh auto

cd ${SH_BASE}
lh_build | tee build.log

rm -f ${SH_BASE}/config/chroot_local-packages/satan-manual*
