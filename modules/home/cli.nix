{
  programs = {
    bat.enable = true;
    fzf.enable = true;
    lsd.enable = true;

    vim = {
      enable = true;
      settings = {
        tabstop = 2;
        shiftwidth = 4;
      };
    };

    git = {
      enable = true;
      settings = {
        user.name = "gk";
        user.email = "gk@gk.wtf";
      };
    };

    hyfetch = {
      enable = true;
      settings = {
        preset = "transgender";
        mode = "rgb";
        color_align.mode = "horizontal";
      };
    };
  };
}
