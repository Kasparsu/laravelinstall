$name = Read-Host -Prompt 'Input your git name'
$email = Read-Host -Prompt 'Input the git email'
group = Read-Host -Prompt 'Input the group name in lowercase example: kms21'
project = Read-Host -Prompt 'Input the laravel project git url'
winget install Microsoft.VisualStudioCode 
winget install JetBrains.PHPStorm 
winget install JetBrains.DataGrip
winget install  OpenJS.NodeJS
winget install Microsoft.WindowsTerminal 
winget install Git.Git
C:\Program Files\Git\bin\git config --global user.name $name
C:\Program Files\Git\bin\git config --global user.email $email
C:\Program Files\Git\bin\git config --global core.editor "code --wait"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
C:\ProgramData\Chocolatey\choco install php composer --yes
((Get-Content -path C:\tools\php82\php.ini -Raw) -replace ';extension=fileinfo','extension=fileinfo') | Set-Content -Path C:\tools\php82\php.ini
((Get-Content -path C:\tools\php82\php.ini -Raw) -replace ';extension=pdo_sqlite','extension=pdo_sqlite') | Set-Content -Path C:\tools\php82\php.ini
$json = (Get-Content 'C:\Users\kaspar.suursalu\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json' | Out-String | ConvertFrom-Json)

$toAdd = @"
[
	{
		"commandline": "C:\\Program Files\\Git\\bin\\bash.exe -i -l",
		"guid": "{39e4618b-bdba-47f9-b0ac-5abdf92a46d7}",
		"hidden": false,
		"icon": "C:\\Program Files\\Git\\mingw64\\share\\git\\git-for-windows.ico",
		"name": "Git Bash",
		"startingDirectory": "%USERPROFILE%"
    }
]
"@

$add = ConvertFrom-Json -InputObject $toAdd
$json.defaultProfile = '{39e4618b-bdba-47f9-b0ac-5abdf92a46d7}'
$json.profiles.list = $json.profiles.list + $add
(ConvertTo-Json $json -Depth 100) | Set-Content -Path C:\Users\kaspar.suursalu\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
New-Item -ItemType Directory -Force -Path $group
C:\'Program Files'\Git\bin\git clone $project $group\blog
Copy-Item $group\blog\.env.example -Destination $group\blog\.env
Push-Location $group\blog\
C:\tools\php82\php C:\ProgramData\ComposerSetup\bin\composer.phar install
C:\tools\php82\php artisan migrate --seed --force -n
C:\'Program Files'\nodejs\npm install
Pop-Location
