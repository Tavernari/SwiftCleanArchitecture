#! /bin/bash
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew install mint
mint install MakeAWishFoundation/SwiftyMocky
swiftymocky generate