# PureCode 🧹

**PureCode** is an optimization tool designed by developers, for developers. It focuses on "surgical cleaning" for development environments, removing unnecessary files that generic cleaners usually ignore.

---

## Why PureCode?

Unlike other cleaning tools, **PureCode** is built with a **modular philosophy**. It is not just one big script; it is an ecosystem of specialized modules.

### Advantages of Modular Architecture:
*   **Total Control**: Each cleaning process (Gradle, Android, VS Code) lives in its own independent file.
*   **Scalability**: Adding support for a new tool is as easy as creating a new file in the `core/` folder.
*   **Safety**: If an application is open and locks a file, only that specific module stops, allowing the others to finish their job.

---

## Tech Stack

*   **Backend**: [FastAPI](https://fastapi.tiangolo.com/) (Python 3.x)
*   **Frontend**: [Flutter](https://flutter.dev/) (Dart)
*   **Engine**: Python `os` and `shutil` libraries for safe file system manipulation.

---

## Project Structure

```text
PureCode/
├── Source/
│   ├── api/                 # Backend (FastAPI)
│   │   ├── core/            # Specialized cleaning modules (.py)
│   │   ├── tests/           # Unit tests and script validation
│   │   └── main.py          # API entry point and Endpoints
│   └── client/              # Frontend (Flutter Multi-platform)
│       ├── android/         # Android native files
│       ├── ios/             # iOS native files
│       ├── lib/             # Main Dart source code
│       ├── linux/           # Linux native files
│       ├── macos/           # macOS native files
│       ├── web/             # Web platform files
│       ├── windows/         # Windows native files
│       ├── pubspec.yaml     # Project dependencies and assets
│       └── .gitignore       # Client-specific ignore settings
├── .gitignore               # Root ignore settings
└── README.md                # Project documentation


```

## Run Backend Server

``` bash
cd Source/api
uvicorn main:app --reload

```
```text
Access the interactive documentation at: http://127.0.0.1:8000/docs