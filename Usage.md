# Usage
Enter the Nix development shell. Make sure Nix is installed.:
```sh
sudo nix develop
```

Select a folder to edit:
```sh
cd folder
```

## Render
Render `main.tex` to a PDF file `main.pdf`:
```sh
render
```

## Watch Mode
Renders `main.tex` everytime it is changed:
```sh
watch
```
Pair with an auto-reloading PDF viewer to achieve "watch mode" (e.g., `Evince` on Linux).

## Clean Build Artifacts
Remove all build artifacts like `.aux`, `.log`, and `.pdf` files:
```sh
clean
```