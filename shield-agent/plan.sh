pkg_name=shield-agent
pkg_origin=starkandwayne
pkg_version="0.10.4"
pkg_maintainer="Justin Carter <justin@starkandwayne.com>"
pkg_license=('MIT')
pkg_description="A standalone system that can perform backup and restore functions for a wide variety of pluggable data systems."
pkg_upstream_url="https://github.com/starkandwayne/shield"
pkg_source="https://github.com/starkandwayne/shield/releases/download/v${pkg_version}/shield-server-linux-amd64.tar.gz"
pkg_shasum="c70b11d92d18a12bd52a1d8d5907fcb5b386fda6742dff1d184aa63d417b5a5c"

pkg_deps=(starkandwayne/postgresql core/coreutils core/curl core/bash core/bzip2 core/glibc)

pkg_bin_dirs=(bin)

# pkg_exports=(
# [port]=port
# )
# pkg_exposes=(port)

pkg_binds=(
[daemon]="port"
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

do_build() {
  return 0
}

# The default implementation is to run make install on the source files and
# place the compiled binaries or libraries in HAB_CACHE_SRC_PATH/$pkg_dirname,
# which resolves to a path like /hab/cache/src/packagename-version/. It uses
# this location because of do_build() using the --prefix option when calling the
# configure script. You should override this behavior if you need to perform
# custom installation steps, such as copying files from HAB_CACHE_SRC_PATH to
# specific directories in your package, or installing pre-built binaries into
# your package.
do_install() {
  cd "${HAB_CACHE_SRC_PATH}/shield-server-linux-amd64" || exit

  cp agent/shield-agent   ${pkg_prefix}/bin

  mkdir ${pkg_prefix}/plugins
  cp plugins/* ${pkg_prefix}/plugins

  cgo_wrap_binaries

  cp daemon/shield-pipe   ${pkg_prefix}/bin
  fix_interpreter ${pkg_prefix}/bin/shield-pipe core/bash bin/bash
}

cgo_wrap_binaries() {
  for binary in ${pkg_prefix}/{bin,plugins}/* ; do
    build_line "Adding wrapper $(basename ${binary}) to $(basename ${binary}.real)"
    mv ${binary} ${binary}.real
    cat <<EOF > "${binary}"
    #!$(pkg_path_for bash)/bin/bash
    set -e
    export LD_LIBRARY_PATH="$LD_RUN_PATH"
    exec $(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2 ${binary}.real \$@
EOF
    chmod -v 755 "${binary}"
  done
}

