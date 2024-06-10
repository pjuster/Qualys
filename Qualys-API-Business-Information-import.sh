
# change PASSWORD and USERNAME
# change API URLS to the right instance
# change the qualysAssetId
# first line calls to get the token and stores in a variable called token
# second line calls the api query and uses the token for authorization

token=$(curl -s -X POST "https://gateway.qg1.apps.qualys.eu/auth" -H "Content-Type: application/x-www-form-urlencoded" -d "username=USERNAME&password=PASSWORD&token=true&permissions=true")

curl --location 'https://gateway.qg1.apps.qualys.eu/rest/2.0/update/am/asset/business/metadata' \
--header 'X-Requested-With: QualysPostman' \
--header 'Content-Type: application/json' \
--header "Authorization:bearer ${token}" \
--data '
{
 "data": [
 {
 "qualysAssetId": "206595533",
 "metadata": {
 "operationalStatus": "Operational",
 "environment": "Production",
 "company": "ACME US",
 "department": "IT Operations",
 "ownedBy": "Joey Bolick",
 "managedBy": "Byron Fortuna",
 "supportedBy": "John Doe",
 "supportGroup": "IT Operations",
 "businessAppIds": ["2fc86c650a0a0bb4003698b5331640df"],
 "assignedLocation": {
 "name": "401 Biscayne St, Miami FL",
 "street": "401 Biscayne St, Miami FL",
 "city": "Miami",
 "state": "FL",
 "country": "USA"
 }
 }
 }
 ]
}'

