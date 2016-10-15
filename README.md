## glabrego dotfiles
Use it well :)

## What's included?

- `.vimrc`;
- `.tmux.conf`;
- `.zshrc`;
- `.bash_profile_mac` (old, i don't use it anymore, but why not keep it?)

Copy all of these files to your user directory and follow the instructions bellow.

## VIM Setup instructions

My `.vimrc` includes a little explanation of what each plugin can do, so you can read the descriptions and decide wich plugin is necessary for you :)

I use Plug to manage my vim plugins, so...

#### Install plug.vim

[Download plug.vim](https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)
and put it in the "autoload" directory.

###### Unix

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

###### Neovim

```sh
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

###### Windows (PowerShell)

```powershell
md ~\vimfiles\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile($uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\vimfiles\autoload\plug.vim"))
```

Now, you just need to enter vim, run `:PlugInstall` and you're good to go!
