# win-provision
### Windows Provision Scripts - Windows 7,10 &amp; Server 2012 R2, 2016
 ##  To run locally:
**Open with your favorite editor and make sure to add or comment out the packages you do or do not want. See Developer section(s) below if needed.**
1. Run this boxstarter script by calling the following from an **elevated** command-prompt:
   #### Start > Run > cmd
   ```powershell
   start http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/rickrussell/win-provision/master/provision.ps1
   ```
2.
 2) Open Powershell as Administrator
 ```powershell
& \\path\to\files\provision\windows\provision.ps1
```
 ## For Windows PowerShell
1. Provision machine with this script, skip to step 3, or Get GitHub for Windows: [GitHub for Windows](https://desktop.github.com/)
2. Clone Repo: [win-provision](https://github.com/rickrussell/win-provision.git)
3. Create Branch (using poshgit in powershell)
   ```
   E:\projects\win-provision [master ≡]> git checkout -b add-feature-01-rrr -t origin/master
   Switched to a new branch 'add-feature-01-rrr'
   Branch 'add-feature-01-rrr' set up to track remote branch 'master' from 'origin'.
   E:\projects\win-provision [add-feature-01-rrr ≡ +0 ~1 -0 !]>
   ```
4. Open with your favorite editor: [Atom.io](https://atom.io)
5. Save, Commit, Pull Request!
 # TODO:
1. Add Workstation Preset
2. Expand Windows Developers section
  1. Go into detail about provision.ps1 and customization.ps1 scripts

