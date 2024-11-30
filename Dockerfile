FROM mcr.microsoft.com/windows/servercore:ltsc2025

RUN powershell -Command \
    Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

RUN choco install -y mingw cmake git

RUN setx /M PATH "%PATH%;C:\tools\mingw64\bin"

RUN cmake --version && gcc --version

RUN https://github.com/rlguy/Blender-FLIP-Fluids.git /flop

WORKDIR /flop/build

RUN cmake.exe -G "MinGW Makefiles" ..

CMD ["cmake.exe --build", "."]