
pkg_name=varnish
pkg_origin=starkandwayne
pkg_description="Varnish Cache"
pkg_license=('bsd')
pkg_version="5.1.2"
pkg_source="https://repo.varnish-cache.org/source/${pkg_name}-${pkg_version}.tar.gz"

pkg_shasum="39d858137e26948a7c85f07363f13f0778da61d234126e03a160a0cb9ba4fce3"
pkg_deps=(core/glibc core/ncurses core/docutils core/pcre core/gcc)
pkg_build_deps=(core/make core/python2 core/pkg-config core/readline)

pkg_bin_dirs=(sbin)
pkg_svc_user=(root)

pkg_exports=(
  [port]=frontend.port
)

do_begin() {
  return 0
}

do_prepare() {
  #TODO: We need a sphinx plan to support this otherwise we cannot
  #guarantee idempotency
  pip install sphinx
  return 0
}

do_check() {
  return 0
}
