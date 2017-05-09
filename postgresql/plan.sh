pkg_name=postgresql
pkg_version=9.6.1
pkg_origin=starkandwayne
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="PostgreSQL is a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')
pkg_deps=(core/postgresql/${pkg_version})
pkg_exports=(
  [port]=port
  [superuser_name]=superuser.name
  [superuser_password]=superuser.password
)
pkg_exposes=(port)

do_build() {
  return 0
}

do_install() {
  return 0
}
