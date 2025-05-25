{ pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> {};
in
{
  home.username = "namnguyen";
  home.homeDirectory = "/home/namnguyen";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  xsession.enable = true;
  xsession.initExtra = "xset r rate 300 60";

  home.packages = with pkgs; [
    unstable.neovim 
    unstable.awscli2
    aws-vault
    fzf
    fd
    ripgrep
    gcc
    ccls
    nixd
    bash-language-server
    wget
    udisks
    unzip
    gnumake
    scrot

    pass
  ];

  programs.gpg.enable = true;

  programs.git = {
    enable = true;
    userName = "Nam Nguyen";
    userEmail = "me@namnd.com";
    signing = {
      key = "54D86DA33E656F30";
      signByDefault = true;
    };
    aliases = {
      undo = "!git reset HEAD~1 --mixed";
      graph = "!f()  { git log --graph --abbrev-commit --decorate --all; }; f";
    };
    extraConfig = {
      color = {
        ui = true;
        diff = true;
        status = true;
        branch = true;
        interactive = true;
      };
      init.defaultBranch = "master";
      pull.rebase = true;
      rebase.autoStash = true;
      push.default = "current";
      format.pretty = "%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)";
      merge = {
        tool = "nvimdiff4";
        prompt = false;
      };
      mergetool.nvimdiff4.cmd = "nvim -d $LOCAL $BASE $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
    };
    ignores = [
      "Session.vim"
      ".direnv"
      "scratch*"
    ];
  };

  programs.bash = {
    enable = true;
    historyControl = ["ignoreboth"];
    initExtra = builtins.readFile ./bashrc;
    shellAliases = {
      vim = "nvim";
      ls = "ls --color=auto";
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      ".." = "cd ..";
      ".2" = "cd ../..";
      ".3" = "cd ../../..";
      ".4" = "cd ../../../..";
      ".5" = "cd ../../../../..";
      ga = "git add --patch";
      gb = "git branch";
      gs = "git status";
      gc = "git checkout";
      gp = "git pull";
      gP = "git push";
      gd = "git diff";
      gl = "git log";
      gg = "git graph";
    };

  };

  programs.direnv = {
    enable = lib.mkDefault true;
    config = {
      global = {
        warn_timeout = "10m";
      };
    };
    nix-direnv = {
      enable = true;
    };
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
