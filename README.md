## My .dotfiles

My custom VIM Cheat Sheet available [here](https://docs.google.com/spreadsheets/d/1YkAicQOxZIIaJMARulF5cq6plb6v0CW_WVXrDfqr3D8/edit#gid=464928758)

### Table of Contents:
- [Requirements](#requirements)
- [Install](#install)
- [Update](#update)
- [Aliases And Custom Commands](#aliases-and-custom-commands)
  - [Bash](#bash)
  - [Homebrew](homebrew)
  - [Git](git)
  - [Bundler](bundler)
  - [Rails](rails)
  - [NodeJS](nodejs)
- [Troubleshooting](#troubleshooting)

### Requirements
- MacOS with Ruby 2.0+

### Install
- Clone onto your laptop:
```bash
$ git clone https://github.com/evertonfragoso/.dotfiles.git
```

- Run setup file from the root folder:
```bash
$ cd .dotfiles
$ ./setup
```

### Update
Run the update file from the root folder:
```bash
$ cd .dotfiles
$ ./update
```

### Aliases And Custom Commands
#### Bash
- `v`, `vi`, `vim`: default editor<sup name="a-editor">[1](#f-editor)</sup>
- `fuck`: corrects errors in previous console command
- `mcd`: create a folder and navigates into it
- `l`: colorized list in long format
- `la`: same as `l` but includes dot files

#### Homebrew
- `cleanup`: updates Homebrew, upgrade all installed formulas, runs `brew
    cleanup` and clears the cache folder

#### Git
- `g`: `git`
- `ga`: `git add`
- `gs`: `git status`
- `gco`: `git checkout`
- `pull`: `git pull`
- `push`: `git push`
- `commit`: `git commit -m`
- `clone`: `git clone` - can be used as `user/repo-name` if it's a github
    repository

#### Bundler
- `b`: `bundle`
- `be`: `bundle exec`
- `bi`: `bundle install`
- `bu`: `bundle update`

#### Rails
- `br`: `bundle exec rails`
- `brake`: `bundle exec rake`
- `mig`: `bundle rake db:migrate`
- `spec`: `bundle exec rspec`

#### NodeJS
- `n`: `node`
- `np`: `pnpm`<sup name="a-npm">[2](#f-npm)</sup>

<b name="f-editor">1</b>: Default editor is set to `nvim` [↩](#a-editor)
<b name="f-npm">2</b>: Defaults to `pnpm` package manager [↩](#a-npm)

### Troubleshooting
* In case `setup` and/or `update` returns an error when called, check it's permissions because it must be executable. If it's not executable, run the following command:

    ```bash
    $ chmod +x setup update
    ```

    and try to run the `setup` again.

* Inside `vim`, if you get a `deoplete` error asking to run `:UpdateRemotePlugins`, you likely have updated the `UtilSnips` plugin and it requires a newer version of `python3`. Just run the `update` script in terminal and then `:UpdateRemotePlugins` on `vim`
