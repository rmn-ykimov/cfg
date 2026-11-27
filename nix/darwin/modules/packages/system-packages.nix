# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget  
{ pkgs, ... }:

{
  environment.systemPackages =
    import ../../../shared/packages.nix { inherit pkgs; }
    ++ (with pkgs; [
      # macOS specific
      mkalias

      # GUI applications (moved to Homebrew casks in homebrew.nix)
    ]);
}
