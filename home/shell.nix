{ config, pkgs, lib, ... }:

{
  # Zoxide configuration
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = ["--cmd z"];
  };

  # Enable zsh
  programs.zsh = { 
    enable = true;

    # Fix nix-shell
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
    
    # Cool external plugins
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Enable Oh-my-zsh
    oh-my-zsh = {
      enable = true;
      plugins = [
        "aliases" "ansible" "branch" "common-aliases" 
        "docker" "docker-compose" "fzf" "git" "gitignore" 
        "history-substring-search" "helm" "kubectl" "pip" 
        "poetry" "pylint" "ssh-agent" "systemd" "urltools"
      ];
      theme = "agnoster";
    };
    # Startup scripts
    initContent = "pfetch";
    
    # Aliases
    shellAliases = {
      cat = "bat";
      k = "kubectl";
      cd = "z";
      cleanup="sudo nix-collect-garbage";
      switch="nixos-rebuild switch --flake . --show-trace --print-build-logs --use-remote-sudo";
      config="cd /home/giank/git/nixos-config";
    };
  };
}
