@echo off
echo ============================================
echo   ERPNext v15 + Healthcare + Payments Setup
echo ============================================
echo.

:: Check Docker is installed
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not installed.
    echo Install it from: https://www.docker.com/products/docker-desktop/
    exit /b 1
)

:: Check Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is installed but not running.
    echo Please start Docker Desktop and try again.
    exit /b 1
)

:: Check if .env already exists
if exist .env (
    echo .env file already exists.
    set /p overwrite="Overwrite it? (y/N): "
    if /i not "%overwrite%"=="y" (
        echo Keeping existing .env. Starting containers...
        docker compose up -d
        echo.
        echo Done! Open http://localhost:3000
        exit /b 0
    )
)

:: Ask for passwords
echo Set your passwords (these are stored locally in .env):
echo.
set /p db_pass="Database password [default: admin]: "
set /p admin_pass="Admin login password [default: admin]: "

:: Use defaults if empty
if "%db_pass%"=="" set db_pass=admin
if "%admin_pass%"=="" set admin_pass=admin

:: Create .env
(
echo # ERPNext v15 + Healthcare + Payments
echo DB_PASSWORD=%db_pass%
echo ADMIN_PASSWORD=%admin_pass%
) > .env

echo.
echo .env file created.
echo.
echo Starting ERPNext...
docker compose up -d

echo.
echo ============================================
echo   Setup complete!
echo ============================================
echo.
echo   Wait 3-5 minutes for first-time setup.
echo   Then open: http://localhost:3000
echo.
echo   Login:    Administrator
echo   Password: (the admin password you just set)
echo.
echo   Check progress: docker compose logs -f create-site
echo ============================================
