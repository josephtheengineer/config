{ config, pkgs, ... }:
let
	FG = "#3c4a43";
	BG = "#00000000";

	MENU_COMMAND = "wofi --show drun --display-drun 'SYSTEM:' | xargs swaymsg exec";
in
{
	wayland.windowManager.sway = {
		enable = true;
		#xwayland = false;
		config = {
			assigns = {
				"2" = [{ class = "Godot"; }];
				"3" = [{ class = "qutebrowser"; }];
			};
			bars = [{
				hiddenState = "show";
				statusCommand = "~/var/lib/scripts/status.sh";
				workspaceNumbers = false;
				fonts = [ "Noto Mono for Powerline 6" ];
				colors = {
					background = "#00000000";
					#separator = "";
					#statusline = "";

					inactiveWorkspace = {
						background = "#32323200";
						border = "#32323200";
						text = "#5c5c5c";
					};
					#urgentWorkspace = {
					#	background = "";
					#	border = "";
					#	text = "";
					#}
					#focusedWorkspace = {
					#	background = "";
					#	border = "";
					#	text = "";
					#}
					#bindingMode = {
					#	background = "";
					#	border = "";
					#	text = "";
					#}
					#activeWorkspace = {
					#	background = "";
					#	border = "";
					#	text = "";
					#}
				};
			}];
			colors = {
				background = BG;
				focused = {
					background = BG;
					border = BG;
					childBorder = FG;
					indicator = FG;
					text = FG;
				};
				focusedInactive = {
					background = BG;
					border = BG;
					childBorder = BG;
					indicator = BG;
					text = FG;
				};
				placeholder = {
					background = BG;
					border = BG; # IGNORED
					childBorder = BG;
					indicator = BG; # IGNORED
					text = FG;
				};
				unfocused = {
					background = BG;
					border = BG;
					childBorder = BG;
					indicator = BG;
					text = FG;
				};
				urgent = {
					background = "#555555";
					border = BG;
					childBorder = FG;
					indicator = FG;
					text = FG;
				};
			};

			floating = {
				border = 2;
				titlebar = true;
			};

			fonts = [ "Noto Mono for Powerline 6" ];

			gaps = {
				inner = 20;
				top = -20;
			};

			input = {
				"*" = {
					xkb_layout = "us";
					xkb_variant = "colemak";
					tap = "enabled";
				};
			};

			left = "n";
			down = "e";
			up = "i";
			right = "o";

			keybindings = {
			# basics
				"Return" = "exec kitty";
				"Shift+q" = "kill";
				"Shift+c" = "reload";
				"Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

			# moving around
				"Left" = "focus left";
				"Right" = "focus right";
				"Up" = "focus up";
				"Down" = "focus down";

				"Shift+Left" = "move left";
				"Shift+Right" = "move right";
				"Shift+Up" = "move up";
				"Shift+Down" = "move down";

			# switch to workspace
				"1" = "exec /etc/zsh/workspace-manager.sh switch 1";
				"2" = "exec /etc/zsh/workspace-manager.sh switch 2";
				"3" = "exec /etc/zsh/workspace-manager.sh switch 3";
				"4" = "exec /etc/zsh/workspace-manager.sh switch 4";
				"5" = "exec /etc/zsh/workspace-manager.sh switch 5";
				"6" = "exec /etc/zsh/workspace-manager.sh switch 6";
				"7" = "exec /etc/zsh/workspace-manager.sh switch 7";
				"8" = "exec /etc/zsh/workspace-manager.sh switch 8";
				"9" = "exec /etc/zsh/workspace-manager.sh switch 9";
				"0" = "exec /etc/zsh/workspace-manager.sh switch 10";

				"F1" = "exec /etc/zsh/workspace-manager.sh switch 1:F1";
				"F2" = "exec /etc/zsh/workspace-manager.sh switch 2:F2";
				"F3" = "exec /etc/zsh/workspace-manager.sh switch 3:F3";
				"F4" = "exec /etc/zsh/workspace-manager.sh switch 4:F4";
				"F5" = "exec /etc/zsh/workspace-manager.sh switch 5:F5";
				"F6" = "exec /etc/zsh/workspace-manager.sh switch 6:F6";
				"F7" = "exec /etc/zsh/workspace-manager.sh switch 7:F7";
				"F8" = "exec /etc/zsh/workspace-manager.sh switch 8:F8";
				"F9" = "exec /etc/zsh/workspace-manager.sh switch 9:F9";
				"F10" = "exec /etc/zsh/workspace-manager.sh switch 10:F10";
				"F11" = "exec /etc/zsh/workspace-manager.sh switch 11:F11";
				"F12" = "exec /etc/zsh/workspace-manager.sh switch 12:F12";

			# layout
				"b" = "splith";
				"v" = "splitv";

				"s" = "layout stacking";
				"w" = "layout tabbed";
				"e" = "layout toggle split";

				"f" = "fullscreen";
				"Shift+space" = "floating toggle";
				"d" = "focus mode_toggle"; # switch focus between tiling and floating
				"a" = "focus parent";

			# sidebar
				"bracketleft" = "exec killall conky; exec ~/var/lib/scripts/workspace-manager.sh set-mode left";
				"bracketright" = "exec killall conky; exec ~/var/lib/scripts/workspace-manager.sh set-mode right";

			# scratchpad
				"Shift+minus" = "move scratchpad";
				"minus" = "scratchpad show";


			# audio
				"XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume 0 +5% #increase sound volume";
				"XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume 0 -5% #decrease sound volume";
				"XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute 0 toggle";


			# screen brightness
				"XF86MonBrightnessUp" = "exec light -A 20 # increase screen brightness";
				"XF86MonBrightnessDown" = "exec light -U 20 # decrease screen brightness";


			# media player
				"XF86AudioPlay" = "exec playerctl play";
				"XF86AudioPause" = "exec playerctl pause";
				"XF86AudioNext" = "exec playerctl next";
				"XF86AudioPrev" = "exec playerctl previous";

			# print
				"Print" = "exec grim ~/desktop/screenshots/$(date +'%Y-%m-%d_%H:%M:%S').png";

			# modes
				"Super_L" = "mode insert";
				"space" = "mode launch; exec ${MENU_COMMAND}";
				"r" = "mode resize";
				"m" = "mode move";
			};

			modes = {
				insert = {
					"Super_L" = "mode default";
				};

				resize = {
					Escape = "mode default";
					"Left" = "resize shrink width 10px";
					"Down" = "resize grow height 10px";
					"Up" = "resize shrink height 10px";
					"Right" = "resize grow width 10px";
				};

				move = {
					Escape = "mode default";
					"1" = "move container to workspace 1";
					"2" = "move container to workspace 2";
					"3" = "move container to workspace 3";
					"4" = "move container to workspace 4";
					"5" = "move container to workspace 5";
					"6" = "move container to workspace 6";
					"7" = "move container to workspace 7";
					"8" = "move container to workspace 8";
					"9" = "move container to workspace 9";
					"0" = "move container to workspace 10";

					"F1" = "move container to workspace 1:F1";
					"F2" = "move container to workspace 2:F2";
					"F3" = "move container to workspace 3:F3";
					"F4" = "move container to workspace 4:F4";
					"F5" = "move container to workspace 5:F5";
					"F6" = "move container to workspace 6:F6";
					"F7" = "move container to workspace 7:F7";
					"F8" = "move container to workspace 8:F8";
					"F9" = "move container to workspace 9:F9";
					"F10" = "move container to workspace 10:F10";
					"F11" = "move container to workspace 11:F11";
					"F12" = "move container to workspace 12:F12";
				};
			};

			output = {
				"*" = {
					bg = "~/var/lib/sway/background-image fill";
				};
				DP-1 = {
					pos = "0,0";
				};
				DVI-D-1 = {
					pos = "1920,350";
				};
			};

			window = {
				titlebar = true;
			};
		};

		extraConfig =
			''
		# idle
			exec swayidle -w \
				timeout 1000 swaylock -f -c 000000c8 \
			# 	timeout 600 'swaymsg "output * dpms off"' \
			# 	resume 'swaymsg "output * dpms on"' \
			# 	before-sleep 'swaylock -f -c 000000'
			#
			# This will lock your screen after 300 seconds of inactivity, then turn off
			# your displays after another 300 seconds, and turn your screens back on when
			# resumed. It will also lock your screen before your computer goes to sleep.


		# assign displays to workspaces
			set $display1 DP-1
			set $display2 DVI-D-1

			workspace 1 output $display1
			workspace 2 output $display1
			workspace 3 output $display1
			workspace 4 output $display1
			workspace 5 output $display1
			workspace 6 output $display1
			workspace 7 output $display1
			workspace 8 output $display1
			workspace 9 output $display1
			workspace 10 output $display1

			workspace 1:F1 output $display2
			workspace 2:F2 output $display2
			workspace 3:F3 output $display2
			workspace 4:F4 output $display2
			workspace 5:F5 output $display2
			workspace 6:F6 output $display2
			workspace 7:F7 output $display2
			workspace 8:F8 output $display2
			workspace 9:F9 output $display2
			workspace 10:F10 output $display2
			workspace 11:F11 output $display2
			workspace 12:F12 output $display2


		# default border
			default_border normal 1

		# Assigns
			for_window [class="uplink"] move to workspace 1
			for_window [class="RPG"] move to workspace 1

		# Modes
			mode "launch" {
				bindsym Escape mode "default"; exec pkill rofi
				bindsym --release Return mode "default"
			}
		'';
	};
}
