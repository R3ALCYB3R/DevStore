import os
import json

def update_store():
    app_list = []
    ipa_folder = 'ipas'
    
    if not os.path.exists(ipa_folder):
        os.makedirs(ipa_folder)

    for file in os.listdir(ipa_folder):
        if file.endswith(".ipa"):
            app_entry = {
                "name": file.replace(".ipa", ""),
                "bundleIdentifier": f"com.r3alcyb3r.{file.replace('.ipa', '').lower()}",
                "developerName": "R3ALCYB3R",
                "version": "1.0.0",
                "downloadURL": f"https://github.com/R3ALCYB3R/DevStore/raw/main/ipas/{file}",
                "iconURL": "https://github.com/R3ALCYB3R/DevStore/raw/main/assets/icons/overdrive.png",
                "description": "Sideloaded via DevStore Automation."
            }
            app_list.append(app_entry)

    store_data = {
        "name": "DevStore",
        "identifier": "com.r3alcyb3r.devstore",
        "apps": app_list
    }

    with open('apps.json', 'w') as f:
        json.dump(store_data, f, indent=4)

if __name__ == "__main__":
    update_store()
