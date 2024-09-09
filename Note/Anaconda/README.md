##0. To uninstall your Anaconda installation
1. Open your terminal application.
2. (Optional) Remove any conda initialization scripts from all your terminal shell profiles by running the following command:
```
conda activate
conda init --reverse --all
```
3. Remove your entire `anaconda3` directory with `rm -rf`. Depending on your installation, this directory will be in your root folder or in your opt folder.
```
rm -rf ~/anaconda3
```
4. Close and reopen your terminal to refresh it. You should no longer see (base) in your terminal prompt.

##1-i. Installing on Linux
###1. Prerequisites
The `anaconda-navigator` package is installed by default with Anaconda Distribution and includes the dependency package `qt`. All of the dependencies for `qt` should also be installed by default, but installing the following extended dependencies might be required for certain versions of Anaconda Distribution in order to use GUI (Graphical User Interface) packages with Linux(Debian):
```
pt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
```

###2. Installation
1. To download the installer, open a terminal and use the following command, depending on your Linux architecture:
```
cd <dir_download>
curl -O https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh
```
2. To install, run the following command, depending on your Linux architecture:
```
bash <dir_download>/Anaconda3-2021.11-Linux-x86_64.sh
```
3. Press Enter to review the license agreement. Then press and hold Enter to scroll.
4. Enter `yes` to agree to the license agreement.
5. Anaconda recommends you enter “yes” to initialize Anaconda Distribution by running `conda init`.
If you enter “no”, then conda will not modify your shell scripts at all. In order to initialize conda after the installation process is done, run the following commands:
```
source <PATH_TO_CONDA>/bin/activate
conda init
```
6. Close and re-open your terminal window for the installation to take effect, or enter the command source `~/.bashrc` to refresh the terminal.
7. You can also control whether or not your shell has the base environment activated each time it opens.
```
# The base environment is activated by default
conda config --set auto_activate_base True

# The base environment is not activated by default
conda config --set auto_activate_base False

```
