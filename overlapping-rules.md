# Overlapping Rules

## CA1707 and SA1310

SA1310 covers fields at all accessibilities and CA1707 covers a variety of public-only structures.

Fixed by implementing the `api_surface` option on CA1707.

## CA1710 and SA1302

SA1302 covers interfaces at all accessibilities and CA1710 covers public-only interfaces and generic type parameters.

Fixed by implementing the `api_surface` option on CA1710.

## CA1710 and SA1314

SA1314 covers generic type parameters at all accessibilities and CA1710 covers public-only interfaces and generic type parameters.

Fixed by implementing the `api_surface` option on CA1710.
