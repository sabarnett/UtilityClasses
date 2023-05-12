xcodebuild clean -scheme UtilityClasses -quiet

echo '*** Delete the iphone archive and rebuild'
rm -r './build/UtilityClasses.framework-iphoneos.xcarchive'

echo 'Build the documentation'
xcodebuild docbuild \
-scheme UtilityClasses \
-destination 'generic/platform=iOS' \
-quiet

echo 'Build the framework'
xcodebuild archive \
-scheme UtilityClasses \
-configuration Release \
-destination 'generic/platform=iOS' \
-archivePath './build/UtilityClasses.framework-iphoneos.xcarchive' \
-quiet \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES 

echo '*** Delete iphone simulator archive and rebuild'
rm -r './build/UtilityClasses.framework-iphonesimulator.xcarchive'

echo 'Build the documentation'
xcodebuild docbuild \
-scheme UtilityClasses \
-destination 'generic/platform=iOS Simulator' \
-quiet

echo 'Build the framework'
xcodebuild archive \
-scheme UtilityClasses \
-configuration Release \
-destination 'generic/platform=iOS Simulator' \
-archivePath './build/UtilityClasses.framework-iphonesimulator.xcarchive' \
-quiet \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

echo '*** Delete xcframework and rebuild'
rm -r './build/UtilityClasses.xcframework'

xcodebuild -create-xcframework \
-framework './build/UtilityClasses.framework-iphoneos.xcarchive/Products/Library/Frameworks/UtilityClasses.framework' \
-framework './build/UtilityClasses.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/UtilityClasses.framework' \
-output './build/UtilityClasses.xcframework'
