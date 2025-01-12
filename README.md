# Data on WSL(Windows Subsystem for Linux)

# Install Debian on WSL
Open Settings > Apps > Programs and Features > Turn Windows features on or off dialog and select the *Windows Subsystem for Linux* to enable WSL on your system. You may reboot your system.

![enable-wsl](images/enable-wsl.png)

After you have enabled WSL, you can install linux distribution via Microsoft Store. We will use the latest version of Debian linux for the hands-on lab. Open Microsoft Store app and search *Debian*, and install.

To verify your install, open windows terminal or command terminal and run `wsl -l -v` command to list WSL distributions.

# Labs
- [Jupyter](examples/jupyter/README.md)
- [Spark](examples/spark/README.md)
