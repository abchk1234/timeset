# Maintainer: aaditya  aaditya_gnulinux@zoho.com

pkgname=timeset
pkgver=1.2
_git=71babae212156d1f414790caa5c1b6ff028e528f
pkgrel=1
pkgdesc="A script for managing system date and time."
url="http://git.manjaro.org/aadityabagga/timeset/"
arch=('any')
license=('GPL')
depends=('bash' 'sudo')
optdepends=('ntp')
source=("http://git.manjaro.org/aadityabagga/timeset/raw/$_git/timeset")
sha1sums=('3a5a4862534a0e9d500b5a3513159e8bb9348b05')

package() {
  cd "${srcdir}"
  install -Dm755 "${pkgname}" "${pkgdir}/usr/bin/${pkgname}"
}

# vim:set ts=2 sw=2 et:

