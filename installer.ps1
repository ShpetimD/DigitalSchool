# Introductory message
$line = "------------------------------------------------------------------------------"
Write-Host $line
Write-Host "# This script will install the following applications:" -ForegroundColor Cyan
Write-Host $line

$apps = @(
    "Google Chrome",
    "Git",
    "Notepad++",
    "Sublime Text",
    "Visual Studio Code",
    "Python",
    "Node.js",
    "DBeaver",
    "GitHub Desktop",
    "PyCharm Community",
    "Eclipse IDE for Java",
    "XAMPP",
    "Scratch",
    "Screen Builder",
    "Veyon Client",
    "WordPress"
)

foreach ($app in $apps) {
    Write-Host ("- " + $app) -ForegroundColor Green
}
Write-Host $line
Write-Host "# If you have any issues, please contact support: support@digitalschool.tech" -ForegroundColor Yellow
Write-Host $line
Write-Host "Press (Y) to continue, or (C) to cancel." -ForegroundColor Magenta


$choice = Read-Host
if ($choice -eq "Y" -or $choice -eq "y") {
    if (-not (Test-Path "$env:ProgramData\chocolatey")) {
        Write-Host "Chocolatey is not installed. Installing..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }

    $packages = @(
        "googlechrome",
        "notepadplusplus.install",
        "git",
        "winrar",
        "vscode",
        "python312",
        "nodejs.install",
        "dbeaver",
        "github-desktop",
        "sublimetext3",
        "pycharm-community",
        "veyon",
        "eclipse-java-oxygen",
        "xampp-81",
        "scratch",
        "scenebuilder"
    )

    foreach ($package in $packages) {
        Write-Host "Installing $package..."
        choco install $package -y --force --no-progress
    }

    Write-Host "Installing Octoparse..."
    
    Write-Host "Installing Octoparse..."
    try {
	$octoparseUrl = "https://download.octoparse.bazhuayu.com/client/en-US/win/Octoparse%20Setup%208.7.2.exe"  # Update URL when the new version release
        $output = "C:\temp\octoparse_setup.exe"
        if (-not (Test-Path "C:\temp")) {
            New-Item -ItemType Directory -Path "C:\temp" | Out-Null
        }
        Write-Host "Downloading Octoparse installer..."
        Invoke-WebRequest -Uri $octoparseUrl -OutFile $output
        Write-Host "Running Octoparse installer (manual interaction may be required)..."
        Start-Process -FilePath $output -Wait
        Write-Host "Octoparse installation initiated. Please complete any prompts."
    } catch {
        Write-Host "Failed to download or run Octoparse installer: $_"
        Write-Host "Please download and install Octoparse manually from https://www.octoparse.com/download"
    }

    
      Write-Host "Downloading and setting up WordPress..."
    try {
        $wordpressUrl = "https://wordpress.org/latest.zip"
        $zipPath = "C:\temp\wordpress.zip"
        $extractPath = "C:\xampp\htdocs"

              if (-not (Test-Path "C:\temp")) {
            New-Item -ItemType Directory -Path "C:\temp" | Out-Null
            Write-Host "Created C:\temp directory."
        }

        Write-Host "Downloading WordPress from $wordpressUrl..."
        Invoke-WebRequest -Uri $wordpressUrl -OutFile $zipPath

	if (-not (Test-Path $extractPath)) {
            New-Item -ItemType Directory -Path $extractPath | Out-Null
            Write-Host "Created $extractPath directory."
        }

        Write-Host "Extracting WordPress to $extractPath..."
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $extractPath)

              Remove-Item -Path $zipPath -Force
        Write-Host "WordPress has been extracted to $extractPath. Please proceed with manual installation via http://localhost after starting XAMPP."
    } catch {
        Write-Host "Failed to download or extract WordPress: $_"
        Write-Host "Please download WordPress manually from https://wordpress.org/latest.zip and extract it to C:\xampp\htdocs"
    }

    Write-Host "All installations completed."
} else {
    Write-Host "Installation cancelled by user."
}

