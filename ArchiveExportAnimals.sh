
# Read script input parameter and add it to your Info.plist. Values can either be CATS or DOGS
ANIMAL=$1
/usr/libexec/PlistBuddy -c "Set :Animal $ANIMAL" CatsAndModules/Info.plist

# Clean build folder
xcodebuild clean -workspace CatsAndModules.xcworkspace -scheme CatsAndModules -configuration Release

# Create archive
xcodebuild archive -workspace CatsAndModules.xcworkspace -scheme CatsAndModules -configuration Release -archivePath ./build/CatsAndModules.xcarchive -sdk iphoneos

# Export archive
xcodebuild -exportArchive -archivePath ./build/CatsAndModules.xcarchive -exportOptionsPlist ./exportOptions.plist -exportPath ./Exported

# Rename export directory
EXPORT_DIR=./Exported
if [ $ANIMAL = "CATS" ]; then EXPORT_DIR="${EXPORT_DIR}_CATS"
elif [ $ANIMAL = "DOGS" ]; then EXPORT_DIR="${EXPORT_DIR}_DOGS"
fi
mv ./Exported $EXPORT_DIR 