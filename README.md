# Hex UI

This repository is the live UI source for the **Hex** Android executor.

The executor fetches `menu.lua` from this repository every time the app starts
and runs it as its CoreGui host chunk. Editing `menu.lua` on `main` updates
installs without shipping a new APK. The APK still contains a frozen copy of
this file as an offline fallback, so users are never left without a menu.

## Files

| File | Purpose |
| --- | --- |
| `menu.lua` | The complete CoreGui menu, host pump, and transport dispatch. |
| `README.md` | This document. |

## Protocol

`menu.lua` starts with `HEXUI_PROTOCOL 1`. The native payload only accepts a
remote UI that carries this exact marker. Do **not** change or remove it unless
the corresponding native build has been updated and released. A protocol
mismatch makes the executor fall back to its embedded UI.

`menu.lua` is executed with CoreScript identity. It is not sandboxed. Anyone
with push access to this repository can execute code in users' clients, so keep
write access limited.

## Releases

The signed, obfuscated APK is published under **Releases** in this repository.

## Local testing

```lua
-- The executor runs the file as the injected CoreGui host chunk. It expects
-- the globals `game`, `loadstring`, `script`, and the native HEXHTTP transport
-- to exist; it cannot be run as a normal LocalScript.
```
