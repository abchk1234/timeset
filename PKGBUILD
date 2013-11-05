# Maintainer: aaditya          aaditya_gnulinux@zoho.com

pkgname=timeset
pkgver=1.2
pkgrel=1
pkgdesc="A script for managing system date and time."
url="https://github.com/aaditya-gnulinux/timeset"
arch=('any')
license=('GPL')
depends=('bash' 'sudo')
optdepends=('ntp')
source=("https://github.com/aaditya-gnulinux/timeset/blob/master/${pkgname}-${pkgver}.tar.gz")
md5sums=('32969e219d2740a420964cf82f1a0f4c')
package() {
  cd "${srcdir}/${pkgname}-${pkgver}"
  install -Dm755 "${pkgname}-${pkgver}" "${pkgdir}/usr/bin/${pkgname}"
}

# vim:set ts=2 sw=2 et:
