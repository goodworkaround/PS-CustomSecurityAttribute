<#
.SYNOPSIS
    Get the custom security attribute values for a specified user.

.DESCRIPTION
    Get the custom security attribute values for a specified user.

.EXAMPLE
    Get-CustomSecurityAttributeValues -Key "321"

.EXAMPLE
    Get-CustomSecurityAttributeValues -ObjectId "12345678-1234-1234-1234-123456789012"

.EXAMPLE
    Get-CustomSecurityAttributeValues -UserPrincipalName "test@contoso.onmicrosoft.com" -AttributeSet School
#>
function Get-CustomSecurityAttributeValues {
    [CmdletBinding(DefaultParameterSetName = 'Cache')]

    Param (
        # Get the values for the specified key from the lookup cache
        [Parameter(Mandatory = $true, ParameterSetName = 'Cache')]
        [string] $Key,

        # Get the values for the specified user by ObjectId
        [Parameter(Mandatory = $true, ParameterSetName = 'ObjectId')]
        [string] $ObjectId,

        # Get the values for the specified user by userPrincipalName
        [Parameter(Mandatory = $true, ParameterSetName = 'UserPrincipalName')]
        [string] $UserPrincipalName,

        # If set, only return the values for the specified attribute set
        [Parameter(Mandatory = $false, ParameterSetName = 'Cache')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ObjectId')]
        [Parameter(Mandatory = $false, ParameterSetName = 'UserPrincipalName')]
        [string] $AttributeSet
    )

    Begin {
        Assert-CustomSecurityAttributeConnection
    }

    Process {
        if ($PSCmdlet.ParameterSetName -eq 'Cache') {
            if (!$Script:LookupCache.ContainsKey($Key)) {
                Write-Error "User with key $Key not found in lookup cache."
                return
            }
    
            $User = $Script:LookupCache[$Key]
        }
        elseif ($PSCmdlet.ParameterSetName -eq 'ObjectId') {
            $uri = "https://graph.microsoft.com/beta/users/$($ObjectId)?`$select=customSecurityAttributes"
            $User = Invoke-MgGraphRequest -Uri $uri -Method Get
        }
        else {
            $uri = "https://graph.microsoft.com/beta/users/$($UserPrincipalName)?`$select=customSecurityAttributes"
            $User = Invoke-MgGraphRequest -Uri $uri -Method Get
        }

        if ($AttributeSet) {
            $User.customSecurityAttributes.$AttributeSet ?? @{}
        }
        else {
            $User.customSecurityAttributes ?? @{}
        }
    }
}