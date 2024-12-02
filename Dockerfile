FROM mcr.microsoft.com/windows/servercore:ltsc2022-amd64

RUN Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

RUN choco install -y mingw cmake.portable git
RUN $env:Path += ";C:\ProgramData\mingw64\mingw64\bin"

RUN cmake --version && gcc --version

RUN git clone https://github.com/rlguy/Blender-FLIP-Fluids.git /flop
RUN copy flop\cmake\CMakeLists.txt flop

WORKDIR /flop/build

RUN cmake.exe -G "MinGW Makefiles" ..

CMD ["cmake.exe --build", "."]