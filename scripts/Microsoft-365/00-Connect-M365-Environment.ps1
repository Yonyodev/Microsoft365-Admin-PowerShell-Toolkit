# Microsoft 365 Lab Connection Script
# Purpose: Connect to the Microsoft 365 lab environment

$LabAdminUPN = Read-Host "Enter the Lab Admin User Principal Name"
$TenantID = Read-Host "Enter the Tenant ID"

Disconnect-MgGraph -ErrorAction SilentlyContinue #This helps to disconnect any active session before connecting to the new one.
Disconnect-ExchangeOnline -ErrorAction SilentlyContinue -Confirm:$false #This helps to disconnect any active ExchangeOnline session before connecting to the new one.

$GraphScopes = @(
    "User.Read.All",
    "Group.Read.All",
    "Directory.Read.All",
    "Organization.Read.All" 
) # List of the permissions we'll use for this session.

# Connect to Microsoft Graph with the permissions specified in $GraphScopes
Connect-MgGraph -Scopes $GraphScopes -TenantId $TenantID 

$GraphContext = Get-MgContext

Write-Host "Connected to Microsoft Graph as $($GraphContext.Account)" -ForegroundColor Green

Connect-ExchangeOnline -UserPrincipalName $LabAdminUPN

Write-Host "Connected to Exchange Online as $LabAdminUPN" -ForegroundColor Green