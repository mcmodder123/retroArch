#!/bin/bash


if ping -c 1 8.8.8.8 > /dev/null 2>&1; then
  sudo echo '[extra]' >> /etc/pacman.conf
  sudo echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
  sudo pacman -Syu --noconfirm neovim vim git base-devel cool-retro-term cmatrix ascii asciiquarium neofetch links w3m sdl2

  echo 'Installing yay'
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si || { echo "Error: failed to install yay."; exit 1; }
  cd ..
  sudo rm -rf yay

  echo 'Setting up everything'

  yay -S nscde --noconfirm || { echo "Error: yay failed to install nscde."; exit 1; }
  yay -S bb --noconfirm || { echo "Error: yay failed to install bb."; exit 1; }
  yay -S tty-clock --noconfirm || { echo "Error: yay failed to install tty-clock."; exit 1; }

  mkdir -p ~/.cde/autostart

  echo '#!/bin/bash' > ~/.cde/autostart/cool-retro.sh
  echo 'cool-retro-term' >> ~/.cde/autostart/cool-retro.sh
  sudo chmod +x ~/.cde/autostart/cool-retro.sh

  echo '#!/bin/bash' > ~/.cde/autostart/start-cde.sh
  echo 'startcde' >> ~/.cde/autostart/start-cde.sh
  sudo chmod +x ~/.cde/autostart/start-cde.sh 
  
  echo 'Installing primegen'
  git clone https://github.com/mcmodder123/primegen || { echo "Error: git clone failed."; exit 1; }
  cd primegen
  g++ -o primegen optoalgo.cpp -O3 || { echo "Error: g++ failed."; exit 1; }
  sudo cp primegen /opt/retroarch/primegen
  
  echo 'Installing fib'
  cd ..
  git clone https://github.com/mcmodder123/fib || { echo "Error: git clone failed."; exit 1; }
  cd fib
  g++ -o fib fib.cpp -Ofast -march=native -lgmp -lgmpxx -mtune=native || { echo "Error: g++ failed."; exit 1; }
  sudo cp fib /opt/retroarch/fibonacci
  
  echo 'Installing sinewave'
  cd ..
  git clone https://github.com/mcmodder123/sinewave || { echo "Error: git clone failed."; exit 1; }
  cd sinewave
  g++ -o sinewave sinewave.cpp -Ofast -march=native -lsfml-graphics -lsfml-window -lsfml-system -mtune=native || { echo "Error: g++ failed."; exit 1; }
  sudo cp sinewave /opt/retroarch/sinewave
  

  echo 'Cleaning up'
  cd ..
  sudo rm -rf primegen
  sudo rm -rf fib
  sudo rm -rf sinewave

  echo 'Done!'
  echo 'Tools installed: git base-devel cool-retro-term cmatrix ascii asciiquarium neofetch links w3m sdl2 bb tty-clock nscde'
else
  echo "No internet connection. Try again in five minutes."
  exit 1
fi
exit 0
