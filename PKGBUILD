# Maintainer: aaditya   aaditya_gnulinux@zoho.com

pkgname=timeset
pkgver=1.1
pkgrel=1
pkgdesc="A script for managing system date and time."
url="http://forum.manjaro.org/index.php?topic=7067.0"
arch=('any')
license=('GPL')
depends=('bash')
optdepends=('ntp')
source=("https://github.com/aaditya-gnulinux/timeset/blob/master/${pkgname}-${pkgver}.tar.gz")
md5sums=('2e02d3a4f42ed015caaa28a689cd1e60')
package() {
  cd "${srcdir}/${pkgname}-${pkgver}"
  install -Dm755 "${pkgname}-${pkgver}" "${pkgdir}/usr/bin/${pkgname}"
}

# vim:set ts=2 sw=2 et:
