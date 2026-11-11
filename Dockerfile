FROM mcr.microsoft.com/windows/servercore:ltsc2022-amd64

RUN powershell -Command \
    Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

RUN choco install -y mingw cmake.portable git python
RUN setx /M PATH "%PATH%;C:\\ProgramData\\mingw64\\mingw64\\bin"
RUN copy C:\ProgramData\mingw64\mingw64\bin\mingw32-make.exe C:\ProgramData\mingw64\mingw64\bin\make.exe

RUN cmake --version && gcc --version && python --version

RUN git clone https://github.com/alembic/alembic.git /alembic && git clone https://github.com/AcademySoftwareFoundation/Imath.git /imath

WORKDIR /imath
RUN mkdir build && cd build && \
    cmake -G "MinGW Makefiles" -DCMAKE_INSTALL_PREFIX=/imath/install -DBUILD_SHARED_LIBS=ON .. && \
    cmake --build . && \
    cmake --install .
RUN setx /M Imath_DIR "C:\\imath\\install\\lib\\cmake\\Imath"

WORKDIR /alembic
RUN mkdir build && cd build && \
    cmake -G "MinGW Makefiles" -DCMAKE_INSTALL_PREFIX=/alembic/install -DBUILD_SHARED_LIBS=ON \
    -DImath_DIR=C:/imath/install/lib/cmake/Imath .. && \
    cmake --build . && \
    cmake --install .
RUN setx /M Alembic_DIR "C:\\alembic\\install\\lib\\cmake\\Alembic"

COPY . /flop
WORKDIR /flop

CMD ["powershell", "-NoProfile", "-Command", \
    "$d = @((gci C:/alembic/install/bin/*.dll, C:/imath/install/bin/*.dll -EA 0).FullName); \
    $r = 'C:/ProgramData/mingw64/mingw64/bin'; \
    $env:PATH = \"$r;$env:PATH\"; \
    foreach ($n in 'libwinpthread-1.dll','libgcc_s_seh-1.dll','libstdc++-6.dll','libgomp-1.dll') \
        { $p = \"$r/$n\"; if (Test-Path $p) { $d += $p } }; \
    python build.py -package-dependencies $d; \
    exit $LASTEXITCODE"]
