$computers = Get-Content -Path (Join-Path -Path $PSScriptRoot -ChildPath "hosts.txt")
$OutputDir = Join-Path -Path $PSScriptRoot -ChildPath "ipconfig_outputs"
$FailedDir = Join-Path -Path $OutputDir -ChildPath "Failed"

#creates output folders
if (!(Test-Path -Path $OutputDir)){
	New-Item -ItemType Directory -Path $OutputDir | Out-Null
}
if (!(Test-Path -Path $FailedDir)){
	New-Item -ItemType Directory -Path $FailedDir | Out-Null
}

foreach ($computer in $computers) {
	if ([string]::IsNullOrWhiteSpace($computer)) { continue }

	try {
		#Runs ipconfig command on remote computers
		$IPConfigData = Invoke-Command -ComputerName $computer -ScriptBlock {
			ipconfig /all
		} -ErrorAction Stop

		#If the command succeeds, writes the data to text file
		$IPConfigFile = Join-Path -Path $OutputDir -ChildPath "$computer.txt"
		$IPConfigData | Out-File -FilePath $IPConfigFile

		Write-Host "Success: $IPConfigFile created."
	} catch {
		#Defines failed path and outputs if remote command fails
		$FailedFile = Join-Path -Path $FailedDir -ChildPath "$computer.txt"
		$ErrorCode = $_.Exception.Message

		Write-Host "Failed: Could not connect to $computer. Reason: $ErrorCode"
		"Connection Failed: $ErrorCode" | Out-File -FilePath $FailedFile
	}
}