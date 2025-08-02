# Plex Cleanup Script for macOS (High Sierra Compatible)

## 🧹 Overview

This script is designed to help clean up video libraries for use with [Plex Media Server](https://www.plex.tv/) by:

1. **Recursively scanning** the folder it's run from.
2. **Deleting video files** that are **not supported by Plex**.
3. **Removing folders** that no longer contain any supported video files.
4. **Displaying** all deleted files and folders.
5. **Reporting** the total amount of disk space freed, in megabytes.

It's especially useful for cleaning large, messy archives where Plex compatibility is a concern.

---

## ✅ What It Keeps

These video formats are **considered Plex-compatible** and will be preserved:

- `.mp4`
- `.mkv`
- `.avi`
- `.mov`
- `.mpg`
- `.mpeg`
- `.m4v`

---

## ❌ What It Deletes

The script removes files with **known unsupported or problematic formats** for Plex:

- `.flv`
- `.vob`
- `.rm`, `.rmvb`
- `.ts`
- `.divx`
- `.m2ts`, `.mts`
- `.iso`, `.img`, `.bin`
- `.asf`
- `.3gp`
- `.wmv`

> **Note:** Deletion is permanent (not moved to Trash). Use at your own risk.

---

## 🗑️ Folder Deletion Rules

After cleaning unsupported files, the script checks all folders recursively. It deletes folders if:

- They **contain no supported video files**, **and**
- They are otherwise **empty** (except for hidden files or subfolders).

This avoids leaving empty folders that clutter your library.

---

## 💾 Freed Space Display

At the end of execution, you'll see:

✅ Plex cleanup finished. Freed space: 742.18 MB

---

## 📦 Usage

### Step 1 — Save the Script

Save the contents as `plex_cleanup.sh` into the folder you want to clean (or higher level).

### Step 2 — Make It Executable

```bash
chmod +x plex_cleanup.sh

./plex_cleanup.sh
