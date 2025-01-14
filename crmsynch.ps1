$ALProjectpath = "C:\Temp\Vulkan-Verlag\"
$PackageCacheSymbolsPath = "C:\Temp\Vulkan-Verlag\.alpackages\"
$CDSServiceURL = "https://vulkanverlaggmbh.crm4.dynamics.com/"
$Entities = "account"
$altpgen = "C:\Users\Marcel Clören\.vscode\extensions\ms-dynamics-smb.al-13.1.1065068\bin\win32\altpgen\altpgen.exe"
$BaseID = 70000
$clientid = "0fe63e01-c90a-43a9-8e19-5db620539484 "
$redirecturi ="msal0fe63e01-c90a-43a9-8e19-5db620539484://auth"
$arg = "-project:$ALProjectpath -packagecachepath:$PackageCacheSymbolsPath -serviceuri:$CDSServiceURL -entities:$Entities -baseid:$BaseID -clientid:$clientid -redirecturi:$redirecturi"

$command = New-Object "Diagnostics.ProcessStartInfo"
$command.FileName = $altpgen
$command.Arguments = $arg
$command.UseShellExecute = $false
[diagnostics.process]::start($command)
