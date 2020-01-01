# Dotfiles

My dotfiles repo

## Fresh macOS setup

1. Update macOS to the latest version through the App Store
2. Install the full version of Xcode from the App Store then run `xcode-select --install`
3. Migrate needed ssh-keys, ssh config for multiple bitbucket users from old machine
4. Clone repo into `~/.dotfiles`
5. Run the installer script `./install.sh`
6. Restart Mac
7. Activate Alfred Snippets, Workflows and Powerpack
8. Install Adobe Creative Cloud
9. Setup Viscosity and office VPN
10. Copy VS Code settings, keybindings, check plugins
11. Migrate files from old machine
    1. Desktop
    2. Documents
    3. projects
    4. Fonts
12. Locate Lightroom catalogue + The Fader + Presets
13. Check `~/.gradle/gradle.properties` for Maven credentials

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

### Arq

Setup Backblaze B2

### VS Code

Todo: Sync settings

### Lightroom

Todo: Sync presets
