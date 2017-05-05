# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

pkg_name=shield-proxy
pkg_origin=starkandwayne
pkg_maintainer="Ramon Makkelie <makkelie@starkandwayne.com>"
pkg_license=('Apache-2.0')
pkg_version=0.10.7
pkg_source=nosuchfile.tar.xz

pkg_svc_user=root
pkg_svc_group=$pkg_svc_user

pkg_deps=(core/nginx core/openssl core/bash)

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
