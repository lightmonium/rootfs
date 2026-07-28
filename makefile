all: install mkdir download

install:
	@sudo apt-get --yes install curl libarchive-tools

mkdir:
	@mkdir --parents usr/local/bin/ usr/local/bin/static/ usr/local/share/geoip/ usr/local/share/dnsmasq/

download: download_claws download_cloudflared download_singbox download_ttyd download_tun2socks download_websocat download_wgcf download_zellij download_aichat download_cliproxyapi download_cliproxyapi_web download_geoip download_dnsmasq

download_claws:
	@curl --silent --location https://github.com/thehowl/claws/releases/download/0.4.1/claws_0.4.1_linux_64bit.tar.gz | bsdtar --extract --directory='usr/local/bin/' --file='-'

download_cloudflared:
	@curl --silent --location https://github.com/cloudflare/cloudflared/releases/download/2026.3.0/cloudflared-linux-amd64 > usr/local/bin/cloudflared-linux-amd64

download_singbox:
	@curl --silent --location https://github.com/SagerNet/sing-box/releases/download/v1.13.14/sing-box-1.13.14-linux-amd64.tar.gz | bsdtar --extract --directory='usr/local/bin/' --strip-components=1 --file='-' 'sing-box-1.13.14-linux-amd64/sing-box'

download_ttyd:
	@curl --silent --location https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64 > usr/local/bin/ttyd.x86_64

download_tun2socks:
	@curl --silent --location https://github.com/xjasonlyu/tun2socks/releases/download/v2.6.0/tun2socks-linux-amd64-v3.zip | bsdtar --extract --directory='usr/local/bin/' --file='-'

download_websocat:
	@curl --silent --location https://github.com/vi/websocat/releases/download/v1.14.1/websocat.x86_64-unknown-linux-musl > usr/local/bin/websocat.x86_64-unknown-linux-musl

download_wgcf:
	@curl --silent --location https://github.com/ViRb3/wgcf/releases/download/v2.2.30/wgcf_2.2.30_linux_amd64 > usr/local/bin/wgcf_linux_amd64

download_zellij:
	@curl --silent --location https://github.com/zellij-org/zellij/releases/download/v0.44.0/zellij-x86_64-unknown-linux-musl.tar.gz | bsdtar --extract --directory='usr/local/bin/' --file='-'

download_aichat:
	@curl --silent --location https://github.com/sigoden/aichat/releases/download/v0.30.0/aichat-v0.30.0-x86_64-unknown-linux-musl.tar.gz | bsdtar --extract --directory='usr/local/bin/' --file='-'

download_cliproxyapi:
	@curl --silent --location https://github.com/router-for-me/CLIProxyAPI/releases/download/v7.1.31/CLIProxyAPI_7.1.31_linux_amd64.tar.gz | bsdtar --extract --directory='usr/local/bin/' --file='-' cli-proxy-api

download_cliproxyapi_web:
	@curl --silent --location https://github.com/router-for-me/Cli-Proxy-API-Management-Center/releases/download/v1.14.0/management.html > usr/local/bin/static/management.html

download_geoip:
	@curl --silent --location https://ipbl.herrbischoff.com/geoip/cn.netset > usr/local/share/geoip/cn.netset

download_dnsmasq:
	@for f in accelerated-domains.china.conf google.china.conf apple.china.conf bogus-nxdomain.china.conf; do \
		curl --silent --location https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/$$f > usr/local/share/dnsmasq/$$f; \
	done
	@curl --silent --location https://raw.githubusercontent.com/lightmonium/hosts-blocklists/master/dnsmasq/dnsmasq.blacklist.txt > usr/local/share/dnsmasq/dnsmasq.blacklist.txt

sha256sum:
	@find usr/local/bin/ -type f -exec sha256sum {} \;

sync:
	@git branch -D temp-branch || true
	@git checkout --orphan temp-branch
	@git add -A
	@git commit --allow-empty-message -m ""
	@git branch -D master || true
	@git branch -m master
	@git push --force origin master

