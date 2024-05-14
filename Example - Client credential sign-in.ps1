Import-Module CustomSecurityAttribute

# Connect using client credentials
$Credential = Get-Credential -Message "Enter the credentials for the client application, with clientid as username and client secret as password"
Connect-MgGraph -ClientSecretCredential $Credential -TenantId "00000000-0000-0000-0000-000000000000"

# Build cache using custom attribute (takes 15 seconds with 60000 users)
Build-CustomSecurityAttributeCache -CustomAttribute extension_03328900367942dcaf2f490f6ec6a996_houseIdentifier -ClearCache

# Update the custom security attribute values for a user by key
Set-CustomSecurityAttributeValues -Key '#1234929#123#0#' -AttributeSet personalinformation -Values @{nin = "Test2"} -Verbose