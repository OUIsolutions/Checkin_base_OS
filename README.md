# Checkin_base_OS
Here’s a clean and well-structured **README** in Markdown for your Lua distro base detection script:

---

````markdown
# 🖥️ Linux Distribution Base Detector (Lua)

A lightweight Lua function to detect the **base family** of your Linux distribution.  
Supports **Arch**, **Debian**, **Red Hat**, **Alpine**, **Gentoo**, and **Solus** based systems,  
and falls back to package manager detection if standard files are missing.

---

## 📋 Supported Bases

| Code | Base Name  | Examples                                                                 |
|------|------------|---------------------------------------------------------------------------|
| -1   | Unknown    | Any system that does not match known signatures                          |
| 0    | Arch       | Arch Linux, Manjaro, EndeavourOS, Garuda                                 |
| 1    | Debian     | Debian, Ubuntu, Linux Mint, Pop!\_OS, Elementary OS                      |
| 2    | Red Hat    | Red Hat Enterprise Linux (RHEL), Fedora, CentOS, Rocky Linux, AlmaLinux  |
| 3    | Alpine     | Alpine Linux, PostmarketOS                                               |
| 4    | Gentoo     | Gentoo Linux, Funtoo                                                      |
| 5    | Solus      | Solus OS                                                                 |

---

## 📦 Features
- **Fast**: Single function call to detect the base.
- **Reliable**: Checks `/etc/os-release`, distro-specific release files, and package managers.
- **Portable**: Works on most Unix-like environments where Lua is available.
- **Extensible**: Easy to add more bases or custom checks.

---

## 🚀 Usage

```lua
-- Paste the detect_base() function here or require it from another file.

local base = detect_base()

if base == 0 then
    print("Arch-based system detected!")
elseif base == 1 then
    print("Debian-based system detected!")
elseif base == 2 then
    print("Red Hat-based system detected!")
elseif base == 3 then
    print("Alpine-based system detected!")
elseif base == 4 then
    print("Gentoo-based system detected!")
elseif base == 5 then
    print("Solus-based system detected!")
else
    print("Unknown base")
end
````

---

## 🔍 How It Works

1. **Primary Check**
   Reads `/etc/os-release` and matches `ID_LIKE` or `ID` values.

2. **Fallback #1**
   Looks for distribution-specific release files:

   * `/etc/arch-release`
   * `/etc/debian_version`
   * `/etc/redhat-release`
   * `/etc/alpine-release`
   * `/etc/gentoo-release`
   * `/etc/solus-release`

4. **Fallback #3**
   If none match, returns `-1` (Unknown).

---

## 🛠 Extending the Script

To add a new base:

1. Add `ID_LIKE` / `ID` matching in the `/etc/os-release` check.
2. Add a release file check in the fallback section.
3. Add the package manager command check as a last resort.


