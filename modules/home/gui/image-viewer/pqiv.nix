{
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.gui.image;
in {
  programs.pqiv = lib.mkIf cfg.pqiv.enable {
    enable = true;

    settings = {
      options = {
        lazy-load = true;
        hide-info-box = true;
        #scale-mode-screen-fraction = true;
        #background-pattern = "black";
        #disable-backends = "archive,archive_cbx,libav,poppler,spectre";
        max-depth = 1;
        thumbnail-size = "192x192";
        command-1 = "ya emit reveal";
        command-2 = "thunar";
      };
    };

    extraConfig = ''
      [actions]
      set_cursor_auto_hide(1)

      [keybindings]
      # defaults:
      # q quit
      # f toggle fullscreen
      # r reload
      # m toggle montage mode

      # file
      gg { goto_file_byindex(0); }
      G { goto_file_byindex(-1); }
      b { goto_earlier_file(); }
      k { goto_file_relative(-1); }
      j { goto_file_relative(1); }
      # k { goto_file_relative(-10); }
      # o { goto_file_relative(10); }
      <Return> { montage_mode_enter(); }

      # scrolling
      # TODO percentage shifts
      H { shift_x(-20); }
      K { shift_y(-50); }
      J { shift_y(50); }
      L { shift_x(20); }

      @MONTAGE {
        gg { goto_file_byindex(0); }
        G { goto_file_byindex(-1); }
      	h { montage_mode_shift_x(-1); }
      	j { montage_mode_shift_y(1); }
      	k { montage_mode_shift_y(-1); }
      	l { montage_mode_shift_x(1); }
      	<Control>d { montage_mode_shift_y_pg(1); }
      	<Control>u { montage_mode_shift_y_pg(-1); }
        <Return> { montage_mode_return_proceed(); }
      }

      # zoom
      <equal> { set_scale_level_absolute(1); }

      # changing thumbnail size
      @MONTAGE {
      	<minus> { send_keys(:t192); }
      	<plus> { send_keys(:t320); }
      	:t128 {
      		set_thumbnail_size(128, 128);
      		bind_key(@MONTAGE { <minus> { send_keys(:t384\); }});
      		bind_key(@MONTAGE { <plus> { send_keys(:t192\); }});
      	}
      	:t192 {
      		set_thumbnail_size(192, 192);
      		bind_key(@MONTAGE { <minus> { send_keys(:t128\); }});
      		bind_key(@MONTAGE { <plus> { send_keys(:t256\); }});
      	}
      	:t256 {
      		set_thumbnail_size(256, 256);
      		bind_key(@MONTAGE { <minus> { send_keys(:t192\); }});
      		bind_key(@MONTAGE { <plus> { send_keys(:t320\); }});
      	}
      	:t320 {
      		set_thumbnail_size(320, 320);
      		bind_key(@MONTAGE { <minus> { send_keys(:t256\); }});
      		bind_key(@MONTAGE { <plus> { send_keys(:t384\); }});
      	}
      	:t384 {
      		set_thumbnail_size(384, 384);
      		bind_key(@MONTAGE { <minus> { send_keys(:t320\); }});
      		bind_key(@MONTAGE { <plus> { send_keys(:t128\); }});
      	}
      	# :t512 {
      	# 	set_thumbnail_size(512, 512);
      	# 	bind_key(@MONTAGE { u { send_keys(:t384\); }});
      	# 	bind_key(@MONTAGE { y { send_keys(:t128\); }});
      	# }
      }
    '';
  };
}
