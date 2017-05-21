VARIANTS = Regular Bold

all: ttf otf dfont bdf psf

clean:
	rm -rf out/*

ttf: $(foreach V, $(VARIANTS), out/Ströbröd-ttf/Ströbröd-$(V).ttf)

otf: $(foreach V, $(VARIANTS), out/Ströbröd-otf/Ströbröd-$(V).otf)

dfont: $(foreach V, $(VARIANTS), out/Ströbröd-dfont/Ströbröd-$(V).dfont)

bdf: $(foreach V, $(VARIANTS), out/Ströbröd-bdf/Ströbröd-$(V)-10.bdf)

psf: bdf $(foreach V, $(VARIANTS), out/Ströbröd-psf/Ströbröd-$(V).psf)


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

