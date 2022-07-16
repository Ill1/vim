# Dotfiles
```
git clone https://github.com/Ill1/dotfiles.git
```

## Vim
### vimrc
Vimrc will store vim-generated files for the backup, swap, .viminfo and undo files in
`~/var/vim` and create `~/var/vim` if it doesn't exist.
CtrlP is configured to use cmd.exe's dir command for getting filenames.

To use, symlink the vim folder to the relevant $home folder:
- bash
```
ln -d -s dotfiles/vim ~/.vim
```
- cmd.exe [elevated]
```
mklink /D vimfiles .\repos\dotfiles\vim
```
- pwsh.exe [elevated]
```
New-Item -Path vimfiles -ItemType SymbolicLink -Value .\repos\dotfiles\vim
```

### Initializing plugin-submodules
Initialize the plugin-submodules
```
git submodule update --init dotfiles
```

### Adding new Vim plugins
To add, for example the easymotion plugin
```
pushd ./vim/pack/default/start
git submodule add -b master https://github.com/easymotion/vim-easymotion.git
popd
```

### Updating all Vim plugins
For bash or powershell
```
git submodule foreach 'git fetch && git pull'
```

### Adding help tags
```
:helptags ALL
```

