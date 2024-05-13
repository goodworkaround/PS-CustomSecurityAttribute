<#
.DESCRIPTION
    Asserts that the connection to the Microsoft Graph API is established using the Microsoft Graph module.
#>
function Assert-CustomSecurityAttributeConnection {
    [CmdletBinding()]
    param ()

    Process {
        $context = Get-MgContext

        if(-not $context) {
            Write-Error "Connection to Microsoft Graph API is not established. Please run Connect-MgGraph." -ErrorAction Stop
        }

        if($context.AuthType -eq "Delegated") {
            if("CustomSecAttributeAssignment.ReadWrite.All" -notin $context.Scopes) {
                Write-Error "The current session does not have the required scope CustomSecAttributeAssignment.ReadWrite.All." -ErrorAction Stop
            }
            
            if("User.Read.All" -notin $context.Scopes -and "User.ReadWrite.All" -notin $context.Scopes) {
                Write-Error "The current session does not have the required scope User.Read.All." -ErrorAction Stop
            }
        } else {
            if("CustomSecAttributeAssignment.ReadWrite.All" -notin $context.Scopes) {
                Write-Error "The current session does not have the required scope CustomSecAttributeAssignment.ReadWrite.All." -ErrorAction Stop
            }
            
            if("User.Read.All" -notin $context.Scopes -and "User.ReadWrite.All" -notin $context.Scopes) {
                Write-Error "The current session does not have the required scope User.Read.All." -ErrorAction Stop
            }
        }
    }
}