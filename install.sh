#!/bin/bash

mkdir -p ~/bin

cp blog.sh ~/bin/blog

sudo chmod +x ~/bin/blog

if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
    # Also add to current session
    export PATH="$HOME/bin:$PATH"
fi

source ~/.bashrc

echo "Setup complete! You can now use 'blog' command."