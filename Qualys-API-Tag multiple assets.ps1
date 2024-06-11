 
# Input the User and Password and Save the following Powershell Script.
# 
 
#Qualys authentications

$user ='**********’

$password = "******************"

$pair = "$($user):$($Password)"

$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))

$basicAuthValue = "Basic $encodedCreds"

 

 

# Set API Header

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"

$headers.Add("X-Requested-With", "QualysPostman")

$headers.Add("Authorization", $basicAuthValue)

$headers.Add("Content-Type", "text/xml")

 

# Import the Spreadsheet

$file = Import-Excel -path "U:\Downloads\input_data.xlsx" -WorksheetName "Laptops" #-StartRow 1 -EndRow 10

 
foreach ($row in $file | where {$_.MachineName -ne $null})

{

# Get Asset ID

$body = @"

<ServiceRequest>

  <filters>

    <Criteria field=`"name`" operator=`"EQUALS`">$($row.MachineName)</Criteria>

  </filters>

</ServiceRequest>

"@

$Search_AssetID_URL = https://qualysapi.qualys.eu/qps/rest/2.0/search/am/asset

$response_AssetID = Invoke-RestMethod -Uri $Search_AssetID_URL -Method Post -Headers $headers -Body $Body -ErrorAction SilentlyContinue

$AssetID = $response_AssetID.ServiceResponse.data.Asset.id

 
if ($AssetID -ne $null ) #-and $_.Ring -ne "Ring 7")

{

# Get Tag ID

$body = @"

<ServiceRequest>

<filters>

<Criteria field="name" operator="EQUALS">$($row.Ring)</Criteria>

</filters>

</ServiceRequest>

"@

$Get_AssetTagID_URL = https://qualysapi.qualys.eu/qps/rest/2.0/search/am/tag?fields=id,name

$response_AssetTagID = Invoke-RestMethod -Uri $Get_AssetTagID_URL -Method Post -Headers $headers -Body $Body

$AssetTagID = $response_AssetTagID.ServiceResponse.data.Tag.id

 

# Update Asset to add the Tag

$body = @"

<ServiceRequest>

<data>

<HostAsset>

<tags><add>

<TagSimple><id>$AssetTagID</id></TagSimple>

</add>

</tags>

</HostAsset>

</data>

</ServiceRequest>

"@

$Apply_AssetTag_URL = https://qualysapi.qualys.eu/qps/rest/2.0/update/am/hostasset/$AssetID

$response_Apply_AssetTag = Invoke-RestMethod -Uri $Apply_AssetTag_URL -Method Post -Headers $headers -Body $Body

$response_Apply_AssetTag

write-host "hostname $($row.MachineName) has ID $AssetID and Tag $($row.Ring) has id $AssetTagID assigned"

 

}

else {

    write-host "Host $($row.MachineName) doesn't exits in Qualys or Tag need to set to Ring 7" -BackgroundColor yellow

    $row | export-csv -path U:\Downloads\All_Laptops_Not_Added_to_Qualys.csv -append

}

}