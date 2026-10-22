# nixos-config
My NixOS configurations

## omp settings

`home-manager/programs/omp.nix` declares the saved omp preferences and installs
omp for the NixOS user. Home Manager restores `~/.omp/agent/config.yml` on every
activation, including a rebuild or a fresh installation using this flake:

```sh
sudo nixos-rebuild switch --flake .#ehpc-desktop
```

The config remains a writable regular file so omp's settings UI and
`omp config set` still work. Rebuilds overwrite interactive changes with the
declared values; edit `settings` in the module to make changes permanent.
Unspecified settings retain omp's defaults. Credentials, sessions, and caches
are not included; log in again after reinstalling.

Keep the module tracked in Git with the rest of this configuration so it is
included when rebuilding or cloning the flake for a reinstall.

## wherdr phone access

`home-manager/programs/wherdr.nix` starts the headless Herdr server and the
wherdr web client, which listens on `127.0.0.1:7683`. wherdr pulls in
`herdr.service` and starts after its startup
job completes. The Herdr service uses the existing default session and user
profile PATH so saved supported agent conversations can resume.
User lingering in `modules/users.nix` starts user services at boot and keeps them
running after logout. `modules/tailscale.nix` starts `wherdr-serve.service`,
which publishes private HTTPS on port 7683 through Tailscale Serve. Systemd
owns the foreground Serve process and restarts it with tailscaled.
No public Funnel route or additional firewall port is enabled.

Apply the configuration:

```sh
sudo nixos-rebuild switch --flake .#ehpc-desktop
```

The package is pinned to wherdr 1.3.4 in `packages/wherdr/flake.nix`; upgrades
are applied through the rebuild above, not wherdr's in-app updater.
Passkeys and settings remain in `~/.local/share/wherdr`.

Tailscale must already be signed in on this computer, with MagicDNS and HTTPS
certificates enabled for the tailnet. On a fresh installation, run
`sudo tailscale up` and sign in first; credentials are not stored in this repo.
Connect the phone to the same tailnet, then run `wherdr phone` for the HTTPS
address and QR code. Enable the passkey lock on that HTTPS address, not localhost.

Check startup with `systemctl status wherdr-serve` and
`systemctl --user status herdr wherdr`. Both Herdr and the web client start
at boot, without a desktop login. Herdr restores saved layouts and supported
agent session references; arbitrary running shell commands do not survive reboot.
If a manually started Herdr server already exists, the service skips startup
without interrupting it; the boot-managed server takes over on the next boot.

## Display power saving

`home-manager/settings/dconf.nix` sets GNOME's idle timeout to 15 minutes.
GNOME uses monitor power saving (DPMS) after inactivity; the PC does not
automatically suspend on AC power, keeping wherdr and agents available.
Applications that inhibit GNOME idle handling can delay display power saving.
A monitor's standby LED may remain lit even when DPMS is off; this is not a
full mains-power shutdown.

## Rebuild authentication from a phone

`modules/security.nix` gives this exact invocation a 24-hour sudo inactivity
timeout shared across terminals:

```sh
sudo /run/current-system/sw/bin/nixos-rebuild switch --flake 'path:/home/ehpc/nixos-config#ehpc-desktop'
```

Apply the policy with that command using the existing password prompt. The
first matching invocation after activation may require authentication again
to establish the shared cache. Each successful use refreshes its 24-hour
timeout; rebooting or running `sudo -K` clears the cache.

Other sudo commands retain their existing 30-minute, per-terminal timeout.
Different rebuild arguments, including relative flake paths, do not receive
the longer timeout. No permanent `NOPASSWD` permission is granted.

This remains root-equivalent access: anyone able to edit this configuration
and use the authenticated rebuild can install arbitrary root activation code.
Keep wherdr protected by its passkey lock and restrict tailnet access.

## Wi-Fi stability workaround

`modules/network.nix` declares `wifi-stability.service` for `ehpc-desktop`.
At boot and when restarted, it pins the existing NetworkManager profile
`TS-m8HB` (`6ba4853b-ef52-4935-8fe8-002c1e5068b2`) to its 2.4 GHz radio
(`60:CE:41:02:69:14`), avoiding roaming onto the failing 5 GHz connection.
It also restarts with NetworkManager. The command updates the saved profile
without reconnecting the active connection or changing power-saving settings.
Wi-Fi credentials remain in NetworkManager, never in the Nix store.

The profile must already exist with that UUID; this service does not provision
Wi-Fi credentials on a fresh installation. After applying the configuration,
check `systemctl status wifi-stability`.

To remove the pin, first remove or change the service in `modules/network.nix`
and rebuild, then clear both properties and reconnect. This permits 5 GHz
roaming again and may reintroduce the failures:

```sh
nmcli connection modify uuid 6ba4853b-ef52-4935-8fe8-002c1e5068b2 \
  802-11-wireless.band "" 802-11-wireless.bssid ""
nmcli connection up uuid 6ba4853b-ef52-4935-8fe8-002c1e5068b2
```
