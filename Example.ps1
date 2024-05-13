Import-Module CustomSecurityAttribute

# Set the custom security attribute values for a user by ObjectId
Set-CustomSecurityAttributeValues -ObjectId 69a3afe6-f02d-440e-8556-69ae97acf2aa -AttributeSet School -Values @{Id = "Test3"}

# Set the custom security attribute values for a user by userPrincipalName
Set-CustomSecurityAttributeValues -UserPrincipalName "AlexW@M365x34906433.OnMicrosoft.com" -AttributeSet School -Values @{Id = "Test4"}

# Build look up cache
Build-CustomSecurityAttributeCache -Attribute employeeId

# Set the custom security attribute values for a user by key from the lookup cache (Requires cache to be built using Build-CustomSecurityAttributeCache first)
Set-CustomSecurityAttributeValues -Key "678" -AttributeSet School -Values @{Id = "Test5"; SchoolIds = @("School1", "School2", "School4")}