# Log in to Azure 
# Connect-AzAccount 

# List all subscriptions 
$subscriptions = Get-AzSubscription 

# Define the DNS servers 
$dnsServers = @("10.0.4.4", "10.0.4.5") 

# Iterate over each subscription 
foreach ($sub in $subscriptions) { 
    Write-Output "Processing subscription: $($sub.Name)" 
    Set-AzContext -SubscriptionId $sub.Id  
    
    # List all VNets in the current subscription 
    $vnets = Get-AzVirtualNetwork 
    
    # Iterate over each VNet and update DNS servers 
    foreach ($vnet in $vnets) { 
        Write-Output "Updating VNet: $($vnet.Name) in Resource Group: $($vnet.ResourceGroupName)" 
        $vnet.DhcpOptions.DnsServers = $dnsServers 
        $vnet | Set-AzVirtualNetwork 
    } 
} 

Write-Output "DNS server update completed for all VNets in all subscriptions."