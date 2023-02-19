{ pkgs, config, lib, ... }:
with lib;

let
  anime4k = pkgs.anime4k;
  anime4kHighSpecs = {
    "CTRL+1" = ''no-osd change-list glsl-shaders set "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_VL.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_VL.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode A (HQ)"'';
    "CTRL+2" = ''no-osd change-list glsl-shaders set "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_Soft_VL.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_VL.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode B (HQ)"'';
    "CTRL+3" = ''no-osd change-list glsl-shaders set "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode C (HQ)"'';
    "CTRL+4" = ''no-osd change-list glsl-shaders set "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_VL.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_VL.glsl:${anime4k}/Anime4K_Restore_CNN_M.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode A+A (HQ)"'';
    "CTRL+5" = ''no-osd change-list glsl-shaders set "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_Soft_VL.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_VL.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Restore_CNN_Soft_M.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode B+B (HQ)"'';
    "CTRL+6" = ''no-osd change-list glsl-shaders set "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Restore_CNN_M.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl"; show-text "Anime4K: Mode C+A (HQ)"'';
    "CTRL+0" = ''no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"'';
  };
  anime4kLowSpecs = {
    "CTRL+1" = ''no-osd change-list glsl-shaders set "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_M.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode A (Fast)"'';
    "CTRL+2" = ''no-osd change-list glsl-shaders set "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_Soft_M.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode B (Fast)"'';
    "CTRL+3" = ''no-osd change-list glsl-shaders set "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode C (Fast)"'';
    "CTRL+4" = ''no-osd change-list glsl-shaders set "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_M.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${anime4k}/Anime4K_Restore_CNN_S.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode A+A (Fast)"'';
    "CTRL+5" = ''no-osd change-list glsl-shaders set "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_Soft_M.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Restore_CNN_Soft_S.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode B+B (Fast)"'';
    "CTRL+6" = ''no-osd change-list glsl-shaders set "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Restore_CNN_S.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode C+A (Fast)"'';
    "CTRL+0" = ''no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"'';
  };
in
{

  config = (mkMerge [
    ({
      programs.mpv = {
        enable = true;
  
        bindings = {
          "q" = "quit";
          "Q" = "quit-watch-later"; # exit and remember the playback position
          "l" = "seek 5";
          "h" = "seek -5";
          "p" = "cycle pause";
          "j" = "seek -60";
          "k" = "seek +60";
  
          "u" = "add sub-delay -0.1";
          "Shift+u" = "add sub-delay +0.1";
  
          "-" = "add volume -5";
          "=" = "add volume 5";
  
          "s" = "cycle sub";
          "Shift+s" = "cycle sub down";
          "a" = "cycle audio";
          "Shift+a" = "cycle audio down";
  
          "f" = "cycle fullscreen";
  
          "r" = "async screenshot";
          "Shift+r" = "async screenshot video";
  
            # Pro tip: Use `BACKSPACE` to stop fast-forwarding immediately.
          ")" = "script-binding fastforward/speedup"; # Make playback faster
          "(" = "script-binding fastforward/slowdown"; # Reduce speed
  
          "i" = "script-binding stats/display-stats-toggle";
  
        };# // mkIf (device.type == "desktop") anime4kHighSpecs;
  
        scripts = with pkgs.mpvScripts; [ sponsorblock ];
      };

      home.file.".config/mpv/shaders".source = ./etc/shaders;
      home.file.".config/mpv/scripts".source = ./etc/scripts;
      home.file.".config/mpv/script-opts".source = ./etc/script-opts;

    })
    (mkIf (config.modules.device.type == "desktop") {
      programs.mpv.bindings = anime4kHighSpecs;

      home.file.".config/mpv/mpv.conf".text = lib.strings.concatStringsSep "\n" [
            # ---Renderer--- #
        ''
          # Default profile
          # This is what profile=gpu-hq do:
          # scale=spline36
          # cscale=spline36
          # dscale=mitchell
          # dither-depth=auto
          # correct-downscaling=yes
          # linear-downscaling=yes
          # sigmoid-upscaling=yes
          # deband=yes
          profile=gpu-hq
          # Uses GPU-accelerated video output by default
          vo=gpu
          
          # ===== REMOVE VOLKAN SETTINGS IF YOU ENCOUNTER PLAYBACK ISSUES AFTER ===== #
          
          # Volkan settings
          #gpu-api = "vulkan";
          #vulkan-async-compute = "yes";
          #vulkan-async-transfer = "yes";
          #vulkan-queue-count = 1;
          #vd-lavc-dr = "yes";
          
          # Enable HW decoder; "false" for software decoding
          # "auto" "vaapi" "nvdec-copy" "vdpau"
          hwdec=nvdec-copy
        ''
  
          # --General-- #
        ''  
          hr-seek-framedrop=no
          force-seekable
          #no-input-default-bindings = "";
          no-taskbar-progress
          reset-on-next-file=pause
          quiet
        ''
          
          # ---Audio--- #
        ''  
          volume=100
          volume-max=150 # maximum volume in %, everything above 100 results in amplification
          audio-stream-silence # fix audio popping on random seek
          audio-file-auto=fuzzy # external audio doesn't has to match the file name exactly to autoload
          audio-pitch-correction=yes # automatically insert scaletempo when playing with higher speed
        ''
  
          # ---Languages--- #
        ''  
          alang=ja,jp,jpn,en,eng,enUS,en-us
          slang=en,eng,enUS
        ''
  
          # ---Screenshot--- #
        ''  
          screenshot-directory=~/pictures/screenshots
          screenshot-template="%f-%wH.%wM.%wS.%wT-#%#00n"
          screenshot-format=png
          screenshot-png-compression=4		# Range is 0 to 10. 0 being no compression. compute-time to size is log so 4 is best
          screenshot-tag-colorspace=yes
          screenshot-high-bit-depth=yes		# Same output bitdepth as the video
        ''
  
          # ---UI--- #
        ''  
          # osc
          osc=no # Disable default UI
          osd-bar=no # Disable default seeking/volume indicators
          border=no # Hide the window title bar
          osd-font=sans-serif # Set a font for OSC
          osd-font-size=20
          #osd-border-size=2
          
          # Color log messages on terminal
          msg-color=yes
          msg-module=yes
          # displays a progress bar on the terminal
          term-osd-bar=yes
          # autohide the curser after 1s
          cursor-autohide=1000
          force-window=immediate
          autofit=50%x50%
          geometry=90%:5%
        ''
  
          # ---Subtitles--- #
        ''  
          sub-ass-scale-with-window=no		# May have undesired effects with signs being misplaced.
          sub-auto=fuzzy                          # external subs don't have to match the file name exactly to autoload
          #sub-gauss=0.6				# Some settings fixing VOB/PGS subtitles (creating blur & changing yellow subs to gray)
          demuxer-mkv-subtitle-preroll=yes       	# try to correctly show embedded subs when seeking
          embeddedfonts=yes			# use embedded fonts for SSA/ASS subs
          sub-fix-timing=no     # do not try to fix gaps (which might make it worse in some cases). Enable if there are scenebleeds.
          sub-file-paths-append=ass
          sub-file-paths-append=srt
          sub-file-paths-append=sub
          sub-file-paths-append=subs
          sub-file-paths-append=subtitles
          
          # Subs - Forced 
          sub-font=Open Sans SemiBold
          sub-font-size=46
          sub-blur=0.3
          sub-border-color=0.0/0.0/0.0/0.8
          sub-border-size=3.2
          sub-color=0.9/0.9/0.9/1.0
          sub-margin-x=100
          sub-margin-y=50
          sub-shadow-color=0.0/0.0/0.0/0.25
          sub-shadow-offset=0
          
          blend-subtitles=no
        ''
  
          # ---Motion Interpolation--- #
        ''  
          video-sync=display-resample
          interpolation=yes
          tscale=oversample # smoothmotion
        ''          
          
          # ---Debanding--- #
        ''  
          deband=yes
          deband-iterations=2
          deband-threshold=34
          deband-range=16
          deband-grain=48
          dither-depth=auto
        ''
  
          # ---Video Profiles--- #
        ''  
          #dither = "fruit";
          #scale = "ewa_lanczos";
          #cscale = "lanczos";
          #dscale = "mitchell";
          #scale-antiring = 0;
          #cscale-antiring = 0;
          #correct-downscaling = "yes";
          #linear-downscaling = "no";
          #sigmoid-upscaling = "yes";
        ''
  
          # ---Scaling--- #
        ''  
          # Default was (because of profile=gpu-hq):
          # scale=spline36
          # cscale=spline36
          # dscale=mitchell
          
          glsl-shaders-clr
          # luma upscaling
          # note: any FSRCNNX above FSRCNNX_x2_8-0-4-1 is not worth the additional computional overhead
          glsl-shaders=~~/shaders/FSRCNNX_x2_8-0-4-1.glsl
          scale=ewa_lanczos
          # luma downscaling
          # note: ssimdownscaler is tuned for mitchell and downscaling=no
          glsl-shaders-append=~~/shaders/SSimDownscaler.glsl
          dscale=mitchell
          linear-downscaling=no
          # chroma upscaling and downscaling
          glsl-shaders-append=~~/shaders/KrigBilateral.glsl
          cscale=mitchell # ignored with gpu-next
          sigmoid-upscaling=yes
        ''
  
          # ---Profiles--- #
        ''  
          [4k60]
          profile-desc=4k60
          profile-cond=((width ==3840 and height ==2160) and p['estimated-vf-fps']>=31)
          deband=no # turn off debanding because presume wide color gamut
          interpolation=no # turn off interpolation because presume 60fps 
          # UHD videos are already 4K so no luma upscaling is needed
          # UHD videos are YUV420 so chroma upscaling is still needed
          glsl-shaders-clr
          glsl-shaders=~~/shaders/KrigBilateral.glsl # enable if your hardware can support it
          interpolation=no # no motion interpolation required because 60fps is hardware ceiling
          # no deinterlacer required because progressive
          
          # 2160p @ 24-30fps (3840x2160 UHDTV)
          [4k30]
          profile-cond=((width ==3840 and height ==2160) and p['estimated-vf-fps']<31)
          #deband = "yes"; # necessary to avoid blue screen with KrigBilateral.glsl
          deband=no # turn off debanding because presume wide color gamut
          #UHD videos are already 4K so no luma upscaling is needed
          #UHD videos are YUV420 so chroma upscaling is still needed
          glsl-shaders-clr
          glsl-shaders=~~/shaders/KrigBilateral.glsl # enable if your hardware can support it
          # apply motion interpolation
          # no deinterlacer required because progressive
          
          # 1080p @ 60fps (progressive ATSC)
          [full-hd60]
          profile-desc=full-hd60
          profile-cond=((width ==1920 and height ==1080) and not p['video-frame-info/interlaced'] and p['estimated-vf-fps']>=31)
          # apply all luma and chroma upscaling and downscaling settings
          interpolation=no # no motion interpolation required because 60fps is hardware ceiling
          # no deinterlacer required because progressive
          
          # 1080p @ 24-30fps (NextGen TV/ATSC 3.0, progressive Blu-ray)
          [full-hd30]
          profile-desc=full-hd30
          profile-cond=((width ==1920 and height ==1080) and not p['video-frame-info/interlaced'] and p['estimated-vf-fps']<31)
          # apply all luma and chroma upscaling and downscaling settings
          # apply motion interpolation
          # no deinterlacer required because progressive
          
          # 1080i @ 24-30fps (HDTV, interlaced Blu-rays)
          [full-hd-interlaced]
          profile-desc=full-hd-interlaced
          profile-cond=((width ==1920 and height ==1080) and p['video-frame-info/interlaced'] and p['estimated-vf-fps']<31)
          # apply all luma and chroma upscaling and downscaling settings
          # apply motion interpolation
          vf=bwdif; # apply FFMPEG's bwdif deinterlacer
          
          # 720p @ 60 fps (HDTV, Blu-ray - progressive)
          [hd]
          profile-desc=hd
          profile-cond=(width ==1280 and height ==720)
          # apply all luma and chroma upscaling and downscaling settings
          interpolation=no # no motion interpolation required because 60fps is hardware ceiling
          # no deinterlacer required because progressive
        ''
  
          # ---File Type Profiles--- #
        ''  
          [extension.mkv]
          cache=yes
          demuxer-max-bytes=2000MiB
          
          [extension.gif]
          profile-restore=copy-equal # Sets the profile restore method to "copy if equal"
          profile-desc=gif
          cache=no
          no-pause
          loop-file=yes
          
          [extension.webm]
          profile-restore=copy-equal # Sets the profile restore method to "copy if equal"
          profile-desc=webm
          no-pause
          loop-file=yes
        ''
  
          # ---Protocol Specific Configuration--- #
        ''  
          [protocol-network]
          network-timeout=5
          #force-window=immediate
          hls-bitrate=max
          cache=yes
          demuxer-max-bytes=2000MiB
          demuxer-readahead-secs=300
          
          [protocol.http]
          profile=protocol-network
          
          [protocol.https]
          profile=protocol-network
          
          [protocol.ytdl]
          profile=protocol.network
        ''
      ];
    })

    (mkIf (config.modules.device.type == "laptop") {
    })
  ]);
  
}
