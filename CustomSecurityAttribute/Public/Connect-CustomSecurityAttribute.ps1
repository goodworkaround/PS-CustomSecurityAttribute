<#
.SYNOPSIS
    Connects to the Microsoft Graph API with the required permissions for custom security attributes. Currently only interactive sign-in, but feel free to Connect-MgGraph with application credentials manually.

.EXAMPLE
    Connect-CustomSecurityAttribute -TenantId "contoso.onmicrosoft.com"

    Connects to the Microsoft Graph API with the required permissions for custom security attributes for the tenant contoso.onmicrosoft.com.
#>
function Connect-CustomSecurityAttribute {
    [CmdletBinding(DefaultParameterSetName = 'Interactive')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'Interactive')]
        [string] $TenantId
    )

    Process {
        # TODO? Add support for client credentials
        #if($PSCmdlet.ParameterSetName -eq 'Interactive') {
        Connect-MgGraph -Scopes "CustomSecAttributeAssignment.ReadWrite.All", "User.Read.All" -TenantId $TenantId
        #}
    }
}