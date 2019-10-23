## Clone Vim settings

### Linux
```bash
git clone http://github.com/gabng/vim-config.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
cd .vim
```

### Windows
```bat
git clone http://github.com/gabng/vim-config.git ~\vimfiles
mklink ~\_vimrc ~\vimfiles\vimrc
cd ~\vimfiles
```

## Init and update submodules
```
git submodule init
git submodule update --init --recursive
```

## Update all submodules
```bash
git submodule foreach git pull origin master
```

## To remove a submodule
1. Delete the relevant section from the .gitmodules file.
2. Delete the relevant section from .git/config.
3. Run git rm --cached path_to_submodule (no trailing slash).
4. Commit and delete the now untracked submodule files.

## Update Vim plugins (via Vundle)
```Vim
:PluginInstall
:PluginUpdate
```
