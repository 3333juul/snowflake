{pkgs, ...}: {
  environment.systemPackages = let
    restore = pkgs.writeShellScriptBin "restore" ''
      set -e

      # list available remotes
      echo "🔗 Available Rclone remotes:"
      ${pkgs.rclone}/bin/rclone listremotes
      read -rp "🧩 Choose remote name (e.g., onedrive): " REMOTE

      # ask for the backup folder inside the remote
      read -rp "📁 Enter the path to the Restic repository folder (e.g., restic-backup): " REPO_DIR
      REPO="rclone:$REMOTE:$REPO_DIR"

      # show snapshots
      echo -e "\n📸 Available snapshots in the repository:"
      ${pkgs.restic}/bin/restic -r "$REPO" snapshots

      # ask what to restore
      read -rp $'\n📂 Enter the full path to the folder you want to restore: ' INCLUDE_PATH

      # ask where to restore (default: ~/projects/restore)
      read -rp "🎯 Restore to which folder? (Press ENTER for ~/projects/restore): " TARGET_PATH
      TARGET_PATH="''${TARGET_PATH:-$HOME/projects/restore}"

      # confirmation
      echo -e "\n🔁 Restoring from the latest snapshot:"
      echo "   Repository:     $REPO"
      echo "   Restoring:      $INCLUDE_PATH"
      echo "   Destination:    $TARGET_PATH"
      read -rp $'\nProceed with restore? (y/n): ' CONFIRM
      if [[ "$CONFIRM" != "y" ]]; then
        echo "❌ Operation cancelled."
        exit 0
      fi

      # run the restore command
      ${pkgs.restic}/bin/restic -r "$REPO" restore latest --target "$TARGET_PATH" --include "$INCLUDE_PATH"
    '';
  in [restore];
}
