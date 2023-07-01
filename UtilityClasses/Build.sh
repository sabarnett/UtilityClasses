#!/bin/zsh
setopt NOGLOB

cd "/Users/stevenbarnett/Documents/Code Files/Apps/Frameworks/UtilityClasses/UtilityClasses/"

destinations=("generic/platform=iOS" 
			  "generic/platform=iOS Simulator")
			  
archives=("./build/UtilityClasses.framework-iphoneos.xcarchive" 
		  "./build/UtilityClasses.framework-iphonesimulator.xcarchive")

frameworks=("./build/UtilityClasses.framework-iphoneos.xcarchive/Products/Library/Frameworks/UtilityClasses.framework"
			"./build/UtilityClasses.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/UtilityClasses.framework")

xcframework="./build/UtilityClasses.xcframework"

# ----------------------------------------------------------------------
#
# This is the build process. It is driven by the above variables
#
# ----------------------------------------------------------------------

length=${#destinations[@]}
for (( ix=1; ix<=length; ix++ ));
do
   echo "Clean ${destinations[$ix]}"
   xcodebuild clean \
   -scheme UtilityClasses \
   -destination "${destinations[$ix]}" \
   -configuration Debug \
   -quiet \
   -userdefault=DVTEnableCoreDevice=enabled

   rm -r "${archives[$ix]}"
   
   echo "Build documentation for ${destinations[$ix]}"

   xcodebuild docbuild \
   -scheme UtilityClasses \
   -destination "${destinations[$ix]}" \
   -quiet \
   -userdefault=DVTEnableCoreDevice=enabled

   echo "Build the framework for ${destinations[$ix]}"

   xcodebuild archive \
   -scheme UtilityClasses \
   -configuration Release \
   -destination "${destinations[$ix]}" \
   -archivePath "${archives[$ix]}" \
   -quiet \
   SKIP_INSTALL=NO \
   BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
   -userdefault=DVTEnableCoreDevice=enabled

done

echo '*** Delete xcframework and rebuild'
rm -r "${xcframework}"

params=("-create-xcframework")
for fwk in "${frameworks[@]}"
do
	params+=("-framework")
	params+=("${fwk}")
done
params+=("-output")
params+=("${xcframework}")

xcodebuild ${params[@]}
