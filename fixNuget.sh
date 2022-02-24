# Go to repository
while true; do
    read -p "Are you in your rome2rio-core directory that is experiencing the issues? And do you have C: setup as /c/ instead of /mnt/c? And do you have VS 2022 installed? " yn
    case $yn in
        [Yy]* ) echo "Deleting system 32 :)"; break;;
        [Nn]* ) echo "You need to do those two things before running this script" ; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

# # Clean the project a couple of times
echo "msbuild rome2rio.tests/rome2rio.tests.csproj -target:Clean" | cmd.exe /k "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat"
echo "msbuild rome2rio.tests/rome2rio.tests.csproj -target:Clean" | cmd.exe /k "C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\VsDevCmd.bat"

# # Clear out the visual studio & nuget caches
rm -rf ".vs"
rm -rf "/c/Users/${USER}/.nuget"
find . -name bin -not -path "*/node_modules/*" -exec rm -r {} \; && find . -name obj -not -path "*/node_modules/*" -exec rm -r {} \;

