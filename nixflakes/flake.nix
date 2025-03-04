

{

			description = "My system configuration";


			inputs = {
					nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

					home-manager = {
							url = "github:nix-community/home-manager/release-24.11";
							inputs.nixpkgs.follows = "nixpkgs";
					};
			};

			outputs = {	nixpkgs, home-manager, ...	}@inputs: 

					let
						hostname = "nixos";
						system = "x86_64-linux";
						username = "shan";					


					in	{
					nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
							inherit system;
							modules = [	./nixos/configuration.nix	];
					};

					homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
							pkgs = nixpkgs.legacyPackages.${system};
							modules = [	./home-manager/home.nix	];
					};

			};

}




