# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# SeaweedFS на Go. Этот eclass поможет собрать пакет.
inherit go-module

DESCRIPTION="A simple and highly scalable distributed file system"
HOMEPAGE="https://github.com/seaweedfs/seaweedfs"
SRC_URI="https://github.com/seaweedfs/seaweedfs/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=dev-lang/go-1.21"
RDEPEND="${DEPEND} fuse? ( sys-fs/fuse:0 )"
BDEPEND=""
IUSE="fuse"

# Указываем, что исходники лежат в подкаталоге
S="${WORKDIR}/${P}"
# Функция сборки
src_compile() {
    # Собираем основной бинарник weed
    # Флаг -o указывает, куда положить результат
    ego build -o weed ./weed
}

# Функция установки
src_install() {
    # Устанавливаем бинарник в /usr/bin
    dobin weed

    # Если нужен FUSE, можно установить и его, но обычно он входит в weed
    # if use fuse; then
    #     dobin weed
    # fi
}
