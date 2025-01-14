$ALProjectpath = "C:\Users\MarcelClören\Desktop\Repositories\medialog-GmbH\"
$PackageCacheSymbolsPath = "C:\Users\MarcelClören\Desktop\Repositories\medialog-GmbH\.alpackages\"
$CDSServiceURL = "https://medialog-gmbh-co-kg.crm16.dynamics.com/"
$Entities = "account"
$altpgen = "C:\Users\MarcelClören\.vscode\extensions\ms-dynamics-smb.al-14.2.1249978\bin\win32\altpgen\altpgen.exe"
$BaseID = 70000
$clientid = "9f3cbdc3-0346-44f1-8d8a-972acedba98d"
$redirecturi ="http://localhost"
$arg = "-project:$ALProjectpath -packagecachepath:$PackageCacheSymbolsPath -serviceuri:$CDSServiceURL -entities:$Entities -baseid:$BaseID -clientid:$clientid -redirecturi:$redirecturi"

$command = New-Object "Diagnostics.ProcessStartInfo"
$command.FileName = $altpgen
$command.Arguments = $arg
$command.UseShellExecute = $false
[diagnostics.process]::start($command)
