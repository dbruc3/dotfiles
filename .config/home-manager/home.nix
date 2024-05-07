{ config, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/background" = {
      show-desktop-icons = false;
    };
    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };
    "org/gnome/desktop/interface" = {
      clock-format = "24h";
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      enable-animations = false;
      show-battery-percentage = true;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = true;
    };
    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
    };
    "org/gnome/desktop/privacy" = {
      hide-identity = true;
      report-technical-problems = false;
      send-software-usage-stats = false;
    };
    "org.gnome.settings-daemon.plugins.power" = {
      lid-close-ac-action = "nothing";
      lid-close-battery-action = "nothing";
      sleep-inactive-ac-type = "logout";
      sleep-inactive-ac-timeout = 900;
      sleep-inactive-battery-type = "shutdown";
    };
    "org/gnome/shell/extensions/ding" = {
      show-home = false;
    };
  };

  home.username = "dan";
  home.homeDirectory = "/home/dan";

  home.packages = [
    pkgs.protonvpn-gui
    pkgs.telegram-desktop
    # # It is sometimes useful to fine-tune packages, for example:
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "vim";
    SUDO_EDITOR = "vim";
  };

  programs.bash.enable = true;
  programs.bash.shellAliases = {
    hms = "nix-channel --update && nix-shell -p home-manager --run 'home-manager switch'";
    hm = "vim ~/.config/home-manager/home.nix && hms";
    dit = "git --git-dir=$HOME/.cfg --work-tree=$HOME";
    la = "ls -a";
    mv = "mv -i";
    cp = "cp -i";
    gs = "git status";
    gd = "git diff";
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
  };

  # TODO: set browser search engines and extensions
  programs.chromium.enable = true;
  programs.firefox.enable = true;
  programs.git = {
    enable = true;
    userName = "dbruc3";
    userEmail = "dbruce14@gmail.com";
    aliases = {
      co = "checkout";
    };
  };
  programs.home-manager.enable = true;
  programs.password-store.enable = true;
  programs.tmux.enable = true;
  programs.vim.enable = true;

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11";
}
