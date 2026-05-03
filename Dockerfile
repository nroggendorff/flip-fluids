FROM mcr.microsoft.com/windows/servercore:ltsc2022-amd64

RUN powershell -Command \
    Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

RUN choco install -y mingw cmake.portable git
RUN setx /M PATH "%PATH%;C:\\ProgramData\\mingw64\\mingw64\\bin"

RUN cmake --version && gcc --version

RUN git clone https://github.com/rlguy/Blender-FLIP-Fluids.git /flop
RUN git clone https://github.com/alembic/alembic.git /alembic && git clone https://github.com/AcademySoftwareFoundation/Imath.git /imath

WORKDIR /imath
RUN mkdir build && cd build && \
    cmake -G "MinGW Makefiles" -DCMAKE_INSTALL_PREFIX=/imath/install .. && \
    cmake --build . && \
    cmake --install .
RUN setx /M Imath_DIR "C:\\imath\\install"

WORKDIR /alembic
RUN mkdir build && cd build && \
    cmake -G "MinGW Makefiles" -DCMAKE_INSTALL_PREFIX=/alembic/install .. && \
    cmake --build . && \
    cmake --install .
RUN setx /M Alembic_DIR "C:\\alembic\\install"

WORKDIR /flop/build

RUN cmake -G "MinGW Makefiles" ..

CMD ["cmake", "--build", "."]
