
{ config, pkgs, ... }: {

  imports =
    [ 
		./themes/themes.nix
      
    ];


		home = {
				username = "shan";
				homeDirectory = "/home/shan";
				stateVersion = "24.11";


				packages = with pkgs; [

					zsh
					zsh-autocomplete
					zsh-autosuggestions
					zsh-syntax-highlighting
					oh-my-zsh

				];

				sessionVariables = {
					PATH = "$HOME/bin/hypr/scripts/:$PATH";
				};



				};

				programs.zsh = {
						enable = true;
						enableCompletion = true;
						autosuggestion.enable = true;
						syntaxHighlighting.enable = false;

						shellAliases = {
							ll = "ls -l";
							update = "sudo nixos-rebuild switch";
						};
						history.size = 10000;

						oh-my-zsh = {
							enable = true;
							plugins = [ "git" ];
							theme = "robbyrussell";
						};
				};


}