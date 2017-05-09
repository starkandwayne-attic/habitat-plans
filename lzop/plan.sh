pkg_name=lzop
pkg_origin=starkandwayne
pkg_version="1.03"
pkg_source="http://www.lzop.org/download/lzop-${pkg_version}.tar.gz"
pkg_shasum="c1425b8c77d49f5a679d5a126c90ea6ad99585a55e335a613cae59e909dbb2c9"
pkg_deps=(core/glibc core/lzo)
pkg_build_deps=(core/make core/gcc)
pkg_bin_dirs=(bin)
