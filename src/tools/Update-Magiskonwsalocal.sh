ScriptLocal=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
if [[ $EUID -eq 0 ]]; then
     echo $"$red You need to be not Super User/Root. $white"
   exit 1
fi
if ! [ -x "$(command -v git)" ]; then
echo $"$green I found a missing package, I'm installing it... (git) $white"
if [ -x "$(command -v apt)" ]; then
sudo apt install -y git
elif [ -x "$(command -v zypper)" ]; then
sudo zypper in -y -l git
fi
fi
cd $ScriptLocal
cd ..
if [ -d MagiskOnWSALocal ]; then
rm -rf MagiskOnWSALocal
fi
git clone https://github.com/LSPosed/MagiskOnWSALocal.git

cd MagiskOnWSALocal
rm -rf .git

