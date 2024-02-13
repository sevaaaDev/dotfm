function Traverse-Folder {
  param($path)
  foreach($dotPath in (ls $path).fullname) {
    $homePath = $dotPath.replace("$pwd", "$env:USERPROFILE")
    if (!( Test-Path -Path $homePath )) {
      New-Item -ItemType SymbolicLink -Path $homePath -Target $dotPath
      continue
    }
    # Write-Output "$dotPath => already exist" 
    if (Test-Path -Path $dotPath -PathType Container) {
      Traverse-Folder -Path $dotPath
    }
  }
}


Traverse-Folder -Path (pwd).path 
