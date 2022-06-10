SRC := inter
BUILD := $(SRC)/build/fonts/static
OUT := out

.PHONY:	clean

$(OUT):	$(SRC)
	mkdir -p $@

	cp $(BUILD)/Inter-Regular.otf $@
	cp $(BUILD)/Inter-Italic.otf $@
	cp $(BUILD)/Inter-Bold.otf $@
	cp $(BUILD)/Inter-BoldItalic.otf $@

$(SRC):	patch
	cd $(SRC) && $(MAKE) static_otf

patch:	$(wildcard patches/*)
	cd $(SRC) && git checkout .
	$(foreach patch, $^, cd $(SRC) && git apply ../$(patch); cd ..;)

clean:
	cd $(SRC) && $(MAKE) clean
	rm -fr $(OUT)
