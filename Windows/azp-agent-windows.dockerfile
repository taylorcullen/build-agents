# Use a Windows Server core image as the base
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Install Chocolatey
RUN powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command " \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

# Install Development Toolset
RUN choco install -y dotnet-6.0-sdk && \
    choco install -y dotnet-8.0-sdk && \
    choco install -y dotnet-9.0-sdk && \
    choco install -y powershell-core && \
    choco install -y azure-cli && \
    choco install -y k6 && \
    choco install -y gitversion.portable && \
    choco install -y microsoft-build-tools && \
    choco install -y msbuild.communitytasks && \
    choco install -y msbuild.extensionpack && \
    choco install -y omnisharp && \
    choco install -y webdeploy && \
    choco install -y nodejs-lts && \
    choco install -y netfx-4.5.2-devpack && \
    choco install -y netfx-4.7.2-devpack && \
    choco install -y nuget.commandline && \
    choco install -y gitversion.portable && \
    choco install -y python

WORKDIR /azp/

COPY ./start.ps1 ./

CMD powershell .\start.ps1
