{
  programs.yazi.keymap = {
    manager.prepend_keymap = [
      {
        on = ["<C-s>"];
        run = "shell --confirm 'yazi-dir'";
        desc = "Preview all images in the current directory with rofi";
      }
      {
        on = ["I"];
        run = "shell --confirm 'imgv'";
        desc = "Preview all images in the current directory with vimiv";
        # run = "shell --confirm 'pqiv --auto-montage-mode .'";
        # desc = "Preview all images in the current directory with pqiv";
        # run = "shell --confirm 'swayimg --gallery '$(pwd)''";
        # desc = "Preview all images in the current directory with swayimg";
      }
      {
        on = ["T"];
        run = "shell --confirm 'rofi-gridview'";
        desc = "Preview all images in the current directory with rofi";
      }
      {
        on = ["g" "h"];
        run = "cd ~";
        desc = "Go to the home directory";
      }
      {
        on = ["g" "n"];
        run = "cd ~/nixos-config";
        desc = "Go to the nixos config directory";
      }
      {
        on = ["g" "c"];
        run = "cd ~/.config";
        desc = "Go to the config directory";
      }
      {
        on = ["g" "d"];
        run = "cd ~/downloads";
        desc = "Go to the downloads directory";
      }
      {
        on = ["g" "D"];
        run = "cd ~/documents";
        desc = "Go to the documents directory";
      }
      {
        on = ["g" "p"];
        run = "cd ~/media/pictures";
        desc = "Go to the pictures directory";
      }
      {
        on = ["g" "v"];
        run = "cd ~/media/videos";
        desc = "Go to the videos directory";
      }
      {
        on = ["g" "w"];
        run = "cd ~/media/pictures/wallpapers";
        desc = "Go to the wallpapers directory";
      }
      {
        on = ["g" "t"];
        run = "cd /tmp";
        desc = "Go to the temporary directory";
      }
      {
        on = ["g" "<Space>"];
        run = "cd --interactive";
        desc = "Go to a directory interactively";
      }
    ];
  };
}
