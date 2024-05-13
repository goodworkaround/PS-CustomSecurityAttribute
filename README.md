# Documentation for module CustomSecurityAttribute

A PowerShell module for working with custom security attributes at scale

| Metadata | Information |
| --- | --- |
| Version | 1.0.1 |
| Required modules | Microsoft.Graph.Authentication |
| Author | Marius Solbakken Mellum |
| Company name | Goodworkaround |
| PowerShell version | 7.1 |

## Build-CustomSecurityAttributeCache

### SYNOPSIS
Builds a cache of users for fastest speeds when writing custom security attributes.

### SYNTAX

#### Well known attribute (Default)
```
Build-CustomSecurityAttributeCache [-Attribute <String>] [-Filter <String>] [-ClearCache]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

#### Custom attribute
```
Build-CustomSecurityAttributeCache -CustomAttribute <String> [-Filter <String>] [-ClearCache]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### DESCRIPTION
Builds a cache of users for fastest speeds when writing custom security attributes.

### EXAMPLES

#### EXAMPLE 1
```
Build-CustomSecurityAttributeCache -Attribute userPrincipalName
```

Builds a cache of users using the userPrincipalName attribute as key.

#### EXAMPLE 2
```
Build-CustomSecurityAttributeCache -CustomAttribute extension_12345678_myCustomAttribute
```

Builds a cache of users using the applicaton extension property extension_12345678_myCustomAttribute as key.

### PARAMETERS

#### -Attribute


```yaml
Type: String
Parameter Sets: Well known attribute
Aliases:

Required: False
Position: Named
Default value: UserPrincipalName
Accept pipeline input: False
Accept wildcard characters: False
```

#### -CustomAttribute


```yaml
Type: String
Parameter Sets: Custom attribute
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -Filter


```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -ClearCache


```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

### OUTPUTS

### NOTES

### RELATED LINKS
## Connect-CustomSecurityAttribute

### SYNOPSIS
Connects to the Microsoft Graph API with the required permissions for custom security attributes.
Currently only interactive sign-in, but feel free to Connect-MgGraph with application credentials manually.

### SYNTAX

```
Connect-CustomSecurityAttribute [-TenantId <String>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### DESCRIPTION


### EXAMPLES

#### EXAMPLE 1
```
Connect-CustomSecurityAttribute -TenantId "contoso.onmicrosoft.com"
```

Connects to the Microsoft Graph API with the required permissions for custom security attributes for the tenant contoso.onmicrosoft.com.

### PARAMETERS

#### -TenantId


```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

### OUTPUTS

### NOTES

### RELATED LINKS
## Get-CustomSecurityAttributeValues

### SYNOPSIS
Get the custom security attribute values for a specified user.

### SYNTAX

#### Cache (Default)
```
Get-CustomSecurityAttributeValues -Key <String> [-AttributeSet <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

#### ObjectId
```
Get-CustomSecurityAttributeValues -ObjectId <String> [-AttributeSet <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

#### UserPrincipalName
```
Get-CustomSecurityAttributeValues -UserPrincipalName <String> [-AttributeSet <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### DESCRIPTION
Get the custom security attribute values for a specified user.

### EXAMPLES

#### EXAMPLE 1
```
Get-CustomSecurityAttributeValues -Key "321"
```

#### EXAMPLE 2
```
Get-CustomSecurityAttributeValues -ObjectId "12345678-1234-1234-1234-123456789012"
```

#### EXAMPLE 3
```
Get-CustomSecurityAttributeValues -UserPrincipalName "test@contoso.onmicrosoft.com" -AttributeSet School
```

### PARAMETERS

#### -Key
Get the values for the specified key from the lookup cache

```yaml
Type: String
Parameter Sets: Cache
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -ObjectId
Get the values for the specified user by ObjectId

```yaml
Type: String
Parameter Sets: ObjectId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -UserPrincipalName
Get the values for the specified user by userPrincipalName

```yaml
Type: String
Parameter Sets: UserPrincipalName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -AttributeSet
If set, only return the values for the specified attribute set

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

### OUTPUTS

### NOTES

### RELATED LINKS
## Set-CustomSecurityAttributeValues

### SYNOPSIS
Updates the custom security attribute values for a user.

### SYNTAX

#### Cache (Default)
```
Set-CustomSecurityAttributeValues -Key <String> -AttributeSet <String> -Values <Hashtable>
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

#### ObjectId
```
Set-CustomSecurityAttributeValues -ObjectId <String> -AttributeSet <String> -Values <Hashtable>
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

#### UserPrincipalName
```
Set-CustomSecurityAttributeValues -UserPrincipalName <String> -AttributeSet <String> -Values <Hashtable>
 [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### DESCRIPTION
Updates the custom security attribute values for a user.
The user can be specified by key (for the cache), ObjectId, or UserPrincipalName.

### EXAMPLES

#### EXAMPLE 1
```
Set-CustomSecurityAttributeValues -Key "321" -AttributeSet School -Values @{Grade = "A"; Teacher = "Mr. Smith"}
```

Updates the custom security attribute values for the user with key "321" in the cache with the new values.

#### EXAMPLE 2
```
Set-CustomSecurityAttributeValues -ObjectId "12345678-1234-1234-1234-123456789012" -AttributeSet School -Values @{Grade = "A"; Teachers = @("Mr. Smith"; "Ms. Johnson"}
```

Updates the custom security attribute values for the user with ObjectId "12345678-1234-1234-1234-123456789012" with the new values.

### PARAMETERS

#### -Key


```yaml
Type: String
Parameter Sets: Cache
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -ObjectId


```yaml
Type: String
Parameter Sets: ObjectId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -UserPrincipalName


```yaml
Type: String
Parameter Sets: UserPrincipalName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -AttributeSet


```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -Values


```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### -ProgressAction


```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

#### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

### INPUTS

### OUTPUTS

### NOTES

### RELATED LINKS
