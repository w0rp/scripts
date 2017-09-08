# This PowerShell script sets up a newly installed Windows machine so it's
# ready to be used for running ALE Vader tests quickly.

Add-Type -A System.IO.Compression.FileSystem
$wc = New-Object System.Net.WebClient

if (!(Test-Path -Path 'C:\Program Files (x86)\Vim\vim80\vim.exe')){
  echo 'Installing Vim...'
  $wc.DownloadFile('ftp://ftp.vim.org/pub/vim/pc/gvim80-586.exe', "$env:temp\vim-installer.exe")
  & "$env:temp\vim-installer.exe"
  Read-Host 'Press any key to continue after installing Vim'
}

if (!(Test-Path -Path 'C:\Program Files\git')){
  echo 'Installing git...'
  $wc.DownloadFile('https://github.com/git-for-windows/git/releases/download/v2.14.1.windows.1/Git-2.14.1-64-bit.exe', "$env:temp\git-installer.exe")
  & "$env:temp\git-installer.exe"
  Read-Host 'Press any key to continue after installing git'
}

if (!(Test-Path -Path "$env:USERPROFILE\vimfiles")){
  echo 'Installing my Vim config...'
  git clone --recursive https://github.com/w0rp/vim.git "$env:USERPROFILE\vimfiles" 2> $null
}

# Download minimal Vim executables and runtimes, and unzip them.
if (!(Test-Path -Path C:\vim)){
  echo 'Installing minimal Vim...'
  $wc.DownloadFile('ftp://ftp.vim.org/pub/vim/pc/vim80-586w32.zip', "$env:temp\vim.zip")
  [IO.Compression.ZipFile]::ExtractToDirectory("$env:temp\vim.zip", 'C:\vim')
  $wc.DownloadFile('ftp://ftp.vim.org/pub/vim/pc/vim80-586rt.zip', "$env:temp\rt.zip")
  [IO.Compression.ZipFile]::ExtractToDirectory("$env:temp\rt.zip", 'C:\vim')
}

# Download Vader if needed, and check out the commit we want.
if (!(Test-Path -Path C:\vader)){
  echo 'Installing Vader...'
  git clone https://github.com/junegunn/vader.vim.git C:\vader 2> $null
  pushd C:\vader
  git checkout -qf c6243dd81c98350df4dec608fa972df98fa2a3af 2> $null
  popd
}

if (!(Test-Path -Path C:\projects\ale)){
  echo 'Setting up ALE project...'
  if (!(Test-Path -Path C:\projects)){
    New-Item -ItemType directory -Path C:\projects
  }
  git clone https://github.com/w0rp/ale.git C:\projects\ale 2> $null
}

echo 'Good to go!'
