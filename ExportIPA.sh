APP_MODE=$1

if [ "${APP_MODE}" = "CATS" ]; then
 EXPORT_PATH="./Exported_CATS"
else
 if [ "${APP_MODE}" = "DOGS" ]; then
  EXPORT_PATH="./Exported_DOGS"
 else
  echo "Wrong mode"
  exit 1
 fi
fi

# VARS
PLIST_FILE=exportOptions.plist
PLIST_INFO="./CatsViewer/CatsViewer/Info.plist"
PLIST_TEMPLATE=exportOptionsTemplate.plist

WORKSPACE=CatsAndModules_DanyloBurliai.xcworkspace
SCHEME=CatsViewer
CONFIG=Debug
DEST="generic/platform=iOS"

VERSION="v1.0"
ARCHIVE_PATH="./Archives/${VERSION}.xcarchive"

# PLIST
alias PlistBuddy=/usr/libexec/PlistBuddy

cp $PLIST_TEMPLATE $PLIST_FILE

PlistBuddy -c "set :destination export" $PLIST_FILE
PlistBuddy -c "set :method development" $PLIST_FILE
PlistBuddy -c "set :signingStyle manual" $PLIST_FILE
PlistBuddy -c "set :teamID D85QWSUNYA" $PLIST_FILE
PlistBuddy -c "set :signingCertificate iPhone Developer: Danylo Burliai (XUAB5Q245A)" $PLIST_FILE
PlistBuddy -c "delete :provisioningProfiles:%BUNDLE_ID%" $PLIST_FILE
PlistBuddy -c "add :provisioningProfiles:ua.edu.ukma.apple-env.burliai.CatsViewer string c15dd7ff-0375-40fb-a9aa-05a10ad75298" $PLIST_FILE

PlistBuddy -c "set :AppMode ${APP_MODE}" $PLIST_INFO

# IMPLEMENT:
# Read script input parameter and add it to your Info.plist. Values can either be CATS or DOGS


# IMPLEMENT:
# Clean build folder
xcodebuild clean \
-workspace "${WORKSPACE}" \
-scheme "${SCHEME}" \
-configuration "${CONFIG}"

# IMPLEMENT:
# Create archive
xcodebuild archive \
-archivePath "${ARCHIVE_PATH}" \
-workspace "${WORKSPACE}" \
-scheme "${SCHEME}" \
-configuration "${CONFIG}" \
-destination "${DEST}"

# IMPLEMENT:
# Export archive
xcodebuild -exportArchive \
-archivePath "${ARCHIVE_PATH}" \
-exportPath "${EXPORT_PATH}" \
-exportOptionsPlist "${PLIST_FILE}"

rm -rf $ARCHIVE_PATH
rm -rf $PLIST_FILE
echo "App mode ${APP_MODE}"
