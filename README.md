# dotFiles
These are the DotFiles for my PowerArrow AwesomeWM configuration.

To Install:

copy the contents of awesomeWM to ~.config/awesome/
It should look something like:

cp -avr ~/Downloads/dotFiles/awesomeWM/* ~/.config/awesome/
or using the move command (this will move the stuff, not copy it):
mv ~/Downloads/dotFiles/awesomeWM/* ~/.config/awesome/

copy the contents of .ncmpcpp to ~/.ncmpcpp (same commands as above)

copy the contents of weechat to ~/.weechat/

If you want the URXVT config, copy Xresources and move it to your home directory (~/)
though, i would recommend looking through and comparing your .Xresources to mine, and simply copying using regular copy-paste commands to avoid potential  conflicts.

do the same with .vimrc and .zshrc 


BEFORE copying .vimrc make sure you have "vundle" installed. After that, go into vim and do a ":PluginInstall" to install all the plugins/
I use vim-airline for the statusline theme.

If you have any issues, comment on the reddit thread or put an issue through the git repo issue function.

Thanks!
