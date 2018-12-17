#!/usr/bin/env bash

PWD=$(pwd)
# Make sure that if we happen to be running in cygwin the symlinks will get setup correctly.
# Make sure to enable develoepr more before installing
export CYGWIN="$CYGWIN winsymlinks:nativestrict"

if [[ -f "$PWD/dotVimRc" && ! -L "$PWD/dotVimRc" ]]; then
  if [[ -L "$HOME/.vim" && -d "$HOME/.vim_backup" ]]; then
    echo -e "Removing symlink ~/.vim"
    unlink ~/.vim
  elif [[ -d "$HOME/.vim" && -d "$HOME/.vim_backup" ]]; then
    echo -e "Backing up ~/.vim to ~/temp/vim_backup"
    mv ~/.vim ~/temp/vim_backup
  fi
  if [[ -d "$HOME/.vim_backup" && ! -d "$HOME/.vim" ]]; then
    echo -e "Moving ~/.vim_backup back to ~/.vim"
    mv ~/.vim_backup ~/.vim
  else
    echo "Not restoring $HOME/.vim - it has already been restored, or a backup does not exist"
  fi

  # This is where neovim likes its config to be stored.
  # Inside of our .vim directory, we already have a sym link from init.vim to
  # .vimrc, so all we have to do is setup the directory for neovim.
  if [[ -L "$HOME/.config/nvim" && -d "$HOME/.config/nvim_backup" ]]; then
    echo -e "Removing symlink ~/.config/nvim"
    unlink ~/.config/nvim
  elif [[ -d "$HOME/.config/nvim" && -d "$HOME/.config/nvim_backup" ]]; then
    echo -e "Backing up ~/.config/nvim to ~/temp/nvim_backup"
    mv ~/.config/nvim ~/temp/nvim_backup
  fi
  if [[ -d "$HOME/.config/nvim_backup" && ! -d "$HOME/.config/nvim" ]]; then
    echo -e "Moving ~/.config/nvim_backup back to ~/.config/nvim"
    mv ~/.config/nvim_backup ~/.config/nvim
  else
    echo "Not restoring $HOME/.config/nvim - it has already been restored, or a backup does not exist"
  fi

  # .vimrc is a file, use the -f flag
  if [[ -L "$HOME/.vimrc" && -f "$HOME/.dotfiles/vimrc" ]]; then
    echo -e "Removing symlink ~/.vimrc"
    unlink ~/.vimrc
  elif [[ -f "$HOME/.vimrc" && -f "$HOME/.vimrc_backup" ]]; then
    echo -e "Backing up ~/.vimrc to ~/temp/vimrc_backup"
    mv ~/.vimrc ~/temp/vimrc_backup
  fi
  if [[ -f "$HOME/.vimrc_backup" && ! -f "$HOME/.vimrc" ]]; then
    echo -e "Moving ~/.vimrc_backup back to ~/.vimrc"
    mv ~/.vimrc_backup ~/.vimrc
  elif [[ -f "$HOME/.dotfiles/vimrc" && ! -L "$HOME/.vimrc" ]]; then
    echo -e "Creating symlink ~/.vimrc from ~/.dotfiles/vimrc"
    ln -s ~/.dotfiles/vimrc ~/.vimrc
  else
    echo "Not restoring $HOME/.vimrc - it has already been restored, or a backup does not exist"
  fi

  # .gvimrc is a file, use the -f flag
  if [[ -L "$HOME/.gvimrc" && -f "$HOME/.dotfiles/gvimrc" ]]; then
    echo -e "Removing symlink ~/.gvimrc"
    unlink ~/.gvimrc
  elif [[ -f "$HOME/.gvimrc" && -f "$HOME/.gvimrc_backup" ]]; then
    echo -e "Backing up ~/.gvimrc to ~/temp/gvimrc_backup"
    mv ~/.gvimrc ~/temp/gvimrc_backup
  fi
  if [[ -f "$HOME/.gvimrc_backup" && ! -f "$HOME/.gvimrc" ]]; then
    echo -e "Moving ~/.gvimrc_backup back to ~/.gvimrc"
    mv ~/.gvimrc_backup ~/.gvimrc
  elif [[ -f "$HOME/.dotfiles/gvimrc" && ! -L "$HOME/.gvimrc" ]]; then
    echo -e "Creating symlink ~/.gvimrc from ~/.dotfiles/gvimrc"
    ln -s ~/.dotfiles/gvimrc ~/.gvimrc
  else
    echo "Not restoring $HOME/.gvimrc - it has already been restored, or a backup does not exist"
  fi

  if [[ -f "$HOME/.dotfiles/vimrc.bundles" && ! -L "$HOME/.vimrc.bundles" ]]; then
    echo -e "Creating symlink ~/.vimrc.bundles from ~/.dotfiles/vimrc.bundles"
    ln -s ~/.dotfiles/vimrc.bundles ~/.vimrc.bundles
  else
    echo -e "No vimrc.bundles or already linked"
  fi

  if [[ -f "$HOME/.dotfiles/vimrc_background" && ! -L "$HOME/.vimrc_background" ]]; then
    echo -e "Creating symlink ~/.vimrc_background from ~/.dotfiles/vimrc_background"
    ln -s ~/.dotfiles/vimrc_background ~/.vimrc_background
  else
    echo -e "No vimrc_background or already linked"
  fi

  # Leave the fonts
  #if [ -d "$HOME/Library/Fonts" ]; then
  #  FONT_SOURCE="$PWD/dotVim/Fonts/Iosevka/iosevka-regular.ttf"
  #  FONT_DEST="$HOME/Library/Fonts/iosevka-regular.ttf"
  #  if [[ ! -f "$FONT_DEST" ]]; then
  #    echo -e "Installing font $FONT_SOURCE into $FONT_DEST"
  #    cp "$FONT_SOURCE" "$FONT_DEST"
  #  else
  #    echo -e "The font $FONT_DEST was already installed"
  #  fi
  #  FONT_SOURCE="$PWD/dotVim/Fonts/Iosevka/iosevka-bold.ttf"
  #  FONT_DEST="$HOME/Library/Fonts/iosevka-bold.ttf"
  #  if [[ ! -f "$FONT_DEST" ]]; then
  #    echo -e "Installing font $FONT_SOURCE into $FONT_DEST"
  #    cp "$FONT_SOURCE" "$FONT_DEST"
  #  else
  #    echo -e "The font $FONT_DEST was already installed"
  #  fi
  #  FONT_SOURCE="$PWD/dotVim/Fonts/Iosevka/iosevka-italic.ttf"
  #  FONT_DEST="$HOME/Library/Fonts/iosevka-italic.ttf"
  #  if [[ ! -f "$FONT_DEST" ]]; then
  #    echo -e "Installing font $FONT_SOURCE into $FONT_DEST"
  #    cp "$FONT_SOURCE" "$FONT_DEST"
  #  else
  #    echo -e "The font $FONT_DEST was already installed"
  #  fi
  #fi
else
  echo -e "It seems you are not running the installer from within the VimBox root"
  exit 1
fi

