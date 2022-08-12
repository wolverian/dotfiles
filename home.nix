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
    ranger
    sd
    fd
    git
    jq

    sumneko-lua-language-server
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
    extraConfig = lib.strings.fileContents ./tmux.conf;
    tmuxp.enable = true;
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
  programs.fzf.tmux.enableShellIntegration = true;
  programs.fzf.tmux.shellIntegrationOptions = ["-p"];

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
        config = lib.strings.fileContents ./neovim/lsp.lua;
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

      lua << EOF
      ${lib.strings.fileContents ./neovim/config.lua}
      EOF
    '';
  };

}
