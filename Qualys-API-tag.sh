
# change PASSWORD and USERNAME
# change API URLS to the right instance
# change TEST to the desired TAG name

token=$(curl -s -X POST "https://gateway.qg1.apps.qualys.eu/auth" -H "Content-Type: application/x-www-form-urlencoded" -d "username=USERNAME&password=PASSWORD&token=true&permissions=true")

curl --location 'https://gateway.qg1.apps.qualys.eu/rest/2.0/count/am/asset' \
--header 'X-Requested-With: QualysPostman' \
--header 'Content-Type: application/json' \
--header "Authorization:bearer ${token}" \
--data '{
    "filters": [
        {
            "field": "tags.name",
            "operator": "CONTAINS",
            "value": "TEST"
        }
    ]
}'
echo $(date)
