SRC := inter
BUILD := $(SRC)/build/fonts/static-hinted
OUT := out

.PHONY:	clean

$(OUT):	$(SRC)
	mkdir -p $@

	cp $(BUILD)/Inter-Regular.ttf $@
	cp $(BUILD)/Inter-Italic.ttf $@
	cp $(BUILD)/Inter-Bold.ttf $@
	cp $(BUILD)/Inter-BoldItalic.ttf $@

$(SRC):	patch
	cd $(SRC) && $(MAKE) static

patch:	$(wildcard patches/*)
	cd $(SRC) && git checkout .
	$(foreach patch, $^, cd $(SRC) && git apply ../$(patch); cd ..;)

clean:
	cd $(SRC) && $(MAKE) clean
	rm -fr $(OUT)
