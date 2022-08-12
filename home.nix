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

    sumneko-lua-language-server
  ];

  home.shellAliases = {
    g = "git";
    t = "tmux";
    gd = "git branch | fzf | xargs git b -d";
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
    };

    neovim = {
      enable = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        vim-surround
        vim-commentary
        vim-repeat
        nvim-autopairs
        iceberg-vim

        (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))

        # these don't have treesitter grammars yet
        purescript-vim
        dhall-vim

        nvim-jdtls

        { plugin = nvim-lspconfig;
          type = "lua";
          config = lib.strings.fileContents ./neovim/lsp.lua;
        }
      ];
    };
  };

  programs.neovim.extraConfig = ''
    language en_US

    set encoding=utf-8
    set autoread
    set autowrite
    set expandtab
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
    set cmdheight=1
    set showtabline=1
    set hidden
    set hls
    set vb
    set showmatch
    set ignorecase
    set smartcase
    set nonumber
    set numberwidth=2
    set signcolumn=yes
    set nowrap
    set termguicolors
    set splitright
    set splitbelow
    set cursorline
    set grepprg=rg\ --line-number
    set completeopt=menuone,noselect
    set clipboard+=unnamedplus

    colorscheme iceberg
    syntax enable

    let mapleader = " "
    inoremap <c-c> <esc>
    nnoremap <leader><tab> <c-^>
    noremap <leader>s :w<cr>

    noremap <leader><leader> :noh<cr>
    noremap <C-k> <C-w>k
    noremap <C-j> <C-w>j
    noremap <C-l> <C-w>l
    noremap <C-h> <C-w>h

    " Select the first completion automatically to prevent hitting <C-n> twice
    " to get an autocompletion
    inoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<C-n><C-n>"
    
    " Silent grepping that automatically opens the quickfix window
    command! -nargs=+ Rg execute 'silent grep! <args>' | copen 10

    filetype plugin indent on

    lua << EOF
    ${lib.strings.fileContents ./neovim/config.lua}
    EOF
  '';
}
