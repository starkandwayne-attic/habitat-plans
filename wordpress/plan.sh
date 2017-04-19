# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

pkg_name=wordpress
pkg_origin=starkandwayne
pkg_version="4.7.3"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
#pkg_license=('Apache-2.0')
# pkg_filename="${pkg_name}-${pkg_version}.tar.gz"

#if we want the latest source, a non empty string is required, but we are building locally
pkg_source="https://wordpress.org/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="e715069fdab049ec668cd74e57cabcb23583dc4a84c5e330c430cbe8998f6d89"

source_dir=$HAB_CACHE_SRC_PATH/${pkg_name}

#DO NOT USE
pkg_svc_user=root
pkg_svc_group=root

# Optional.
# The resulting filename for the download, typically constructed from the
# pkg_name and pkg_version values.
pkg_deps=(core/php core/nginx core/curl)

pkg_exports=()
pkg_exposes=()




do_build(){
  return 0
}
# There is no default implementation of this callback. At this point in the
# build process, the tarball source has been downloaded, unpacked, and the build
# environment variables have been set, so you can use this callback to perform
# any actions before the package starts building, such as exporting variables,
# adding symlinks, and so on.
# do_prepare() {
#   return 0
# }
#
# do_check() {
#   return 0
# }

do_install() {
  # mkdir $pkg_prefix/public_html
  cp -r "$source_dir" $pkg_prefix/public_html/

  # rename file so we can use fpm default
  cp "$(pkg_path_for php)/etc/php-fpm.d/www.conf.default" "$(pkg_path_for php)/etc/php-fpm.d/www.conf"
}

# do_strip() {
#   do_default_strip
# }
#
# do_end() {
#   return 0
# }
