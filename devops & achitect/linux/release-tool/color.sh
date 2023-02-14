#!/bin/sh
#
# This script should be run via curl:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# or via wget:
#   sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# or via fetch:
#   sh -c "$(fetch -o - https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#
# As an alternative, you can first download the install script and run it afterwards:
#   wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
#   sh install.sh
#
# You can tweak the install behavior by setting variables when running the script. For
# example, to change the path to the Oh My Zsh repository:
#   ZSH=~/.zsh sh install.sh
#
# Respects the following environment variables:
#   ZSH     - path to the Oh My Zsh repository folder (default: $HOME/.oh-my-zsh)
#   REPO    - name of the GitHub repo to install from (default: ohmyzsh/ohmyzsh)
#   REMOTE  - full remote URL of the git repo to install (default: GitHub via HTTPS)
#   BRANCH  - branch to check out immediately after install (default: master)
#
# Other options:
#   CHSH       - 'no' means the installer will not change the default shell (default: yes)
#   RUNZSH     - 'no' means the installer will not run zsh after the install (default: yes)
#   KEEP_ZSHRC - 'yes' means the installer will not replace an existing .zshrc (default: no)
#
# You can also pass some arguments to the install script to set some these options:
#   --skip-chsh: has the same behavior as setting CHSH to 'no'
#   --unattended: sets both CHSH and RUNZSH to 'no'
#   --keep-zshrc: sets KEEP_ZSHRC to 'yes'
# For example:
#   sh install.sh --unattended
# or:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
#
set -e


# The [ -t 1 ] check only works when the function is not called from
# a subshell (like in `$(...)` or `(...)`, so this hack redefines the
# function at the top level to always return false when stdout is not
# a tty.

# This function uses the logic from supports-hyperlinks[1][2], which is
# made by Kat Marchán (@zkat) and licensed under the Apache License 2.0.
# [1] https://github.com/zkat/supports-hyperlinks
# [2] https://crates.io/crates/supports-hyperlinks
#
# Copyright (c) 2021 Kat Marchán
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# Adapted from code and information by Anton Kochkov (@XVilka)
# Source: https://gist.github.com/XVilka/8346728
supports_truecolor() {
  case "$COLORTERM" in
  truecolor|24bit) return 0 ;;
  esac

  case "$TERM" in
  iterm           |\
  tmux-truecolor  |\
  linux-truecolor |\
  xterm-truecolor |\
  screen-truecolor) return 0 ;;
  esac

  return 1
}

setup_color() {
  # Only use colors if connected to a terminal

  if supports_truecolor; then
    FMT_RAINBOW="
      $(printf '\033[38;2;255;0;0m')
      $(printf '\033[38;2;255;97;0m')
      $(printf '\033[38;2;247;255;0m')
      $(printf '\033[38;2;0;255;30m')
      $(printf '\033[38;2;77;0;255m')
      $(printf '\033[38;2;168;0;255m')
      $(printf '\033[38;2;245;0;172m')
    "
  else
    FMT_RAINBOW="
      $(printf '\033[38;5;196m')
      $(printf '\033[38;5;202m')
      $(printf '\033[38;5;226m')
      $(printf '\033[38;5;082m')
      $(printf '\033[38;5;021m')
      $(printf '\033[38;5;093m')
      $(printf '\033[38;5;163m')
    "
  fi

  FMT_RED=$(printf '\033[31m')
  FMT_GREEN=$(printf '\033[32m')
  FMT_YELLOW=$(printf '\033[33m')
  FMT_BLUE=$(printf '\033[34m')
  FMT_BOLD=$(printf '\033[1m')
  FMT_RESET=$(printf '\033[0m')
}

# shellcheck disable=SC2183  # printf string has more %s than arguments ($FMT_RAINBOW expands to multiple arguments)
print_success() {
  printf '%s      %s ___%s_____    %s _%s__%s  %s   ___         %s   \n'     $FMT_RAINBOW $FMT_RESET
  printf '%s      %s|__ %s   __|   %s| %s  |%s   |  %s |      %s\n'      $FMT_RAINBOW $FMT_RESET
  printf '%s      %s   /%s  /     %s | %s  |_%s__|  %s |     %s   \n'  $FMT_RAINBOW $FMT_RESET
  printf '%s      %s  /%s  /      %s | %s   %s___    %s|     %s\n'      $FMT_RAINBOW $FMT_RESET
  printf '%s  %s   \_/%s  /       %s | %s  | %s  |   %s|        %s \n'    $FMT_RAINBOW $FMT_RESET
  printf '%s   %s\__%s___/        %s |_%s__| %s  |___%s|        %s \n' $FMT_RAINBOW $FMT_RESET
    printf '\n'
  printf '\n'
}

main() {
#   # Run as unattended if stdin is not a tty
#   if [ ! -t 0 ]; then
#     RUNZSH=no
#     CHSH=no
#   fi

#   # Parse arguments
#   while [ $# -gt 0 ]; do
#     case $1 in
#       --unattended) RUNZSH=no; CHSH=no ;;
#       --skip-chsh) CHSH=no ;;
#       --keep-zshrc) KEEP_ZSHRC=yes ;;
#     esac
#     shift
#   done

   setup_color

#   if ! command_exists zsh; then
#     echo "${FMT_YELLOW}Zsh is not installed.${FMT_RESET} Please install zsh first."
#     exit 1
#   fi

#   if [ -d "$ZSH" ]; then
#     echo "${FMT_YELLOW}The \$ZSH folder already exists ($ZSH).${FMT_RESET}"
#     if [ "$custom_zsh" = yes ]; then
#       cat <<EOF

# You ran the installer with the \$ZSH setting or the \$ZSH variable is
# exported. You have 3 options:

# 1. Unset the ZSH variable when calling the installer:
#    $(fmt_code "ZSH= sh install.sh")
# 2. Install Oh My Zsh to a directory that doesn't exist yet:
#    $(fmt_code "ZSH=path/to/new/ohmyzsh/folder sh install.sh")
# 3. (Caution) If the folder doesn't contain important information,
#    you can just remove it with $(fmt_code "rm -r $ZSH")

# EOF
#     else
#       echo "You'll need to remove it if you want to reinstall."
#     fi
#     exit 1
#   fi

#   setup_ohmyzsh
#   setup_zshrc
#   setup_shell

  print_success

  # if [ $RUNZSH = no ]; then
  #   echo "${FMT_YELLOW}Run zsh to try it out.${FMT_RESET}"
  #   exit
  # fi

  # exec zsh -l
}

main "$@"
