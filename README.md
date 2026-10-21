# Hex UI

This repository is the live UI source for the **Hex** Android executor.

The executor fetches `menu.lua` from this repository at startup and loads it
through its private host bridge. Editing `menu.lua` on `main` updates installs
without shipping a new APK. The APK still embeds a frozen copy of this file as
an offline fallback, so users are never left without a menu.

## Files

| File | Purpose |
| --- | --- |
| `menu.lua` | Roblox UI and editor only. |
| `README.md` | This document. |

## Host API

The UI is loaded with a small, allow-listed environment. It has **no** direct
access to the executor VM, transport, codec, or host globals. The available
bridge methods are:

| Method | Purpose |
| --- | --- |
| `Host.GetService(name)` | Return a Roblox service. |
| `Host.New(className[, parent])` | Create a Roblox instance. |
| `Host.Spawn(fn, ...)` / `Host.Wait(seconds)` / `Host.Delay(seconds, fn)` | Scheduler helpers. |
| `Host.Clock()` | Monotonic clock. |
| `Host.IsLoaded()` | Game loaded state. |
| `Host.Execute(source, label)` | Queue Lua for the executor VM. |
| `Host.Log(...)` | Append a line to the in-game console. |
| `Host.OnLog(fn)` | Register a console sink. |

`Instance.new`, `Enum`, `UDim`, `UDim2`, `Vector2`, `Vector3`, `Color3`,
`ColorSequence`, `NumberSequence`, `NumberRange`, `TweenInfo`, `Rect`,
`math`, `string`, `table`, and the usual safe Lua builtins are also available.

## Protocol

`menu.lua` starts with `HEXUI_PROTOCOL 1`. The payload only accepts a remote UI
that carries this exact marker. Do **not** change or remove it unless the
corresponding native build has been updated and released. A protocol mismatch
makes the executor fall back to its embedded UI.

## Releases

The signed, obfuscated APK is published under **Releases** in this repository.
