#!/bin/sh

###
# = xfce4.sh(3)
# Priyank <priyankmg@gmail.com>
#
# == NAME
# xfce4.sh - for Frugalware
#
# == SYNOPSIS
# Common schema for Xfce4 packages.
#
# == EXAMPLE
# --------------------------------------------------
# pkgname=xfce4-icon-theme
# pkgver=4.4.0
# pkgrel=1
# pkgdesc="Default icon theme for Xfce4."
# groups=('xfce4' 'xfce4-core')
# archs=('i686' 'x86_64')
# Finclude xfce4
# sha1sums=('86eab53a01b16dee695002dd22981b55a16cc085')
# --------------------------------------------------
#
# == OPTIONS
# * _F_xfce_name (defaults to $pkgname): if you want to use a custom package
# name (for example the upstream name contains uppercase letters) then use this
# to declare the real name
# * _F_xfce_goodies_ext (defaults to .tar.bz2) extension of the source tarball
# * _F_xfce_goodies_dir (defaults to _F_xfce_name) if the source tarball uses a
# name different to the xfce4 proect name, then use this option to declare the
# project name
###

if [ -z $_F_xfce_name ] ; then
	_F_xfce_name=$pkgname
fi

if [ -z $_F_xfce_goodies_ext ] ; then
	_F_xfce_goodies_ext=".tar.bz2"
fi

if [ -z $_F_xfce_goodies_dir ] ; then
	_F_xfce_goodies_dir=$_F_xfce_name
fi

if [ -z $_F_archive_name ] ; then
	_F_archive_name=$_F_xfce_name
fi

if [ -z $_F_xfce_ver ]; then
	_F_xfce_ver="4.8"
fi

if [ -z $pkgver ]; then
	pkgver=${_F_xfce_ver}
fi

if [ -z $_F_xfce_category ]; then
	_F_xfce_category="apps"
fi

###
# == OVERWRITTEN VARIABLES
# * url
# * up2date
# * source()
###

if echo ${groups[*]} | grep -q goodies ; then
	url="http://goodies.xfce.org/projects/panel-plugins/${_F_xfce_name}"
	dlurl="http://archive.xfce.org/src/$_F_xfce_category/$_F_xfce_goodies_dir/"
    preup2date="lynx -dump -source http://archive.xfce.org/src/$_F_xfce_category/$_F_xfce_name/|grep $_F_xfce_name|tail -n1|sed -e 's/<\/a>.*//;s/.*>//'"
    up2date="Flasttar $dlurl/\$($preup2date)/"
    source=($dlurl/${pkgver%%.?}/${_F_xfce_name}-${pkgver}${_F_xfce_goodies_ext})
else
	url="http://www.xfce.org/"
	dlurl="http://mocha.xfce.org/archive/xfce/${_F_xfce_ver}/src"
	up2date="Flasttar http://git.xfce.org/xfce/$_F_xfce_name/"
	source=($dlurl/$_F_xfce_name-$pkgver.tar.bz2)
fi

###
# == APPENDED VARIABLES
# * scriptlet to options()
###
options=(${options[@]} 'scriptlet')

