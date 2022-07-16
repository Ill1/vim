# Vim Configuration

## vimrc
Stores .viminfo, backup, swap, undo files into `var/` folder.  
`var/` will be created in same the location as `vimrc` if it doesn't exist.  
CtrlP is configured to use `git` and cmd.exe's `dir` command as a fallback for
getting filenames.  
Uses Vim's pack feature to load plugins which are referenced as git submodules.

### Usage
To use, symlink the vim folder to the relevant $home folder:  
- bash
```
ln -d -s vim ~/.vim
```
- cmd.exe [elevated]
```
mklink /D %HOME%\vimfiles vim
```
- pwsh.exe [elevated]
```
New-Item -Path $HOME/vimfiles -ItemType SymbolicLink -Value vim
```

### Initializing plugin-submodules
Initialize the plugin-submodules
```
git submodule update --init
```

### Adding new Vim plugins
To add, for example, the easymotion plugin
```
cd ./vim/pack/default/start
git submodule add -b master https://github.com/easymotion/vim-easymotion.git
```

### Updating all Vim plugins
```
git submodule foreach 'git fetch && git pull'
```

### Adding help tags
```
:helptags ALL
```

