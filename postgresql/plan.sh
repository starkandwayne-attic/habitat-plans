pkg_name=postgresql
pkg_version=9.6.1
pkg_origin=starkandwayne
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="PostgreSQL is a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')
pkg_source=https://ftp.postgresql.org/pub/source/v${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=e5101e0a49141fc12a7018c6dad594694d3a3325f5ab71e93e0e51bd94e51fcd
pkg_deps=(
  starkandwayne/envdir
  starkandwayne/wal-e
  core/bash
  core/glibc
  core/openssl
  core/perl
  core/readline
  core/zlib
  core/libossp-uuid
)
pkg_build_deps=(
  core/coreutils
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_exports=(
  [port]=port
  [superuser_name]=superuser.name
  [superuser_password]=superuser.password
)
pkg_exposes=(port)

pg_cron_version="1.0.0"
plsh_version="1.20130823"

download_extension() {
  wget $2 -O "${HAB_CACHE_SRC_PATH}/$1"
}
unpack_extension() {
  tar -xvzf "${HAB_CACHE_SRC_PATH}/$1"
}

do_download() {
  download_extension 'pg_cron.tar.gz' "https://github.com/citusdata/pg_cron/archive/v${pg_cron_version}.tar.gz"
  download_extension 'plsh.tar.gz' "https://github.com/petere/plsh/archive/${plsh_version}.tar.gz"
  do_default_download
}

do_unpack(){
  unpack_extension 'pg_cron.tar.gz'
  unpack_extension 'plsh.tar.gz'
  do_default_unpack
}

do_build() {
	# ld manpage: "If -rpath is not used when linking an ELF
	# executable, the contents of the environment variable LD_RUN_PATH
	# will be used if it is defined"
	./configure --disable-rpath \
              --with-openssl \
              --prefix="$pkg_prefix" \
              --with-uuid=ossp \
              --with-includes="$LD_INCLUDE_PATH" \
              --with-libraries="$LD_LIBRARY_PATH" \
              --sysconfdir="$pkg_svc_config_path" \
              --localstatedir="$pkg_svc_var_path"
	make world
}

do_install() {
  make install-world
}

do_end() {
  cd "${HAB_CACHE_SRC_PATH}/pg_cron-${pg_cron_version}"
  make
  make install

  cd "${HAB_CACHE_SRC_PATH}/plsh-${plsh_version}"
  make
  make install
}
