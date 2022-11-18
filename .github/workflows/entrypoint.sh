#!/bin/sh

# SPDX-License-Identifier: GPL-2.0
# Originally from https://github.com/openwrt/packages/blob/d36c34f9847d20450f61c955ccab745a5c90e90f/.github/workflows/entrypoint.sh

mkdir -p /var/lock/

opkg update

[ -n "$CI_HELPER" ] || CI_HELPER="/ci/.github/workflows/ci_helpers.sh"

for PKG in /ci/*.ipk; do
	tar -xzOf "$PKG" ./control.tar.gz | tar xzf - ./control
	# package name including variant
	PKG_NAME=$(sed -ne 's#^Package: \(.*\)$#\1#p' ./control)
	# package version without release
	PKG_VERSION=$(sed -ne 's#^Version: \(.*\)-[0-9]*$#\1#p' ./control)
	# package source contianing test.sh script
	PKG_SOURCE=$(sed -ne 's#^Source: .*/\(.*\)$#\1#p' ./control)

	echo "Testing package $PKG_NAME in version $PKG_VERSION from $PKG_SOURCE"

	opkg install "$PKG"

	export PKG_NAME PKG_VERSION CI_HELPER

	# we can't use `-not` since busybox find doesn't support it
	TEST_SCRIPT=$(find /ci/ -name "$PKG_SOURCE" -type d '!' '(' -path '*/\.git/*' ')')/test.sh

	if [ -f "$TEST_SCRIPT" ]; then
		echo "Use package specific test.sh"
		if sh "$TEST_SCRIPT" "$PKG_NAME" "$PKG_VERSION"; then
			echo "Test successful"
		else
			echo "Test failed"
			exit 1
		fi
	else
		echo "No test.sh script found at $TEST_SCRIPT"
	fi

	opkg remove "$PKG_NAME" --force-removal-of-dependent-packages --force-remove
done
