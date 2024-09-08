import os, re, requests, subprocess, urllib.request, time, zipfile
from tqdm import tqdm
from win32com.client import Dispatch

DATA_NAME = "data.win"
GAME_NAME = "Game.exe"
GITHUB_LINK = "https://github.com/KingSlendy"
GITHUB_REPO = f"I-Wanna-Start-A-Party{"" if not os.path.exists("test") else "-Testers"}"
ZIP_NAME = "I Wanna Start A Party.zip"

class DownloadProgressBar(tqdm):
    def update_to(self, b = 1, bsize = 1, tsize = None):
        if tsize is not None:
            self.total = tsize

        self.update(b * bsize - self.n)


def main():
    if not os.path.exists(DATA_NAME) or os.path.getsize(DATA_NAME) < 30000000 or not os.path.exists(GAME_NAME):
        print("I Wanna Start A Party has not been found, exiting!")
        return

    if os.path.exists(ZIP_NAME):
        os.remove(ZIP_NAME)

    ver_parser = Dispatch('Scripting.FileSystemObject')
    version = ver_parser.GetFileVersion(GAME_NAME)

    if version == 'No Version Information Available':
        print("Error validating current version.")
        execute()
        return

    print("Validating new version...")
    http_tag_content = requests.get(f"{GITHUB_LINK}/{GITHUB_REPO}/releases/latest").content.decode("utf-8")
    
    try:
        new_game_version = re.search(r"<title>.*(\d+.\d+.\d+.\d+).*</title>", http_tag_content)[1]
    except:
        print("An error occurred during the version validation process.")
        execute()
        return

    if new_game_version == version:
        print("Game is up-to-date!")
        execute()
        return

    print(f"Update version found: {new_game_version}!")
    print(f"Downloading new version...")
    url_game_version = f"{GITHUB_LINK}/{GITHUB_REPO}/releases/download/{new_game_version}/I.Wanna.Start.A.Party.zip"

    try:
        with DownloadProgressBar(unit = 'B', unit_scale = True, miniters = 1, desc = "I Wanna Start A Party") as bar:
            urllib.request.urlretrieve(url_game_version, filename = ZIP_NAME, reporthook = bar.update_to)
    except:
        print("An error occurred during the downloading update process.")
        execute()
        return

    print("Update downloaded successfully!")

    with zipfile.ZipFile(ZIP_NAME, "r") as zip:
        zip.extractall(os.getcwd())

    os.remove(ZIP_NAME)
    execute()


def execute():
    print("Executing I Wanna Start A Party...")
    subprocess.Popen([GAME_NAME, "-launch"], shell = True)


if __name__ == "__main__":
    main()