function Build-CustomSecurityAttributeCache {
    [CmdletBinding(DefaultParameterSetName = "Well known attribute")]

    Param(
        [Parameter(Mandatory = $false, ParameterSetName = "Well known attribute")]
        [ValidateSet("id", "employeeId", "userPrincipalName", "mail")]
        [string] $Attribute = "userPrincipalName",

        [Parameter(Mandatory = $true, ParameterSetName = "Custom attribute")]
        [string] $CustomAttribute,

        [Parameter(Mandatory = $false)]
        [string] $Filter = $null,

        [Parameter(Mandatory = $false)]
        [Switch] $ClearCache
    )

    Begin {
        Assert-CustomSecurityAttributeConnection
    }

    Process {
        if($ClearCache.IsPresent) {
            $Script:LookupCache = @{}
        }
     
        $_Filter = $Filter ? "&`$filter=$Filter" : ""
        if ($PSCmdlet.ParameterSetName -eq "Well known attribute") {
            $uri = "https://graph.microsoft.com/beta/users?`$top=999&`$select=id,customSecurityAttributes,$($Attribute)$($_Filter)"
        }
        else {
            $uri = "https://graph.microsoft.com/beta/users?`$top=999&`$select=id,customSecurityAttributes,$($CustomAttribute)$($_Filter)"
        }

        while ($uri) {
            Write-Verbose "Getting users from $uri"
            $response = Invoke-MgGraphRequest -Uri $uri -Method Get
            $uri = $response.'@odata.nextLink'

            if ($response.value) {
                foreach ($user in $response.value) {
                    # Determine keys
                    $keys = @()
                    if ($PSCmdlet.ParameterSetName -eq "Well known attribute" -and $user.$Attribute) {
                        $keys = $user.$Attribute
                    }
                    elseif ($PSCmdlet.ParameterSetName -eq "Custom attribute" -and $user.$CustomAttribute) {
                        $keys = $user.$CustomAttribute
                    }
                    
                    # If key is set on the user, add to lookup cache, otherwise skip user
                    if ($keys) {
                        foreach ($key in $keys) {
                            if ($Script:LookupCache.ContainsKey($key) -and $ClearCache) {
                                Write-Warning "Duplicate key $key found in user lookup cache."
                            }
                            else {
                                $Script:LookupCache[$key] = $user
                            }
                        }
                    }
                }
            }
        }

        Write-Verbose "User lookup cache built with $($Script:LookupCache.Count) users."
    }
}