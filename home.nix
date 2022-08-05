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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ripgrep
    tmux
    ranger
    sd
    fd
    git
    universal-ctags
    nodePackages.typescript-language-server
  ];

  # does not seem to work
  programs.zsh.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.zsh.initExtra = ''
    export EDITOR=nvim
    bindkey -e

    e () {
      nvim -c "'\"" "$@"
    }
  '';

  home.shellAliases = {
    g = "git";
    t = "tmux";
    gd = "git branch | fzf | xargs git b -d";
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g prefix C-a

      set -g mouse on
      set -g focus-events on

      bind C-p previous-window
      bind C-n next-window

      set-window-option -g mode-keys vi
      set-option -g status-keys emacs

      setw -g window-status-separator "  "
      set-window-option -g status-style bg=black
      set-window-option -g window-status-style fg=brightblack
      set-window-option -g window-status-current-style fg=brightwhite,bold

      # Do not show window number
      set-window-option -g window-status-current-format "#W#F"
      set-window-option -g window-status-format "#W#F"

      set -g status-right ""

      set -g status-left-length 32

      # set -g default-terminal "screen-256color"
      # set -ga terminal-overrides ",xterm-256color:Tc"

      set -sg escape-time 0

      unbind -T copy-mode-vi MouseDragEnd1Pane

      set-option -g history-limit 10000

      # disable the preview window
      bind-key s choose-tree -ZsN
      bind-key w choose-tree -ZwN
      bind-key k switch-client -l
      bind-key -r o select-pane -t :.+
    '';
  };


  programs.zsh.enable = true;
  programs.zsh.enableSyntaxHighlighting = false;

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;

  programs.git.enable = true;
  programs.git.aliases = {
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

  programs.git.extraConfig = {
    user = { name = "Antti Holvikari"; email = "antti@anttih.com"; };
    branch = { autosetuprebase = "always"; };
    format = { pretty = "format:%C(yellow)%h%Creset -%C(red)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"; };
    core = { pager = "less"; };
    pull = { rebase = "true"; };
  };

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;

  programs.neovim = {
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

      { plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local on_attach = function (client, bufnr)
            vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, { noremap=true, silent=true, buffer=bufnr })
          end

          require('lspconfig').tsserver.setup {
            on_attach = on_attach
          }

          require('lspconfig').hls.setup {
            on_attach = on_attach
          }
        '';
      }
    ];

    extraConfig = ''
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

      hi SignColumn guibg=none
      hi DiagnosticSignError guibg=none
      hi DiagnosticSignWarn guibg=none
      hi DiagnosticSignHint guibg=none
      hi DiagnosticSignInfo guibg=none

      lua << EOF
      ${lib.strings.fileContents ./neovim/config.lua}
      EOF
    '';
  };

}
