## My .dotfiles

Cheat Sheet available [here](https://docs.google.com/spreadsheets/d/1YkAicQOxZIIaJMARulF5cq6plb6v0CW_WVXrDfqr3D8/edit#gid=464928758)

### Requirements
None (_yet_)

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

#### Troubleshooting
In case `setup` and/or `update` returns an error when called, check it's permissions because it must be executable. If it's not executable, run the following command:

```bash
$ chmod +x setup update
```

and try to run it again:

```bash
$ ./setup
```
or
```bash
$ ./update
```

