
# change PASSWORD and USERNAME
# change API URLS to the right instance
# change the 
# first line calls to get the token and stores in a variable called token
# second line calls the api query and uses the token for authorization

token=$(curl -s -X POST "https://gateway.qg1.apps.qualys.eu/auth" -H "Content-Type: application/x-www-form-urlencoded" -d "username=quays-pu8&password=FMrKPRhI&token=true&permissions=true")

curl --location 'https://gateway.qg1.apps.qualys.eu/rest/2.0/upsert/am/businessapp/metadata' \
--header 'X-Requested-With: QualysPostman' \
--header 'Content-Type: application/json' \
--header "Authorization:bearer ${token}" \
--data '
{
 "data": [
 			{
 				"businessAppId": "2fc86c650a0a0bb4003698b5331640df",
 				"name": "Banking Service",
				"businessCriticality": "1 - Most Critical",
 				"status": "Installed",
				"environment": "Production",
				"usedFor": "Production",
 				"created": 1620643264000,
 				"lastUpdated": 1620653309000,
 				"operationalStatus": "Installed",
 				"ownedBy": "Joey Bolick",
 				"managedBy": "Byron Fortuna",
 				"supportedBy": "John Doe",
 				"supportGroup": "IT Operations"
 			}
		 ]
}'

#pjuster@136194-MBP Documents % ./Qualys-API-Business-app-import.sh 
#{"requestId":"f9fef0e8-02ac-4dca-9e19-43be38fd1a16","responseMessage":"Failed to import asset metadata","responseCode":"FAILED","failedIds":["null"]}%          pjuster@136194-MBP Documents % 
