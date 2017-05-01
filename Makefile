all: ttf otf dfont bdf psf

clean:
	rm -rf out/*

ttf: out/Ströbröd-ttf/Ströbröd-Regular.ttf out/Ströbröd-ttf/Ströbröd-Bold.ttf

otf: out/Ströbröd-otf/Ströbröd-Regular.otf out/Ströbröd-otf/Ströbröd-Bold.otf

dfont: out/Ströbröd-dfont/Ströbröd-Regular.dfont out/Ströbröd-dfont/Ströbröd-Bold.dfont

bdf: out/Ströbröd-bdf/Ströbröd-Regular-10.bdf out/Ströbröd-bdf/Ströbröd-Bold-10.bdf

psf: bdf out/Ströbröd-psf/Ströbröd-Regular.psf out/Ströbröd-psf/Ströbröd-Bold.psf

out/Ströbröd-ttf/%.ttf: %.sfd export.py
	fontforge -script export.py $< $@

out/Ströbröd-otf/%.otf: %.sfd export.py
	fontforge -script export.py $< $@

out/Ströbröd-dfont/%.dfont: %.sfd export.py
	fontforge -script export.py $< $@

out/Ströbröd-bdf/%-10.bdf: %.sfd export.py
	fontforge -script export.py $< out/Ströbröd-bdf/$*.bdf

out/Ströbröd-psf/%.psf: out/Ströbröd-bdf/%-10.bdf
	mkdir -p $(dir $@) && \
	bdf2psf \
		--fb $< \
		/usr/share/bdf2psf/standard.equivalents \
		/usr/share/bdf2psf/ascii.set+/usr/share/bdf2psf/fontsets/Lat15.256+/usr/share/bdf2psf/linux.set \
		512 \
		$@

.PHONY: all ttf otf dfont bdf psf

