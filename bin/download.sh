#!/usr/bin/env bash

# shellcheck disable=SC2207

user_name="microsoft"
repo_name="go-sqlcmd"
base_url="https://github.com/$user_name/$repo_name/releases"
pkg_type="deb"

help() {
	echo "Usage: $0 [options]"
	echo "Options:"
	echo "  -h, --help		Show this help message and exit"
	echo "  -u, --user		Github user name"
	echo "  -r, --repo		Github repo name"
	echo "  -t, --type		Package type (deb, rpm, tar.gz)"
}

while [[ $# -gt 0 ]]; do
	key="$1"
	case $key in
		-h|--help)
			help
			exit 0
			;;
		-u|--user)
			user_name="$2"
			shift
			shift
			;;
		-r|--repo)
			repo_name="$2"
			shift
			shift
			;;
		-t|--type)
			pkg_type="$2"
			shift
			shift
			;;
		*)
			echo "Unknown option: $1"
			help
			exit 1
			;;
	esac
done

latest=$(curl -s "$base_url" | awk -F '[<>]' "/\/${user_name}\/${repo_name}\/releases\/tag\// {print \$5}" | head -n 1)

pkg_urls=($(curl -s "https://api.github.com/repos/${user_name}/${repo_name}/releases/latest" \
	| awk "/browser_download_url/ && /${pkg_type}/ && /${latest}/ { print }" \
	| cut -d : -f 2,3 \
	| tr -d \" \
	| sed 's/^ *//g'
))

dl_pkg() {
	curl -s -L -o "$1" "$2"
}

main() {
    for pkg_url in "${pkg_urls[@]}"; do
        local pkg_name="${pkg_url##*/}"
        local pkg_path="/tmp/${pkg_name}"
        dl_pkg "$pkg_path" "$pkg_url"
        echo "$pkg_name downloaded to $pkg_path"
    done
}
main "$@"

exit 0
