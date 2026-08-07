$sourceRoot = "C:\Users\divin\Desktop\Hollow Knight TTRPG"
$destRoot = "."  
$foldersToCopy = @("Core", "Assets", "Crests", "World")

foreach ($folder in $foldersToCopy) {
    Remove-Item -Recurse -Force $folder -ErrorAction SilentlyContinue
}

foreach ($folder in $foldersToCopy) {
    New-Item -ItemType Directory -Force $folder | Out-Null
}

foreach ($folder in $foldersToCopy) {
    $src = Join-Path $sourceRoot $folder
    $dst = Join-Path $destRoot $folder
    if (Test-Path $src) {
        robocopy $src $dst /E /XD "GM" /NJH /NJS /NP
    } else {
        Write-Warning "Source folder $src does not exist, skipping."
    }
}

Remove-Item README.md -ErrorAction SilentlyContinue

Copy-Item -Path $sourceRoot\README.md -Destination $destRoot

git add .
git commit -m "nerd"
git push