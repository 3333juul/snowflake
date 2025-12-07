{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.services.restic.cli;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = let
      restore = pkgs.writeShellScriptBin "restore" ''
        set -e

        # take data from secrets
        export RESTIC_PASSWORD_FILE=${config.age.secrets.restic-password.path}

        # list available remotes
        echo "🔗 Available Rclone remotes:"
        ${pkgs.rclone}/bin/rclone listremotes
        read -rp "🧩 Choose remote name (e.g., onedrive): " REMOTE

        # ask for the backup folder inside the remote
        read -rp "📁 Enter the path to the Restic repository folder (e.g., restic-backup): " REPO_DIR
        REPO="rclone:$REMOTE:$REPO_DIR"

        echo -e "\n📸 Fetching snapshots..."
        SNAPSHOTS=$(${pkgs.restic}/bin/restic -r "$REPO" snapshots --json)

        if [[ -z "$SNAPSHOTS" ]]; then
          echo "❌ No snapshots found!"
          exit 1
        fi

        # choose snapshot with fzf
        echo -e "\n📦 Select snapshot using fzf:"
        SELECTED_SNAPSHOT=$(echo "$SNAPSHOTS" \
          | ${pkgs.jq}/bin/jq -r '
            sort_by(.time) | reverse |
            .[] | "\(.id)\t\(.time)\t\(.paths | join(", "))"' \
          | ${pkgs.fzf}/bin/fzf --delimiter='\t' --with-nth=2,3 --preview 'echo -e "Snapshot ID: {1}\nDate: {2}\nPaths: {3}"')

        if [[ -z "$SELECTED_SNAPSHOT" ]]; then
          echo "❌ No snapshot selected."
          exit 1
        fi

        SNAPSHOT_ID=$(echo "$SELECTED_SNAPSHOT" | cut -f1)

        echo "✔️ Selected snapshot: $SNAPSHOT_ID"

        # ask what to restore
        read -rp $'\n📂 Enter the full path to the folder you want to restore: ' INCLUDE_PATH

        # ask where to restore (default: ~/projects/restore)
        read -rp "🎯 Restore to which folder? (Press ENTER for ~/projects/restore): " TARGET_PATH
        TARGET_PATH="''${TARGET_PATH:-$HOME/projects/restore}"

        # confirmation
        echo -e "\n🔁 Restoring:"
        echo "   Repository:     $REPO"
        echo "   Snapshot:       $SNAPSHOT_ID"
        echo "   Path:           $INCLUDE_PATH"
        echo "   Destination:    $TARGET_PATH"

        read -rp $'\nProceed with restore? (y/n): ' CONFIRM
        if [[ "$CONFIRM" != "y" ]]; then
          echo "❌ Operation cancelled."
          exit 0
        fi

        # run the restore command
        ${pkgs.restic}/bin/restic -r "$REPO" restore "$SNAPSHOT_ID" --target "$TARGET_PATH" --include "$INCLUDE_PATH"
      '';
    in [restore];
  };
}
