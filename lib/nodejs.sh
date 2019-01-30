#!/bin/bash

function install_nodejs {
  sudo apt-get install -y software-properties-common
  curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
  apt-get -y update
  sudo apt-get install -y nodejs
}
