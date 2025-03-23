{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.services;
in {
  services.glance = mkIf cfg.glance.enable {
    enable = true;
    settings = {
      theme = {
        background-color = "0 0 16"; # #282828
        primary-color = "40 55 81"; # #ebdbb2
        contrast-multiplier = 1;
        #positive-color = "";
        #negative-color = "";
      };
      pages = [
        {
          name = "Home";
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "bookmarks";
                  groups = [
                    {
                      links = [
                        {
                          title = "Inoreader";
                          url = "https://www.inoreader.com/";
                        }
                        {
                          title = "Raindrop";
                          url = "https://app.raindrop.io/";
                        }
                        {
                          title = "Syncthing";
                          url = "http://localhost:8384/";
                        }
                        {
                          title = "Nix Packages Search";
                          url = "https://search.nixos.org/packages";
                        }
                        {
                          title = "Home Manager Options";
                          url = "https://home-manager-options.extranix.com/";
                        }
                        {
                          title = "Library Genesis";
                          url = "https://libgen.is/";
                        }
                        {
                          title = "FMHY";
                          url = "https://fmhy.net/";
                        }
                      ];
                    }
                  ];
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "rss";
                  style = "detailed-list";
                  limit = 25;
                  collapseAfter = 5;
                  cache = "3h";
                  feeds = [
                    {
                      url = "https://illwill.com/feed.xml";
                      title = "Ill Will";
                    }
                    {
                      url = "https://machinamysli.org/feed/";
                      title = "Machina Myśli";
                    }
                  ];
                }
              ];
            }
            # {
            #   size = "small";
            #   widgets = [
            #     {
            #       type = "weather";
            #       hide-location = true;
            #     }
            #   ];
            # }
          ];
        }
        {
          name = "YouTube";
          columns = [
            {
              size = "full";
              widgets = [
                {
                  type = "group";
                  widgets = [
                    {
                      title = "Philosophy";
                      type = "videos";
                      style = "grid-cards";
                      collapse-after-rows = 5;
                      channels = [
                        "UCSkzHxIcfoEr69MWBdo0ppg" # Jonas Ceika
                        "UC738SsV6BSLUVvMgKnEFFzQ" # Epoch Philosophy
                        "UCvX5pUki31Bs3y28bvPY6Jg" # Pojęcia przy pracy
                        "UCnEuIogVV2Mv6Q1a3nHIRsQ" # Carefree Wandering
                      ];
                    }
                    {
                      title = "Religion";
                      type = "videos";
                      style = "grid-cards";
                      collapse-after-rows = 5;
                      channels = [
                        "UCoydhtfFSk1fZXNRnkGnneQ" # ESOTERICA
                        "UC9dRb4fbJQIbQ3KHJZF_z0g" # Let's Talk Religion
                      ];
                    }
                    {
                      title = "Film";
                      type = "videos";
                      style = "grid-cards";
                      collapse-after-rows = 5;
                      channels = [
                        "UCeGsT5rtZBN0LLK2OxzrA7g" # Studio Ersatz
                        "UCL5kBJmBUVFLYBDiSiK1VDw" # The Cinema Cartography
                      ];
                    }
                    {
                      title = "Fashion";
                      type = "videos";
                      style = "grid-cards";
                      collapse-after-rows = 5;
                      channels = [
                        "UCml6MlANT7yoDJR6EBHqs0g" # Tuba Avalon
                        "UC1OR9yjgsvoFK3xxhCs-19Q" # Bliss Foster
                      ];
                    }
                  ];
                }
              ];
            }
          ];
        }
        {
          name = "Linux";
          columns = [
            {
              size = "small";
              widgets = [
                {type = "hacker-news";}
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "videos";
                  style = "grid-cards";
                  collapse-after-rows = 2;
                  channels = [
                    "UC_zBdZ0_H_jn41FDRG7q4Tw" # Vimjoyer
                    "UCeZyoDTk0J-UPhd7MUktexw" # LibrePhoenix
                    "UCld68syR8Wi-GY_n4CaoJGA" # Brodie Robertson
                  ];
                }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "reddit";
                  subreddit = "unixporn";
                  show-thumbnails = true;
                }
              ];
            }
          ];
        }
      ];
      server = {
        port = 5678;
      };
    };
  };
}
