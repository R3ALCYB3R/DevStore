import json
import os

# --- DEVSTORE CONFIGURATION ---
STORE_NAME = "DevStore"
STORE_ID = "com.r3alcyb3r.devstore"
BASE_URL = "https://raw.githubusercontent.com/R3ALCYB3R/DevStore/main"

def generate_source():
    print(f"--- 🛠️ {STORE_NAME} Source Generator ---")
    
    # 1. Define your apps here
    apps_list = [
        {
            "name": "DevHelper",
            "bundleIdentifier": "com.r3alcyb3r.devhelper",
            "developerName": "R3ALCYB3R",
            "version": "1.0.0",
            "versionDate": "2026-03-24",
            "downloadURL": f"{BASE_URL}/ipas/DevHelper.ipa",
            "localizedDescription": "Access the DevStore ecosystem. Includes 10s secure start and JIT activation.",
            "iconURL": f"{BASE_URL}/assets/icons/classic.png",
            "tintColor": "#3498db",
            "size": 0
        },
        {
            "name": "SwitchUI Emulator",
            "bundleIdentifier": "com.r3alcyb3r.switchui",
            "developerName": "R3ALCYB3R",
            "version": "1.2.5",
            "versionDate": "2026-03-24",
            "downloadURL": f"{BASE_URL}/ipas/SwitchUI.ipa",
            "localizedDescription": "High-performance Switch emulation for iOS. Managed by DevHelper.",
            "iconURL": f"{BASE_URL}/assets/icons/switchui.png",
            "tintColor": "#e74c3c",
            "size": 0
        }
    ]

    # 2. Build the final JSON structure
    source_data = {
        "name": STORE_NAME,
        "identifier": STORE_ID,
        "subtitle": "High-Performance iOS Tools",
        "description": "The official source for DevHelper and custom JIT-enabled apps by R3ALCYB3R.",
        "iconURL": f"{BASE_URL}/assets/icons/store_icon.png",
        "headerURL": f"{BASE_URL}/assets/header.png",
        "apps": apps_list
    }

    # 3. Write to apps.json
    try:
        with open('apps.json', 'w') as f:
            json.dump(source_data, f, indent=2)
        print("[SUCCESS] apps.json has been updated!")
    except Exception as e:
        print(f"[ERROR] Could not save file: {e}")

if __name__ == "__main__":
    generate_source()
