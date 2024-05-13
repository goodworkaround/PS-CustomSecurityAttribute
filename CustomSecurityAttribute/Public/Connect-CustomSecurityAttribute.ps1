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