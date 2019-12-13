# Dotfiles

My dotfiles repo

## Fresh macOS setup

1. Update macOS to the latest version through the App Store
2. Install the full version of Xcode from the App Store then run `xcode-select --install`
3. Clone repo into `~/.dotfiles`
4. Run the installer script `./install.sh`
5. Restart Mac
6. Activate Alfred Snippets, Workflows and Powerpack
7. Install Adobe Creative Cloud
8. Setup Viscosity and office VPN
9. Migrate files from old machine
    1. Desktop
    2. Documents
    3. projects
    4. Fonts


### Notes

Put this in `.ssh/config`

```
Host *
  IPQoS=throughput
```
> Needed when at the Curity Office
