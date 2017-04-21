# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

pkg_name=wordpress
pkg_origin=starkandwayne
pkg_version="4.7.3"
pkg_maintainer="Ramon Makkelie <makkelie@starkandwayne.com>"
pkg_license=('Apache-2.0')
pkg_source="https://wordpress.org/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="e715069fdab049ec668cd74e57cabcb23583dc4a84c5e330c430cbe8998f6d89"

source_dir=$HAB_CACHE_SRC_PATH/${pkg_name}

pkg_svc_user=root
pkg_svc_group=$pkg_svc_user

pkg_deps=(core/php core/curl starkandwayne/wordpress-proxy)

pkg_exports=()
pkg_exposes=()

# pkg_binds=(
#   [database]="port username password"
# )


do_build(){
  return 0
}

do_install() {
  # mkdir $pkg_prefix/public_html
  cp -r "$source_dir" $pkg_prefix/public_html/

  # rename file so we can use fpm default
  cp "$(pkg_path_for php)/etc/php-fpm.d/www.conf.default" "$(pkg_path_for php)/etc/php-fpm.d/www.conf"
}
