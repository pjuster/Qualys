
# change PASSWORD and USERNAME
# change API URLS to the right instance
# change TEST to the desired TAG name
# script called using - while true; do ./Qualys-API-tag.sh >> output.txt ; sleep 600; done
# first line calls to get the token and stores in a variable called token
# second line calls the api query and uses the token for authorization

token=$(curl -s -X POST "https://gateway.qg1.apps.qualys.eu/auth" -H "Content-Type: application/x-www-form-urlencoded" -d "username=USERNAME&password=PASSWORD&token=true&permissions=true")

curl --location 'https://gateway.qg1.apps.qualys.eu/rest/2.0/count/am/asset' \
--header 'X-Requested-With: QualysPostman' \
--header 'Content-Type: application/json' \
--header "Authorization:bearer ${token}" \
--data '{
    "filters": [
        {
            "field": "customAttributes.value",
            "operator": "CONTAINS",
            "value": "TEST"
        }
    ]
}'
echo $(date)
