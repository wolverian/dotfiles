{ pkgs, lib }: {
  enable = true;
  vimAlias = true;
  package = pkgs.neovim-nightly;

  plugins = with pkgs.vimPlugins; [
    vim-commentary
    nvim-web-devicons
    nvim-autopairs
    telescope-nvim
    diffview-nvim
    lualine-nvim

    # I think this causes some slowness, but it's useful sometimes.
    # Maybe move to a devShell for the custom theme?
    # nvim-colorizer-lua

    (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))

    (pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "icecube";
      version = "1.0.0";
      src = ./neovim/icecube;
    })

    (pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "vim-unison";
      version = "1.0.0";
      src = ./neovim/vim-unison;
    })

    (pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "nvim-osc52";
      version = "1.0.0";
      src = pkgs.fetchFromGitHub {
        owner = "ojroques";
        repo = "nvim-osc52";
        rev = "6ebd6f3fec198b7b4d7aedd2b0619cd05ebcbaac";
        sha256 = "sha256-cMrUaQomxQpyORq33nwn6TK2Lj/4/jJ7y7Swy8aiD0s=";
      };
    })

    # these don't have treesitter grammars yet
    purescript-vim
    dhall-vim

    nvim-jdtls

    { plugin = nvim-lspconfig;
      type = "lua";
      config = lib.strings.fileContents ./neovim/lsp.lua;
    }

    (pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "nvim-surround";
      version = "v1.0.0";
      src = pkgs.fetchFromGitHub {
        owner = "kylechui";
        repo = "nvim-surround";
        rev = "a06dea11e7fdcf338776fa51fa5277163ffb048d";
        sha256 = "sha256-RCwBuoc9LYDZeDy6XuxxsR7GvZgmsZca59iD4dccKH0=";
      };
      meta.homepage = "https://github.com/kylechui/nvim-surround";
    })

  ];

  extraConfig = ''
    lua << EOF
    ${lib.strings.fileContents ./neovim/config.lua}
    EOF

    " Silent grepping that automatically opens the quickfix window
    command! -nargs=+ Rg execute 'silent grep! <args>' | copen 10

    filetype plugin indent on
  '';
}
