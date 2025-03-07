**build-wpd2odt-2025.sh**

This macOS bash script builds wpd2odt, wpg2odg, wpd2html, and the other libwpd command-line tools. The executables are static-linked, and should work on any current copy of macOS

It creates a folder `~/Development/libwpd-build` but this can easily be changed in the script.

`brew` must be installed, also `pkg-config`, `autoconf`, and `automake`.
