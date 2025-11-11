{ config, pkgs, lib, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      show="drun";
      width=750;
      height=400;
      always_parse_args=true;
      show_all=false;
      print_command=true;
      insensitive=true;
      prompt="What's up? :3";
      allow_images=true;
      no_actions=true;
    };
    style = ''
    /* Mocha Blue */
    @define-color accent #6c7086;
    @define-color txt #cdd6f4;
    @define-color bg #313244;
    @define-color bg2 #45475a;
    
     /* Window */
     window {
        margin: 0px;
        padding: 0px;
        border: 2px solid @accent;
        border-radius: 10px;
        background-color: @bg;
        animation: slideIn 0.1s ease-in-out both;
     }
    
     /* Slide In */
     @keyframes slideIn {
        0% {
           opacity: 0;
        }
    
        100% {
           opacity: 1;
        }
     }
    
     /* Inner Box */
     #inner-box {
        margin: 5px;
        padding: 0px;
        border: none;
        background-color: @bg;
        animation: fadeIn 0.1s ease-in-out both;
     }
    
     /* Fade In */
     @keyframes fadeIn {
        0% {
           opacity: 0;
        }
    
        100% {
           opacity: 1;
        }
     }
    
     /* Outer Box */
     #outer-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: @bg;
     }
    
     /* Scroll */
     #scroll {
        margin: 0px;
        padding: 0px;
        border: none;
     }
    
     /* Input */
     #input {
        margin: 5px;
        padding: 5px;
        border: none;
        color: @accent;
        background-color: @bg2;
        animation: fadeIn 0.1s ease-in-out both;
     }
    
     /* Text */
     #text {
        margin: 5px;
        padding: 0px;
        border: none;
        color: @txt;
        animation: fadeIn 0.1s ease-in-out both;
     }
    
     /* Selected Entry */
     #entry:selected {
       background-color: @accent;
     }
    
     #entry:selected #text {
        color: @txt;
     }
    '';
  };

}
