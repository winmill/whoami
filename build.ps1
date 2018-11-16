$ErrorActionPreference = 'SilentlyContinue';
$files = ""
Write-Host Starting build

docker version
sudo service start docker
docker version

if ($isWindows) {
  docker build --pull -t whoami -f Dockerfile.windows .
} else {
  docker build -t whoami --build-arg "arch=$env:ARCH" .
}

docker images
