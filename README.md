# Gnomish Treasure Detector

**Gnomish Treasure Detector** is a World of Warcraft addon that alerts players when rare NPCs or treasures appear nearby.  
It features customizable notifications, a settings menu, and quick command shortcuts.

---

## 🌟 Features

-   **Alerts when a rare or treasure is nearby** ✅
-   **Customizable settings menu** in _Interface > AddOns_ 🎛️
-   **Slash Commands (`/gtd`)** for quick settings changes 🖥️
-   **Toggleable sound alerts** 🔊
-   **Chat output customization** (Raid Warning, Party, Guild, etc.) 💬
-   **Debug mode for testing** 🛠️
-   **Ignores specific vignettes to prevent spam** ⚙️
-   **Uses SavedVariables to persist settings** 💾

---

## 📥 Installation

### **Manual Installation**

1. **Download the Addon** from GitHub.
2. **Extract the folder** into: path/to/World of Warcraft/retail/Interface/AddOns/
3. Restart WoW and ensure the addon is **enabled** in the AddOns menu.

---

## 🛠 Usage

### **How to access the Settings menu**

1. Open **Game Menu (ESC)**
2. Click **Interface**
3. Select **AddOns**
4. Find **Gnomish Treasure Detector**

### **Quick Commands (`/gtd`)**

| Command           | Description                          |
| ----------------- | ------------------------------------ |
| `/gtd debug`      | Toggles Debug Mode                   |
| `/gtd sound`      | Toggles Sound Alerts                 |
| `/gtd chat say`   | Changes alert output to Say          |
| `/gtd chat yell`  | Changes alert output to Yell         |
| `/gtd chat raid`  | Changes alert output to Raid Warning |
| `/gtd chat party` | Changes alert output to Party        |
| `/gtd chat guild` | Changes alert output to Guild        |
| `/gtd menu`       | Opens the settings UI                |

---

## ⚙️ Settings

| Setting                 | Description                                      |
| ----------------------- | ------------------------------------------------ |
| **Enable Debug Mode**   | Logs detected, ignored, and missing vignettes    |
| **Enable Sound Alerts** | Plays a sound when a vignette is detected        |
| **Chat Output**         | Sends alerts to Raid Warning, Party, Guild, etc. |

✅ **All settings are saved automatically and persist after logout!**

---

## 🔧 Troubleshooting

### **Q: The addon is not working!**

-   Make sure the addon is **enabled** in the AddOns menu.
-   Try typing `/reload` in chat to refresh UI changes.

### **Q: I’m not hearing sound alerts.**

-   Check if **Enable Sound Alerts** is turned on in settings.
-   Make sure your **game sound** isn’t muted.

### **Q: I don’t want alerts for specific vignettes.**

-   Open `IgnoredVignettes.lua` and add them to the list.

### **Q: How do I change chat output?**

-   Use `/gtd chat [say/yell/raid/party/guild]` to set where alerts appear.

---

## 🛠 Upcoming planned features

-   **Minimap Button** for quick toggling of settings
-   **TomTom Integration** to set waypoints to detected vignettes

---

## 🐞 Bug / 🗣️ feature request

🔧 Found a bug or have a feature request? Open an issue on GitHub.

---
