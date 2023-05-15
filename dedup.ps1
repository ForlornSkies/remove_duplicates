# Set system arguments we are passing in
$initialData = $args[0]
$finalData = $args[1]

# If system arg have values then dedup the values and create new text file
if (($initialData) -and ($finalData)){
    # Get contents of file, trim extra lines/spaces, get unique values and append to final text file
    Get-Content $initialData | ? {$_.trim() -ne ""} | Get-Unique | Add-Content -Path $finalData

    # Powershell is bad in how it adds an extra line at the bottom of our text file, so removing that.
    $FileContents = Get-Content $finalData -Raw
    $FileContents = $FileContents.TrimEnd()
    $FileContents | Set-Content $finalData -NoNewline | Add-Content -Path $finalData
    
    # Update user
    Write-Output "[+] Process Complete"
}else{
    # Update user of usage if an argument is missing
    Write-Output "[*] Usage: dedup.ps1 originaldata.txt dedupeddata.txt"
}
