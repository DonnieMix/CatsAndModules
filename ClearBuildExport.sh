# Clean build folder
xcodebuild clean -workspace CatsAndModules.xcworkspace -scheme CatsAndModules -configuration Release

# Create archive
xcodebuild archive -workspace CatsAndModules.xcworkspace -scheme CatsAndModules -configuration Release -archivePath ./build/CatsAndModules.xcarchive -sdk iphoneos

# Export archive
xcodebuild -exportArchive -archivePath ./build/CatsAndModules.xcarchive -exportOptionsPlist ./exportOptions.plist -exportPath ./Exported 