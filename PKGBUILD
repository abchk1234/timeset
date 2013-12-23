# Maintainer: aaditya  aaditya_gnulinux@zoho.com
# Contributor: Claude Bulin <xcfaudio[at]gmail[dot]com>

pkgname=timeset
pkgver=1.5
pkgrel=1
pkgdesc="A script for managing system date and time."
url="http://git.manjaro.org/aadityabagga/timeset/"
arch=('any')
license=('GPL')
depends=('bash')
optdepends=('ntp')
source=("http://git.manjaro.org/aadityabagga/timeset/repository/archive")
sha1sums=('SKIP')

package() {
  cd "${srcdir}/${pkgname}.git"
  make DESTDIR=${pkgdir} install
}


# vim:set ts=2 sw=2 et:

