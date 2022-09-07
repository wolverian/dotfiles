{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "antti";
  home.homeDirectory = "/home/antti";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    bat
    ripgrep
    ranger
    sd
    fd
    git
    jq
    wget
    file
    links2

    # bash is needed in some scripts
    bash

    # LSP servers
    sumneko-lua-language-server
    nodePackages.typescript-language-server
    nodePackages.purescript-language-server

    (import ./jdt-language-server.nix pkgs)
  ];

  home.shellAliases = {
    g = "git";
    t = "tmux";
    gd = "git branch | fzf | xargs git b -d";
    la = "ls -la";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    zsh = {
      enable = true;
      enableSyntaxHighlighting = false;
      # does not seem to work
      sessionVariables = {
        EDITOR = "nvim";
      };
      initExtra = ''
        export EDITOR=nvim
        bindkey -e

        setopt nosharehistory

        e () {
          nvim -c "'\"" "$@"
        }
      '';
    };

    tmux = {
      enable = true;
      extraConfig = lib.strings.fileContents ./tmux.conf;
      tmuxp.enable = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    
    git = {
      enable = true;
      aliases = {
        s = "status --short";
        b = "branch";
        c = "commit -v";
        co = "checkout";
        a = "add";
        au = "add -u";
        d = "diff";
        dc = "diff --cached";
        l = "log --graph --abbrev-commit --date=relative";
        r = "!git l -20";
      };
      extraConfig = {
        user = { name = "Antti Holvikari"; email = "antti@anttih.com"; };
        branch = { autosetuprebase = "always"; };
        format = { pretty = "format:%C(yellow)%h%Creset -%C(red)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"; };
        core = { pager = "less"; };
        pull = { rebase = "true"; };
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;

      # for CTRL-T widget
      fileWidgetCommand = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";
      fileWidgetOptions = ["--preview 'bat -p -f {}'"];

      tmux.enableShellIntegration = true;
      tmux.shellIntegrationOptions = [ "-p80%,80%" ];
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$shlvl"
          "$kubernetes"
          "$directory"
          "$git_branch"
          "$git_commit"
          "$git_state"
          "$git_status"
          "$docker_context"
          "$package"
          "$cmake"
          "$nix_shell"
          "$memory_usage"
          "$env_var"
          "$custom"
          "$cmd_duration"
          "$line_break"
          "$jobs"
          "$battery"
          "$time"
          "$status"
          "$character"
        ];
        # git_status.disabled = true;
        # git_commit.disabled = true;
        # git_branch.disabled = true;
        directory = {
          truncation_length = 8;
          truncate_to_repo = true;
        };
      };
    };

    neovim = import ./neovim.nix { inherit pkgs lib; };
  };
}
