@echo off
setlocal enabledelayedexpansion

REM Script to build and push the SwarmUI Docker image to Docker Hub
REM Usage: build-push-docker.bat [username]

REM Default to environment variable if set, otherwise use argument
if defined DOCKERHUB_USERNAME (
    set DOCKER_USERNAME=%DOCKERHUB_USERNAME%
) else (
    set DOCKER_USERNAME=%1
)

REM Check if username is provided
if "%DOCKER_USERNAME%"=="" (
    echo Error: Docker Hub username not provided
    echo Usage: build-push-docker.bat [username]
    echo    or set DOCKERHUB_USERNAME environment variable
    exit /b 1
)

echo Building Docker image for %DOCKER_USERNAME%/swarmui:latest

REM Build the Docker image
docker build -t %DOCKER_USERNAME%/swarmui:latest -f launchtools/StandardDockerfile.docker .

REM Check if build was successful
if %ERRORLEVEL% neq 0 (
    echo Error: Docker build failed
    exit /b 1
)

echo Docker image built successfully

REM Ask for confirmation before pushing
set /p PUSH_CONFIRM=Do you want to push the image to Docker Hub? (y/n): 

if /i "%PUSH_CONFIRM%"=="y" (
    echo Pushing image to Docker Hub...
    
    REM Check if user is logged in to Docker Hub
    docker info | findstr "Username" > nul
    if %ERRORLEVEL% neq 0 (
        echo You are not logged in to Docker Hub
        echo Please run 'docker login' first
        exit /b 1
    )
    
    REM Push the image
    docker push %DOCKER_USERNAME%/swarmui:latest
    
    if %ERRORLEVEL% neq 0 (
        echo Error: Failed to push image to Docker Hub
        exit /b 1
    )
    
    echo Image pushed successfully to %DOCKER_USERNAME%/swarmui:latest
) else (
    echo Push cancelled
)

echo Done 