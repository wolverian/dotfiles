{ pkgs, lib }: {
  enable = true;
  vimAlias = true;

  plugins = with pkgs.vimPlugins; [
    vim-surround
    vim-commentary
    vim-repeat
    nvim-autopairs
    telescope-nvim
    # I think this causes some slowness, but it's useful sometimes.
    # Maybe move to a devShell for the custom theme?
    # {
    #   plugin = nvim-colorizer-lua;
    #   type = "lua";
    #   config = "require'colorizer'.setup()";
    # }

    (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))

    (pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "icecube";
      version = "1.0.0";
      src = ./neovim/icecube;
    })

    # these don't have treesitter grammars yet
    purescript-vim
    dhall-vim

    nvim-jdtls

    { plugin = nvim-lspconfig;
      type = "lua";
      config = lib.strings.fileContents ./neovim/lsp.lua;
    }
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
