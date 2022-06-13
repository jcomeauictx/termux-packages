# Termux for Android 5 and 6

See original README [here](termux.md).

Until I figure out how to build these packages for legacy Termux, I've set
up an apt repository based on the packages at [archive.org](https://archive.org/details/termux-repositories-legacy). It's missing some things I didn't have
room for, as explained in the
[README](https://termux.unternet.net/apt/dists/README.txt).

From the Termux prompt on your phone, ensure that the following file exists:
`../usr/etc/apt/sources.list.d/unternet.list`. If not, create it with the
following contents:


deb https://termux.unternet.net/apt/dists/termux-packages stable main
