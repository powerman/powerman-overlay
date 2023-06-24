# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aes-0.6.0
aes-soft-0.6.4
aesni-0.10.0
aho-corasick-0.7.18
ansi_term-0.12.1
arrayvec-0.7.2
assert_matches-1.5.0
async-broadcast-0.3.4
async-channel-1.6.1
async-executor-1.4.1
async-io-1.6.0
async-lock-2.5.0
async-recursion-0.3.2
async-task-4.2.0
async-trait-0.1.53
atty-0.2.14
authenticator-0.3.1
autocfg-1.1.0
base64-0.13.0
bincode-1.3.3
bindgen-0.65.1
bitflags-1.3.2
block-0.1.6
block-buffer-0.9.0
block-buffer-0.10.2
block-modes-0.7.0
block-padding-0.2.1
brownstone-1.1.0
bumpalo-3.9.1
byteorder-1.4.3
bytes-1.1.0
cache-padded-1.2.0
cc-1.0.73
cexpr-0.6.0
cfg-if-0.1.10
cfg-if-1.0.0
cipher-0.2.5
clang-sys-1.3.1
clap-3.1.8
concurrent-queue-1.2.2
core-foundation-0.9.3
core-foundation-sys-0.8.3
cpufeatures-0.2.2
crossbeam-0.8.1
crossbeam-channel-0.5.4
crossbeam-deque-0.8.1
crossbeam-epoch-0.9.8
crossbeam-queue-0.3.5
crossbeam-utils-0.8.8
crypto-common-0.1.3
crypto-mac-0.10.1
derivative-2.2.0
devd-rs-0.3.3
digest-0.9.0
digest-0.10.3
directories-4.0.1
dirs-4.0.0
dirs-next-2.0.0
dirs-sys-0.3.7
dirs-sys-next-0.1.2
easy-parallel-3.2.0
educe-0.4.19
either-1.6.1
enum-ordinalize-3.1.11
enumflags2-0.6.4
enumflags2-0.7.5
enumflags2_derive-0.6.4
enumflags2_derive-0.7.4
env_logger-0.9.0
event-listener-2.5.2
fastrand-1.7.0
foreign-types-0.3.2
foreign-types-shared-0.1.1
fuchsia-cprng-0.1.1
futures-0.1.31
futures-0.3.21
futures-channel-0.3.21
futures-core-0.3.21
futures-cpupool-0.1.8
futures-executor-0.3.21
futures-io-0.3.21
futures-lite-1.12.0
futures-macro-0.3.21
futures-sink-0.3.21
futures-task-0.3.21
futures-util-0.3.21
generic-array-0.14.5
getopts-0.2.21
getrandom-0.1.16
getrandom-0.2.6
glob-0.3.0
hashbrown-0.11.2
heck-0.3.3
hermit-abi-0.1.19
hex-0.4.3
hkdf-0.10.0
hmac-0.10.1
hmac-0.12.1
hostname-0.3.1
humantime-2.1.0
indent_write-2.2.0
indexmap-1.8.1
instant-0.1.12
itertools-0.10.3
itoa-1.0.1
joinery-2.1.0
js-sys-0.3.57
lazy_static-1.4.0
lazycell-1.3.0
libc-0.2.123
libloading-0.7.3
libsystemd-0.5.0
libudev-0.2.0
libudev-sys-0.1.4
lock_api-0.4.7
log-0.4.16
mac-notification-sys-0.5.0
malloc_buf-0.0.6
match_cfg-0.1.0
matchers-0.1.0
memchr-2.4.1
memoffset-0.6.5
minimal-lexical-0.2.1
mio-0.8.2
miow-0.3.7
nanoid-0.4.0
nb-connect-1.2.0
nix-0.17.0
nix-0.23.1
nom-7.1.1
nom-supreme-0.6.0
notify-rust-4.5.8
ntapi-0.3.7
num-0.3.1
num-bigint-0.3.3
num-bigint-0.4.3
num-complex-0.3.1
num-integer-0.1.44
num-iter-0.1.42
num-rational-0.3.2
num-traits-0.2.14
num_cpus-1.13.1
num_threads-0.1.5
numtoa-0.1.0
objc-0.2.7
objc-foundation-0.1.1
objc_id-0.1.1
once_cell-1.10.0
opaque-debug-0.3.0
openssl-0.10.38
openssl-sys-0.9.72
ordered-stream-0.0.1
os_str_bytes-6.0.0
parking-2.0.0
parking_lot-0.12.0
parking_lot_core-0.9.2
peeking_take_while-0.1.2
pin-project-1.0.10
pin-project-internal-1.0.10
pin-project-lite-0.2.8
pin-utils-0.1.0
pkg-config-0.3.25
pkg-version-1.0.0
pkg-version-impl-0.1.1
polling-2.2.0
ppv-lite86-0.2.16
prettyplease-0.2.9
proc-macro-crate-0.1.5
proc-macro-crate-1.1.3
proc-macro-hack-0.5.19
proc-macro2-1.0.60
quote-1.0.28
rand-0.4.6
rand-0.7.3
rand-0.8.5
rand_chacha-0.2.2
rand_chacha-0.3.1
rand_core-0.3.1
rand_core-0.4.2
rand_core-0.5.1
rand_core-0.6.3
rand_hc-0.2.0
rdrand-0.4.0
redox_syscall-0.2.13
redox_termios-0.1.2
redox_users-0.4.3
regex-1.5.5
regex-automata-0.1.10
regex-syntax-0.6.25
remove_dir_all-0.5.3
ring-0.16.20
runloop-0.1.0
rustc-hash-1.1.0
rustc_version-0.4.0
ryu-1.0.9
scoped-tls-1.0.0
scopeguard-1.1.0
secret-service-2.0.1
semver-1.0.7
serde-1.0.136
serde_derive-1.0.136
serde_json-1.0.79
serde_repr-0.1.7
sha1-0.6.1
sha1_smol-1.0.0
sha2-0.9.9
sha2-0.10.2
sharded-slab-0.1.4
shlex-1.1.0
signal-hook-registry-1.4.0
slab-0.4.6
smallvec-1.8.0
socket2-0.4.4
spin-0.5.2
static_assertions-1.1.0
strsim-0.10.0
strum-0.22.0
strum_macros-0.22.0
subtle-2.4.1
syn-1.0.103
syn-2.0.20
take_mut-0.2.2
tempdir-0.3.7
termcolor-1.1.3
termion-1.5.6
textwrap-0.15.0
thiserror-1.0.30
thiserror-impl-1.0.30
thread_local-1.1.4
time-0.3.9
tokio-1.17.0
tokio-macros-1.7.0
tokio-serde-0.8.0
tokio-stream-0.1.8
tokio-tower-0.6.0
tokio-util-0.7.1
toml-0.5.8
tower-0.4.12
tower-layer-0.3.1
tower-service-0.3.1
tracing-0.1.33
tracing-attributes-0.1.20
tracing-core-0.1.25
tracing-journald-0.2.4
tracing-log-0.1.2
tracing-subscriber-0.3.11
typenum-1.15.0
uhid-sys-1.0.0
unicode-segmentation-1.9.0
unicode-width-0.1.9
unicode-ident-1.0.5
untrusted-0.7.1
users-0.11.0
uuid-0.8.2
valuable-0.1.0
vcpkg-0.2.15
version_check-0.9.4
void-1.0.2
waker-fn-1.1.0
wasi-0.9.0+wasi-snapshot-preview1
wasi-0.10.2+wasi-snapshot-preview1
wasi-0.11.0+wasi-snapshot-preview1
wasm-bindgen-0.2.80
wasm-bindgen-backend-0.2.80
wasm-bindgen-macro-0.2.80
wasm-bindgen-macro-support-0.2.80
wasm-bindgen-shared-0.2.80
web-sys-0.3.57
wepoll-ffi-0.1.2
which-4.2.5
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
windows-0.24.0
windows-sys-0.34.0
windows_aarch64_msvc-0.34.0
windows_i686_gnu-0.24.0
windows_i686_gnu-0.34.0
windows_i686_msvc-0.24.0
windows_i686_msvc-0.34.0
windows_x86_64_gnu-0.24.0
windows_x86_64_gnu-0.34.0
windows_x86_64_msvc-0.24.0
windows_x86_64_msvc-0.34.0
winrt-notification-0.5.1
xml-rs-0.8.4
zbus-1.9.1
zbus-2.1.1
zbus_macros-1.9.1
zbus_macros-2.1.1
zbus_names-2.1.0
zvariant-2.10.0
zvariant-3.1.2
zvariant_derive-2.10.0
zvariant_derive-3.1.2
"

inherit cargo systemd tmpfiles

COMMIT="da1a256e804395588c21c0dd9891310506746e7a"

DESCRIPTION="A software-only Universal 2nd Factor token"
HOMEPAGE="https://github.com/danstiner/rust-u2f"
# SRC_URI="https://github.com/danstiner/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
SRC_URI="https://github.com/danstiner/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"
# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+debug"

DEPEND=""
RDEPEND=""

QA_FLAGS_IGNORED="/usr/bin/${PN}"

# S=${WORKDIR}/${P}/linux
S=${WORKDIR}/${PN}-${COMMIT}/linux

src_unpack() {
	cargo_src_unpack
	cd "${S}/.."
	eapply "${FILESDIR}/deps-no-git.patch"
	eapply "${FILESDIR}/deps-update-bindgen.patch"
}

src_install() {
	cp ../target/$(usex debug debug release)/{softu2f-,}user-daemon
	cp ../target/$(usex debug debug release)/{softu2f-,}system-daemon
	exeinto /usr/lib/softu2f
	doexe ../target/$(usex debug debug release)/{user,system}-daemon

	systemd_dounit system-daemon/softu2f.{service,socket}
	systemd_douserunit user-daemon/softu2f.service
	newtmpfiles system-daemon/softu2f-tmpfiles.conf softu2f.conf

	einstalldocs
}

pkg_postinst() {
	tmpfiles_process softu2f.conf
}
