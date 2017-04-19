# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

# Required.
# Sets the name of the package. This will be used in along with `pkg_origin`,
# and `pkg_version` to define the fully-qualified package name, which determines
# where the package is installed to on disk, how it is referred to in package
# metadata, and so on.
pkg_name=wordpress-proxy
pkg_origin=starkandwayne

pkg_version=undefined
pkg_source=nosuchfile.tar.xz


pkg_deps=(core/nginx)

pkg_svc_user=root
pkg_svc_group=$pkg_svc_user

do_begin() {
  return 0
}

do_build() {
  return 0
}

update_pkg_version() {
  return 0
}

do_download() {
  return 0
}

do_install() {
  return 0
}

do_prepare() {
  return 0
}

do_unpack() {
  return 0
}
