{
  inputs,
  pkgs,
  ...
}:

{

  imports = [ inputs.nix4nvchad.homeManagerModules.default ];

  programs.nvchad = {
    enable = true;
    # You can configure extra options here (see the Configuration section)
    extraPackages = with pkgs; [
      ripgrep
      lua-language-server
      stylua
      bash-language-server
      nixd
      gopls
      pyright
      svelte-language-server
    ];
    extraPlugins = ''
      return {
        { "equalsraf/neovim-gui-shim", lazy = false },
        { "nvim-lua/plenary.nvim" },
      }
    '';

  };

}
