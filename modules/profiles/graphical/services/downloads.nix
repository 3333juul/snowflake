{pkgs, ...}: let
  organizeScript = pkgs.writeShellScriptBin "organize-downloads" ''
    #!/bin/bash

    move_safe() {
      local src=$1
      local dest_dir=$2
      local dest_file="$dest_dir/$(basename "$src")"

      # if the file/folder with the same name exists, add suffix to avoid overwriting.
      if [[ -e "$dest_file" ]]; then
        local counter=1
        while [[ -e "$dest_file" ]]; do
          dest_file="$dest_dir/$(basename "$src" ."''${src##*.}")_$counter.''${src##*.}"
          ((counter++))
        done
      fi

      mv "$src" "$dest_file"
    }

    allowed_dirs=(
      "$HOME/downloads/images"
      "$HOME/downloads/videos"
      "$HOME/downloads/github"
      "$HOME/downloads/pdf"
      "$HOME/downloads/torrents"
      "$HOME/downloads/zips"
      "$HOME/downloads/docs"
      "$HOME/downloads/extra"
    )

    for file in "$HOME"/downloads/*; do
     # ignore temporary download files
      if [[ "$file" == *.part || "$file" == *.crdownload ]]; then
        continue
      fi

      # skip directories
      # if [[ -d "$file" ]]; then
      #   continue
      # fi

      if [[ -d "$file" ]]; then
        # check if the folder in on the allowed_dirs list
        is_allowed=0
        for allowed_dir in "''${allowed_dirs[@]}"; do
          if [[ "$file" == "$allowed_dir" ]]; then
            is_allowed=1
            break
          fi
        done

        # if folder is not allowed move it to the 'extra' folder
        if [[ $is_allowed -eq 0 ]]; then
          mkdir -p "$HOME/downloads/folders"
          move_safe "$file" "$HOME/downloads/folders/"
        fi
        continue
      fi

      # move files to their appropriate folders
      if [[ $file == *.mp3 || $file == *.wav ]]; then
        mkdir -p "$HOME/downloads/music"
        move_safe "$file" "$HOME/downloads/music/"
      elif [[ $file == *.jpg || $file == *.png || $file == *.jpeg || $file == *.gif ]]; then
        mkdir -p "$HOME/downloads/images"
        move_safe "$file" "$HOME/downloads/images/"
      elif [[ $file == *.mp4 || $file == *.mov ]]; then
        mkdir -p "$HOME/downloads/videos"
        move_safe "$file" "$HOME/downloads/videos/"
      elif [[ $file == *.pdf ]]; then
        mkdir -p "$HOME/downloads/pdf"
        move_safe "$file" "$HOME/downloads/pdf/"
      elif [[ $file == *.zip || $file == *.tar* || $file == *.deb ]]; then
        mkdir -p "$HOME/downloads/zips"
        move_safe "$file" "$HOME/downloads/folders/"
      elif [[ $file == *.csv || $file == *.ods || $file == *.xlsx || $file == *.txt || $file == *.docx || $file == *.doc ]]; then
        mkdir -p "$HOME/downloads/docs"
        move_safe "$file" "$HOME/downloads/docs/"
      else
        mkdir -p "$HOME/downloads/extra"
        move_safe "$file" "$HOME/downloads/extra/"
      fi
    done
  '';
in {
  environment.systemPackages = [organizeScript];

  systemd = {
    user.services.organize-downloads = {
      enable = true;
      description = "Downloads Organizer";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${organizeScript}/bin/organize-downloads";
        Restart = "always";
        RestartSec = 5;
      };
      wantedBy = ["graphical-session.target"];
    };
  };
}
