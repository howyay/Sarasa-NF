#!/bin/bash

installFontForge() {
	echo Checking dependency...
	sudo apt-get install software-properties-common -qq

	echo Adding FontForge repository...
	sudo add-apt-repository ppa:fontforge/fontforge

	echo Running apt-get update...
	sudo apt-get update -qq

	echo Installing FontForge...
	sudo apt-get install fontforge -qq
}

downloadSarasa() {
	echo Checking if 7zip is installed...
    sudo apt-get install p7zip-full -qq

    echo Downloading Sarasa Gothic...
    sarasaVer=`curl -L https://github.com/be5invis/Sarasa-Gothic/releases/latest | grep 'sarasa-gothic-ttc-0.*<\/span' | sed 's!.*ttc-\(0\.[0-9][0-9]\.[0-9]\).*!\1!'`
    curl -L https://github.com/be5invis/Sarasa-Gothic/releases/latest/download/sarasa-gothic-ttc-$sarasaVer.7z -o $sarasaVer.7z
    
    echo Extracting Sarasa Gothic...
    mkdir src
    7z e "$sarasaVer.7z" -o"./src/"

    ls ./src/
}

downloadGlyphs() {
	echo Downloading glyph source fonts...
	mkdir -p ./src/glyphs

	curl -L https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/original-source.otf?raw=true -o ./src/glyphs/original-source.otf
	curl -L https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/devicons.ttf?raw=true -o ./src/glyphs/devicons.ttf
	curl -L https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/PowerlineSymbols.otf?raw=true -o ./src/glyphs/PowerlineSymbols.otf
	curl -L https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/PowerlineExtraSymbols.otf?raw=true -o ./src/glyphs/PowerlineExtraSymbols.otf
	curl -L https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Pomicons.otf?raw=true -o ./src/glyphs/Pomicons.otf
	curl -L https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/FontAwesome.otf?raw=true -o ./src/glyphs/FontAwesome.otf
	curl -L https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/font-awesome-extension.ttf?raw=true -o ./src/glyphs/font-awesome-extension.ttf
	curl -L https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Unicode_IEC_symbol_font.otf?raw=true -o ./src/glyphs/Unicode_IEC_symbol_font.otf
	curl -L https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/materialdesignicons-webfont.ttf?raw=true -o ./src/glyphs/materialdesignicons-webfont.ttf
	curl -L https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/weathericons-regular-webfont.ttf?raw=true -o ./src/glyphs/weathericons-regular-webfont.ttf
	curl -L https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/font-logos.ttf?raw=true -o ./src/glyphs/font-logos.ttf
	curl -L https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/octicons.ttf?raw=true -o ./src/glyphs/octicons.ttf
}

installPy() {
	echo Installing PiP, configparser and scandir...
	sudo apt install python-pip -qq
    pip install configparser scandir
}

patch() {
	mkdir dist
	echo Patching fonts...
    fontforge -script ./scripts/font-patcher.py ./src/ -l -c -q --careful -ext ttf -out ./dist
}

zip() {
    echo Packaging font files...
    7z a sarasa-gothic-nerd-fonts.7z ./dist/*.ttf
}