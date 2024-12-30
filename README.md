# Useful commands


Move an existing dotfile into this repo and replace with symlinks
```
mkdir -p foo/dot-config
touch foo/dot-foorc
stow -t ~ --dotfiles --adopt -v foo
```

Delete and restow. Useful when upstream files were deleted

```
stow -R -t ~ --dotfiles -vt foo
stow -R -t ~ --dotfiles -v foo
```
