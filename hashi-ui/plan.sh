pkg_name=hashi-ui
pkg_origin=starkandwayne
pkg_version="0.13.6"
pkg_maintainer="Justin Carter <justin@starkandwayne.com>"
pkg_license=('MIT')
pkg_description="A modern user interface for @hashicorp Consul & Nomad"
pkg_upstream_url="https://github.com/https://github.com/jippi/hashi-ui/archive/v0.13.6.tar.gz"
pkg_source="https://github.com/jippi/hashi-ui/archive/v${pkg_version}.tar.gz"
pkg_shasum="8cacca5b369d0e0eb7192b2d4ca5a557ef16f534c7af5e34822dde78359e5a53"
pkg_deps=(core/glibc)
pkg_build_deps=(core/make core/gcc core/go core/git core/yarn core/coreutils)

pkg_bin_dirs=(bin)

# pkg_exports=(
#   [host]=srv.address
#   [port]=srv.port
#   [ssl-port]=srv.ssl.port
# )
# pkg_exposes=(port ssl-port)

# Optional.
# An associative array representing services which you depend on and the configuration keys that
# you expect the service to export (by their `pkg_exports`). These binds *must* be set for the
# supervisor to load the service. The loaded service will wait to run until it's bind becomes
# available. If the bind does not contain the expected keys, the service will not start
# successfully.
# pkg_binds=(
#   [database]="port host"
# )

# Optional.
# Same as `pkg_binds` but these represent optional services to connect to.
# pkg_binds_optional=(
#   [storage]="port host"
# )

do_clean() {
  rm -rf $HAB_CACHE_SRC_PATH/hashi-ui
}

do_begin() {
  export HASHI_UI_SRC_PATH=${HAB_CACHE_SRC_PATH}/$pkg_dirname/src/github.com/jippi/hashi-ui
  export GOPATH="$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

do_prepare() {
  mkdir -p ${HAB_CACHE_SRC_PATH}/hashi-ui
  mv $HAB_CACHE_SRC_PATH/$pkg_dirname/* $HAB_CACHE_SRC_PATH/hashi-ui/

  mkdir -p ${HASHI_UI_SRC_PATH}
  mv $HAB_CACHE_SRC_PATH/hashi-ui/* ${HASHI_UI_SRC_PATH}

  export PATH=$PATH:$GOPATH/bin

  git config --global url."git://github.com/".insteadOf "https://github.com/"
  go get -u github.com/kardianos/govendor
  cd ${HASHI_UI_SRC_PATH}

  # The `/usr/bin/env` path is hardcoded, so we'll add a symlink if needed.
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv $(pkg_path_for coreutils)/bin/env /usr/bin/env
    _clean_env=true
  fi
}

do_build() {
  cd ${HASHI_UI_SRC_PATH}
  make build
}

do_install() {
  cd ${HASHI_UI_SRC_PATH}
  cp backend/build/hashi-ui-linux-amd64 "${pkg_prefix}/bin/hashi-ui"
}
