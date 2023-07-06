{
  description = "Runtime environment for Race Transactor";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixpkgs-unstable"; };
    flake-utils = { url = "github:numtide/flake-utils"; };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              openssl
              nginx
              certbot-full
            ];
            RUST_LOG = "info,wasmer_compiler_cranelift=error,solana_rpc_client=error";
            RUST_BACKTRACE = 1;
          };
        }
    );

  nixConfig = {
    bash-prompt-prefix = "[race-server]";
  };
}
