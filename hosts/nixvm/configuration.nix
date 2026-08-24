{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixvm";
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  zramSwap.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.yoram = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO69UowZhw2kMveDUs9rm7+7LosxRMnxgPvtF5hlxfvi yoram.vandevelde@MC-D4TP799X1L"
    ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake /home/yoram/nixos-config#nixvm";
    try = "sudo nixos-rebuild test --flake /home/yoram/nixos-config#nixvm";
    generations = "sudo nixos-rebuild list-generations";
  };

  environment.systemPackages = with pkgs; [ git vim curl htop neovim ]; 
 
  system.stateVersion = "26.05";
}
