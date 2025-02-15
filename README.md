# dont-track-me.nix

`home-manager` module POC for a tracker blocker on the command line. Adds
various aliases and environment variables in order to block as much
command-line trackers as possible.

It was made in-reply-to Domen Kožar, maintainer of `devenv`, [removing the DO_NOT_TRACK variable from nixpkgs' devenv package](https://github.com/NixOS/nixpkgs/pull/381981).

> [!warn] Proof-of-concept software, don't expect anything from this yet
> Currently, it implements the everything listed on [Console DNT](https://consoledonottrack.com/),
> except for `gcloud config set disable_usage_reporting true` because for some
> reason `home-manager` doesn't have a unified way to hook your shell profile.
> (there is `programs.{bash,zsh}.{login,profile,init}Extra` but that doesn't
> cover every shell and you need to pass it seperately)

The idea is to crowd-source the various variables and configurations that can
be set in order to block trackers in one place. It should make it easier to
manage these privacy controls, because one can just specify `enableAll` and
everything that this module knows about will get blocked.

It is a very simple system, so contributing can be as easy as creating
a `trackers/*.nix`, writing 2 lines of nix, and adding it to the flake.

## Usage
Just add the following input to your `flake.nix`:
```nix
inputs.dont-track-me.url = "github:dtomvan/dont-track-me";
```

And in your `home.nix`, add:
```nix
dont-track-me = {
  enable = true;
  # enableAll = true; # enable everything under `trackers`
  trackers = { # enable specific tracker blockers. By default, everything but `DO_NOT_TRACK=1` is disabled.
    # awssam.enable = true;
    # azure.enable = true;
    # brew.enable = true;
    # dotnet.enable = true;
    # gatsby.enable = true;
    # netlify.enable = true;
    # syncthing.enable = true;
  };
};
```
