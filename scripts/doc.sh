#!/bin/sh -x

# Répertoire de travail

#Scripts de live-helper
. "${LH_BASE:-/usr/share/live-helper}"/functions.sh

# $METHODE: Génération automatique ou manuel de la doc
# (Default: empty)
METHODE=$1

if [ "${METHODE}" = "auto" ]
then
	if [ ! -d "${SH_BASE}" ]
	then
		Echo "Utilisr ./doc make pour générer la documentation"
		exit 1;
	fi
	
	DOC_BASE="${SH_BASE}/doc"
	Echo "Construction de la documentation"
	
	cd ${DOC_BASE}/satan-manual
	dch --force-bad-version --newversion 42+01 --distribution UNRELEASED Autobuild 1
	dpkg-buildpackage -rfakeroot -us -uc
	debuild clean
	mv ${DOC_BASE}/satan*.deb ${SH_BASE}/config/chroot_local-packages
	
	rm -rf ${DOC_BASE}/satan-manual_*
	cd ${SH_BASE}

elif [ "${METHODE}" = "make" ]
then
	DOC_BASE="$(pwd)/../doc"
	cd ${DOC_BASE}/satan-manual
	make 
	Echo "La documentation est disponible dans satan-maual : index.html, satan-manual.pdf, satan-manual.txt"

elif [ "${METHODE}" = "clean" ]
then
	DOC_BASE="$(pwd)/../doc"
	cd ${DOC_BASE}/satan-manual
	make clean
	rm -rf ${DOC_BASE}/satan-manual_*
else
	Echo "Usage : ./doc make|clean"	
fi