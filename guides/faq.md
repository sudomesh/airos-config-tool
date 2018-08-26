# FAQ

## What is airMax and when should I enable it?
airMax is a proprietary [TDMA](https://en.wikipedia.org/wiki/Time-division_multiple_access) protocol developed by Ubiquiti.
It's probably faster to use it than to not,
but non-Ubiquiti devices can't connect with a Ubiquiti Access Point using airMax.

So:
- **Do** enable it for Ubiquiti point-to-point links, i.e. links between exactly two Ubiquiti devices.
- **Don't** enable it if you're configuring, for example, a Rocket M5 that you want to make available to arbitrary devices, e.g. from other vendors like LibreRouter, Cambium, Microtik, etc.
