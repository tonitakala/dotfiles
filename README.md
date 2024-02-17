# dotfiles

## Setup

Clone this repository to `$HOME/dotfiles`

Add symlinks to necessary files/folders:

`.bashrc`

```
cd $HOME
mv .bashrc .bashrc.backup
ln -s $HOME/dotfiles/.bashrc .bashrc
```

`.tmux.conf`

```
cd $HOME
mv .tmux.conf .tmux.conf.backup
ln -s $HOME/dotfiles/.tmux.conf .tmux.conf
```

`.prettierrc`

```
cd $HOME
mv .prettierrc .prettierrc.backup
ln -s $HOME/dotfiles/.prettierrc .prettierrc
```

`.config/nvim`

```
cd $HOME
mkdir -p .config
cd .config
mv nvim nvim_backup
ln -s $HOME/dotfiles/.config/nvim nvim
```
