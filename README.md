#  How install own modules in powershell for all users

Usually i need to have my own functions in powershell that help me solve some basic things like:

*   Open a terminal with admin rights
*   Execute a script with admin rights
*  ...

You can put anything that you want and organize the files in any way. for this you should add or remove ps1 files inside modulos folder.

To install profile you should run installPowerShellProfile.ps1 with admin rights, you should be inside folder where you clone the project, and execute the instruction
```
.\installPowerShellProfile.ps1

```
After that you can reload your powershell session or close poweshell window and reopen it again.

If you want to know more about profile and modules you can consult the image bellow
![Tutorial about create profile in powershell](createYourOwnProfile.png)