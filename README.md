All scripts have been tested on a Mac in a basic terminal and are supplied as is.

Resources used
https://www.qualys.com/documentation/#apis


Qualys-API-tag-total.sh - outputs a count for the total number of assets with the specified tag.

Qualys-API-CustomAttribute-total.sh - outputs a count for the total number of assets with the specified custom attributes.

Qualys-API-Business-Information-import.sh - updates the business information for a single asset.

Qualys-API-Business-app-import.sh - creates a business app that can then be assigned to assets.

Note: in order to add a business app to an asset, the business app needs to be created first, even if the asset has the correct app ID it won't be linked until the app has been created and the asset refreshed.

Qualys-API-Tag multiple assets.ps1 - is an untested Windows powershell script that will assign a specific tag to a list of assets in an Excel file.

Excel file needs column A to be asset name, column B to be the tag to be applied to the asset.

**Caveats are this code is supplied As-Is and full testing is recommended before using in any production testing.**
