pkg_name=postgresql
pkg_version=9.6.3
pkg_origin=starkandwayne
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="PostgreSQL is a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')
pkg_source=https://ftp.postgresql.org/pub/source/v${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=1645b3736901f6d854e695a937389e68ff2066ce0cde9d73919d6ab7c995b9c6
pkg_deps=(
  core/envdir
  core/postgresql/${pkg_version}
  core/bash
)
pkg_exports=(
  [port]=port
  [superuser_name]=superuser.name
  [superuser_password]=superuser.password
)
pkg_exposes=(port)

pkg_svc_user=root
pkg_svc_group=$pkg_svc_user

do_build() {
  return 0
}

do_install() {
  return 0
}
