#!/bin/sh
# For your convenience
alias PlistBuddy=/usr/libexec/PlistBuddy
INFO_PLIST="./CatsAndModules-AnnaZhelizniak-Info.plist"
PROJECT_NAME="CatsAndModules_AnnaZhelizniak.xcodeproj"
SCHEME="CatsAndModules_AnnaZhelizniak"
DEST="generic/platform=iOS"
CONFIG=Release
VERSION="v1.0.0"
ARCHIVE_PATH="./ARCHIVES/${VERSION}.xcarchive"
EXPORT_PATH="./Exported_$1"
EXPORT_OPTIONS_PLIST="./exportOptions.plist"

# IMPLEMENT: 
# Read script input parameter and add it to your Info.plist. Values can either be CATS or DOGS
DATA_SOURCE=$1
if [ "${DATA_SOURCE}" != 'CATS' ] && [ "${DATA_SOURCE}" != 'DOGS' ]; then
    exit 1
fi

PlistBuddy -c "Set ':dataSource' ${DATA_SOURCE}" $INFO_PLIST

# IMPLEMENT:
# Clean build folder
xcodebuild -project "$PROJECT_NAME" -scheme "$SCHEME" clean -configuration "${CONFIG}"

# IMPLEMENT:
# Create archive
xcodebuild archive \
-archivePath "${ARCHIVE_PATH}" \
-scheme "${SCHEME}" \
-configuration "${CONFIG}" \
-destination "${DEST}"

# IMPLEMENT:
# Export archive
xcodebuild -exportArchive \
-archivePath "${ARCHIVE_PATH}" \
-exportPath "${EXPORT_PATH}" \
-exportOptionsPlist "${EXPORT_OPTIONS_PLIST}"
echo "Hello World"
