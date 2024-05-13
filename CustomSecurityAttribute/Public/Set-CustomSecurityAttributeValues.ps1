<#
.SYNOPSIS
    Updates the custom security attribute values for a user.

.DESCRIPTION
    Updates the custom security attribute values for a user. The user can be specified by key (for the cache), ObjectId, or UserPrincipalName.

.EXAMPLE
    Set-CustomSecurityAttributeValues -Key "321" -AttributeSet School -Values @{Grade = "A"; Teacher = "Mr. Smith"}

    Updates the custom security attribute values for the user with key "321" in the cache with the new values.

.EXAMPLE
    Set-CustomSecurityAttributeValues -ObjectId "12345678-1234-1234-1234-123456789012" -AttributeSet School -Values @{Grade = "A"; Teachers = @("Mr. Smith"; "Ms. Johnson"}

    Updates the custom security attribute values for the user with ObjectId "12345678-1234-1234-1234-123456789012" with the new values.
#>
function Set-CustomSecurityAttributeValues {
    [CmdletBinding(DefaultParameterSetName = 'Cache', SupportsShouldProcess = $true)]

    Param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Cache')]
        [string] $Key,

        [Parameter(Mandatory = $true, ParameterSetName = 'ObjectId')]
        [string] $ObjectId,

        [Parameter(Mandatory = $true, ParameterSetName = 'UserPrincipalName')]
        [string] $UserPrincipalName,

        [Parameter(Mandatory = $true)]
        [string] $AttributeSet,

        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable] $Values
    )

    Begin {
        Assert-CustomSecurityAttributeConnection
    }

    Process {
        $User = $null
        if ($PSCmdlet.ParameterSetName -eq 'Cache') {
            if (!$Script:LookupCache.ContainsKey($Key)) {
                Write-Error "User with key $Key not found in lookup cache." -ErrorAction Stop
            }
    
            $User = $Script:LookupCache[$Key]

            # Determine if there are any differences between the existing attribute set and the new values
            $IsDifferent = $Values.Keys | ForEach-Object {
                Compare-Object ($User.customSecurityAttributes.$AttributeSet.$_ ?? @()) ($Values.$_ ?? @())
            }

            if(!$IsDifferent) {
                Write-Verbose "No differences found between existing and new values. Skipping update."
                return
            }

            # Update cache
            $User.customSecurityAttributes.$AttributeSet = $Values

            $uri = "https://graph.microsoft.com/beta/users/$($User.id)"
        }
        elseif ($PSCmdlet.ParameterSetName -eq 'ObjectId') {
            $uri = "https://graph.microsoft.com/beta/users/$($ObjectId)"
        }
        else {
            $uri = "https://graph.microsoft.com/beta/users/$($UserPrincipalName)"
        }

        

        # Create body for updating the user with the new values
        $body = @{
            customSecurityAttributes = @{
                "$AttributeSet" = @{
                    "@odata.type" = "#Microsoft.DirectoryServices.CustomSecurityAttributeValue"
                }
            }
        }

        # Add values to the body
        $Values.GetEnumerator() | ForEach-Object {
            $body.customSecurityAttributes.$AttributeSet[$_.Key] = $_.Value
        }

        # Update user
        Write-Verbose "Updating user $($uri) with new values."
        Invoke-MgGraphRequest -Uri $uri -Method Patch -Body ($body | ConvertTo-Json -Depth 10) -Verbose:$false -ContentType "application/json"
    }
}