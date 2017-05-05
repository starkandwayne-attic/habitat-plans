pkg_name=shield
pkg_origin=starkandwayne
pkg_version="0.10.7"
pkg_maintainer="Justin Carter <justin@starkandwayne.com>"
pkg_license=('MIT')
pkg_description="A standalone system that can perform backup and restore functions for a wide variety of pluggable data systems."
pkg_upstream_url="https://github.com/starkandwayne/shield"
pkg_source="https://github.com/starkandwayne/shield/archive/v${pkg_version}.tar.gz"
pkg_shasum="20fafa930d6af51fddcb496f51fc08e7f8d8db3089f940547e95cc0619aca06b"

pkg_deps=(core/bash core/glibc starkandwayne/postgresql starkandwayne/shield-proxy/${pkg_version})
pkg_build_deps=(core/go core/git core/gcc core/make core/gox)

pkg_bin_dirs=(bin)

pkg_exports=(
  [port]=port
  [http_port]=http_port
  [provisioning_key]=auth.provisioning_key
)
pkg_exposes=(http_port port)

pkg_svc_user=root
pkg_svc_group=$pkg_svc_user

# Optional.
# An associative array representing services which you depend on and the configuration keys that
# you expect the service to export (by their `pkg_exports`). These binds *must* be set for the
# supervisor to load the service. The loaded service will wait to run until it's bind becomes
# available. If the bind does not contain the expected keys, the service will not start
# successfully.
pkg_binds=(
  [database]="port superuser_name superuser_password"
)

# Optional.
# Same as `pkg_binds` but these represent optional services to connect to.
# pkg_binds_optional=(
#   [storage]="port host"
# )

# Optional.
# An array of interpreters used in shebang lines for scripts. Specify the
# subdirectory where the binary is relative to the package, for example,
# bin/bash or libexec/neverland, since binaries can be located in directories
# besides bin. This list of interpreters will be written to the metadata
# INTERPRETERS file, located inside a package, with their fully-qualified path.
# Then these can be used with the fix_interpreter function.
# pkg_interpreters=(bin/bash)

# Optional.
# The user to run the service as. The default is hab.
# pkg_svc_user="hab"

# Optional.
# The group to run the service as. The default is hab.
# pkg_svc_group="$pkg_svc_user"

do_begin() {
  export SHIELD_SRC_PATH=${HAB_CACHE_SRC_PATH}/$pkg_dirname/src/github.com/starkandwayne/shield
  export GOPATH="$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

do_prepare() {
  rm -rf $HAB_CACHE_SRC_PATH/shield
  mkdir -p ${HAB_CACHE_SRC_PATH}/shield
  mv $HAB_CACHE_SRC_PATH/$pkg_dirname/* $HAB_CACHE_SRC_PATH/shield/

  mkdir -p ${SHIELD_SRC_PATH}
  mv $HAB_CACHE_SRC_PATH/shield/* ${SHIELD_SRC_PATH}

  export PATH=$PATH:$GOPATH/bin

  git config --global url."git://github.com/".insteadOf "https://github.com/"
  go get github.com/tools/godep
  cd ${SHIELD_SRC_PATH}
  make restore-deps
}

do_build() {
  export VERSION=${pkg_version}
  cd ${SHIELD_SRC_PATH}
  make release
}

do_install() {
  cd ${SHIELD_SRC_PATH}/artifacts
  tar -xvzf shield-server-linux-amd64.tar.gz
  cd shield-server-linux-amd64

  cp cli/shield           ${pkg_prefix}/bin
  cp daemon/shieldd       ${pkg_prefix}/bin
  cp daemon/shield-schema ${pkg_prefix}/bin
  cp -R webui             ${pkg_prefix}/webui
}
