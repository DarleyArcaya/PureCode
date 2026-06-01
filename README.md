# PureCode 🧹

<p align="center">
  <strong>A surgical, modular optimization tool built by developers, for developers.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Backend-FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white" alt="FastAPI"/>
  <img src="https://img.shields.io/badge/Frontend-Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter"/>
  <img src="https://img.shields.io/badge/Language-Python-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python"/>
  <img src="https://img.shields.io/badge/Language-Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"/>
</p>

---

## 📥 Downloads (Beta)

You can now try **PureCode** without needing to set up development environments!

| Platform | Status | Download Link |
| :--- | :--- | :--- |
| **Windows** | ✅ Stable Beta | [**Download .exe Installer**](https://github.com/DarleyArcaya/PureCode/releases/download/v0.5.0-beta/PureCode_V_0.5.0_Setup.exe) |
| **macOS** | 🏗️ In Progress | *Coming soon* |

---

## 🔍 Preview

<p align="center">
  <img src="screenshots/purecode.png" alt="PureCode Interface Preview" width="680" style="border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.2);"/>
</p>

---

## 💡 Why PureCode?

You know the drill: Gradle caches ballooning to 8GB, three Android SDK versions you haven't touched in months, Flutter artifacts from projects you barely remember. Every developer hits this wall eventually.

Yes, you could write a bash script. But **PureCode** gives you modularity, a visual interface, graceful error handling per tool, and a single entrypoint that scales as your stack grows.

Unlike generic system cleaners, **PureCode** is built by developers, for developers — it target-cleans complex development environments without touching your personal files, ensuring a safely optimized workstation every time.

### ⚡ Advantages of Modular Architecture
* 🎛️ **Total Control:** Each cleaning process (Gradle, Android Studio, PIP) lives in its own isolated module — run one or run all, you decide.
* 🚀 **Scalability:** Adding support for a new dev tool is as simple as dropping a new file inside the `core/` folder.
* 🛡️ **Fail-Safe Design:** If an IDE or process locks a specific folder, only that module skips gracefully — the rest of the cleanup finishes without interruption.

---

## 🛠️ Tech Stack

| Layer | Technology | Key Libraries / Engines |
| :--- | :--- | :--- |
| **Backend** | `FastAPI (Python 3.x)` | `os`, `stat`, `shutil` (Safe system IO) |
| **Frontend** | `Flutter (Dart)` | `http`, asynchronous UI states |

---

## 🔮 Upcoming Features

> 🚀 **Roadmap Update:** The **Windows Executable (`.exe`)** is now live! We are currently working on the **MacOS Executable (`.app`)** version. This will allow Mac users to launch PureCode as a lightweight desktop application with a single click—no Python, Flutter, or terminal setups required.

---

## 📁 Project Structure

```text
PureCode/
├── Source/
│   ├── api/                 # Backend (FastAPI Core)
│   │   ├── core/            # Specialized cleaning modules (.py)
│   │   ├── tests/           # Unit tests & validation scripts
│   │   └── main.py          # API gateway & Endpoints
│   └── client/              # Frontend (Flutter Cross-Platform)
│       ├── lib/             # Main Dart source code
│       ├── windows/         # Windows native build files
│       ├── macos/           # macOS native build files
│       └── pubspec.yaml     # Client dependencies & assets
├── screenshots/             # UI Visual Assets
├── .gitignore               # Root ignore settings
└── README.md                # Documentation
```

## Run Backend Server

``` bash
cd Source/api
uvicorn main:app --reload

```
```text
Access the interactive documentation at: http://127.0.0.1:8000/docs