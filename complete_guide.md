# 📘 DevForge – Complete Installation & Usage Guide

> Welcome to **DevForge** – the modular, profile-driven Linux development environment installer.

This guide walks you through:

* Installing DevForge
* Running the tool
* Adding new tools or profiles
* Understanding logs and error handling


## ⚡ Prerequisites

* A Debian/Ubuntu-based Linux system (tested on Ubuntu 22.04)
* Root privileges (`sudo`)
* Internet connection

## 📥 Installation Steps

```bash
# 1. Clone the repository
git clone https://github.com/yourusername/devforge.git

# 2. Enter the directory
cd devforge

# 3. Make main script executable
chmod +x install.sh

# 4. Run the installer
./install.sh
```

## 🎮 Usage Flow

When you run `install.sh`, the following occurs:

### 🧠 1. OS Detection

```bash
Detecting your OS...
✅ Detected Ubuntu 22.04
```

### 📦 2. Display Available Profiles

```bash
📦 Available Profiles:
- frontend
- backend
- devops
- fullstack
```

### 📝 3. Select Profile or Custom Tools

```bash
📝 Enter profile name (or type 'custom'): backend
```

### ✅ 4. Load Profile Tools

```bash
Loaded tools: node, docker, mysql, mongodb, postgres, vscode, git
```

### 💻 5. System Resource Check

```bash
Checking system resources...

✔ Available RAM: 4GB ✅
✔ Available Disk Space: 20GB ✅

All checks passed.
```

### ⚙️ 6. Tool Installation Begins

Each tool is installed via its own script inside `install_scripts/`.

## 🟢 Sample Output – Successful Install

```bash
⚙️ Installing node...
✅ node installed successfully.

⚙️ Installing docker...
✅ docker installed successfully.

⚙️ Installing mysql...
✅ mysql installed successfully.

⚙️ Installing mongodb...
✅ mongodb installed successfully.

⚙️ Installing postgres...
✅ postgres installed successfully.

⚙️ Installing vscode...
✅ vscode installed successfully.

⚙️ Installing git...
✅ git installed successfully.

🎉 All installations completed. Check logs/install.log for full details.
```

## 🔴 Sample Output – With Failures

```bash
⚙️ Installing node...
✅ node installed successfully.

⚙️ Installing docker...
❌ Installation failed for docker. See logs/install.log

⚙️ Installing mysql...
✅ mysql installed successfully.

⚙️ Installing mongodb...
❌ Installation failed for mongodb. See logs/install.log

⚙️ Installing postgres...
✅ postgres installed successfully.

⚙️ Installing vscode...
✅ vscode installed successfully.

⚙️ Installing git...
✅ git installed successfully.

🎉 All installations completed. Check logs/install.log for full details.
```

## 📜 Log File Example

Found in `logs/install.log`:

```
[INFO] Starting installation for: docker
[ERROR] Docker installation failed: Package 'docker-ce' not found

[INFO] Starting installation for: mongodb
[ERROR] GPG key add failed: No keyserver available

[INFO] Starting installation for: git
[OK] Git installed via apt successfully
```

## 🧩 Adding Your Own Tool

### 1. Create an Install Script

`install_scripts/mycooltool.sh`

```bash
#!/bin/bash
set -e
source utils/logger.sh

log_info "Installing MyCoolTool..."
sudo apt update
sudo apt install -y mycooltool
log_info "MyCoolTool installed successfully."
```

Make it executable:

```bash
chmod +x install_scripts/mycooltool.sh
```

---

### 2. Add to `tools.yaml`

```yaml
mycooltool:
  name: MyCoolTool
  version: "1.0"
  install_script: mycooltool.sh
  size: 50MB
  ram: 128MB
```

---

### 3. Add to `profiles.yaml` (Optional)

```yaml
customdev:
  - node
  - mycooltool
```

---

## 📚 File Structure Summary

| File                      | Description                        |
| ------------------------- | ---------------------------------- |
| `install.sh`              | Main script to run                 |
| `tools.yaml`              | Defines metadata for each tool     |
| `profiles.yaml`           | Profiles for dev roles             |
| `install_scripts/*.sh`    | Tool-specific installation scripts |
| `utils/helpers.sh`        | Tool loading, listing utilities    |
| `utils/logger.sh`         | Logging wrapper for consistency    |
| `utils/resource_check.sh` | Verifies disk/RAM before install   |
| `detect_os.sh`            | OS detection logic                 |
| `logs/install.log`        | Full log history of tool installs  |

---

## 🔄 Re-running Failed Installs

Simply re-run the script and select the failed tools manually:

```bash
./install.sh
```

Select `custom` and enter failed tools like:

```
Enter tools to install: docker mongodb
```

---

## 🙋 FAQ

### ❓ What if a tool exists already?

DevForge skips re-installation unless the tool is missing or the script enforces a reinstall.

### ❓ Can I use this on CentOS or Fedora?

Currently only tested on Debian-based systems. You can expand `detect_os.sh` for others.

### ❓ How do I uninstall a tool?

You must manually uninstall it (e.g., `sudo apt remove docker-ce`).

---

## Credits & Contributions

Created by \[Xolani Shongwe]. Community contributions are welcome!

Want to improve or extend DevForge? PRs are welcome 🙌