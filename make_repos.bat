set PACKAGE_PATH=d:\Packages
set CORE_PATH=c:\src\rome2rio-core


set REPO_PATH=c:\src\rome2rio-core-3
git clone https://github.com/rome2rio/rome2rio-core.git %REPO_PATH%
%REPO_PATH%\link-existing-packages.cmd %CORE_PATH% %REPO_PATH%

set REPO_PATH=c:\src\rome2rio-core-lint
git clone https://github.com/rome2rio/rome2rio-core.git %REPO_PATH%
%REPO_PATH%\link-existing-packages.cmd %CORE_PATH% %REPO_PATH%

