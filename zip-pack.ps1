del AnUntitledStory-PopTrackerPack.zip
del output\* -Recurse

$files = "images\", "items\", "layouts\", "locations\", "maps\", "scripts\", "manifest.json", "settings.json"
foreach($file in $files) {
    Copy-Item $file -Destination output\ -Recurse
}

cd output
7z a -tzip ..\AnUntitledStory_PopTrackerPack.zip *
cd ..