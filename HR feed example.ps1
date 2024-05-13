Import-Module CustomSecurityAttribute

# Build look up cache based on employeeId (The key we use between Entra ID and HR)
Build-CustomSecurityAttributeCache -Attribute employeeId

# Set HR source data
$hrdata = "employeeid,secretid
123,Test1
234,Test2
345,Test3
456,Test4" | ConvertFrom-Csv

$hrdata | ForEach-Object {
    Set-CustomSecurityAttributeValues -Key $_.employeeid -AttributeSet School -Values @{Id = "$($_.secretid)"}
}