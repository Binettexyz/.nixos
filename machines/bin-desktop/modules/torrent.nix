{ config, pkgs, ... }: {

    # services

    services.transmission = {
      enable = true;
      group = "users";
      settings = {
        download-dir = "/home/binette/downloads/torrents";
        blocklist-enabled = true;
        blocklist-url = "http://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=gz";
        encryption = 1;
        incomplete-dir = "/home/binette/downloads/torrents/.incomplete";
        incomplete-dir-enabled = true;
        message-level = 1;
        peer-port = 50778;
        peer-port-random-high = 65535;
        peer-port-random-low = 49152;
        peer-port-random-on-start = true;
        rpc-bind-address = "127.0.0.1";
        rpc-port = 9091;
        rpc-enable = true;
        rpc-password = "{0e3d50e4df22a91a07b8a67658748b4c295cbfeaghfWAG9u";
        script-torrent-done-enabled = true;
        script-torrent-done-filename = "/home/binette/.local/bin/tordone";
        umask = 18;
        utp-enabled = true;
      };
    };

}