# shell-tools
Useful tools for a sysadmin/devops daily's life.

###cdp
Use this tool to enter your project dir and enable a virtualenv with the same name.
#### How to use it?
1 - Open cdp and edit the variable project_dirs<br>
2 - Add cdp function to your shell<br>
```$ echo "source shell_tools_path/cdp" >> ~/.bashrc```<br>
3 - Run cdp

```
user@host[~]$ cdp myproject
(myproject)user@host[myproject]$ 
```
