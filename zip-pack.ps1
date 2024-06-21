rm -r output/

xcopy images items layouts locations maps scripts manifest.json settings.json output

7z a -tzip AnUntitledStory-PopTrackerPack.zip output\*