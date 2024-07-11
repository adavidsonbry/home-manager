{ ... }: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      styles = {
        path_pathseparator = "";
        path_prefix_pathseparator = "";
      };
    };
    historySubstringSearch = {
      enable = true;
      searchUpKey = "$terminfo[kcuu1]";
      searchDownKey = "$terminfo[kcud1]";
    };
    defaultKeymap = "viins";

    shellAliases = {
      gg = "nvim '+Neogit'";
      hm = # sh
        "(cd ~/.config/home-manager/ && vi flake.nix) && home-manager switch && exec zsh";
    };
  };
  programs.starship = {
    enable = true;
    settings = (import ./starship.nix);
  };
  programs.zoxide = {
    enable = true;
    options = [ "--cmd" "cd" ];
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.lsd = {
    enable = true;
    enableAliases = true;
  };
  programs.bat = { enable = true; };
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    prefix = "C-a";
  };
}
