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
9. Migrate needed ssh-keys, ssh config for multiple bitbucket users
10. Copy VS Code settings, keybindings, check plugins
11. Migrate files from old machine
    1. Desktop
    2. Documents
    3. projects
    4. Fonts


### SSH Config

`.ssh/config`

```
# Host *
#  AddKeysToAgent yes
#  UseKeychain yes
#  IdentityFile ~/.ssh/id_rsa

# Needed at Curity HQ
Host *
IPQoS=throughput

#Using multiple Bitbucket accounts
#urre Bitbucket
Host bitbucket.org-urre
  HostName bitbucket.org
  User git
  IdentityFile ~/.ssh/urre-bitbucket
  IdentitiesOnly yes

#urbansanden Bitbucket
Host bitbucket.org-urbansanden
  HostName bitbucket.org
  User git
  IdentityFile ~/.ssh/urbansanden-bitbucket
  IdentitiesOnly yes
```
