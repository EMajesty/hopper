{
  description = "Hopper - STM32H750 development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            # STM32CubeMX - MCU configuration and code generation
            stm32cubemx

            # ARM embedded toolchain
            gcc-arm-embedded

            # Build tools
            cmake
            gnumake

            # Flashing and debugging
            openocd
            stlink

            # Serial monitor
            minicom
          ];

          shellHook = ''
            echo "Hopper STM32H750 dev environment"
            echo "  cubemx  - STM32CubeMX"
            echo "  arm-none-eabi-gcc --version"
            echo "  openocd - debugger/flasher"
          '';
        };
      }
    );
}
