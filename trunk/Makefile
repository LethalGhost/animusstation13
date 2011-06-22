:tgstation.dmb tgstation.rsc

tgstation.dmb tgstation.rsc: tgstation.dme $(shell ./list_includes.sh) $(shell ./list_res.sh)
	./dreammaker.sh tgstation.dme

clean:
	rm -f tgstation.dmb tgstation.rsc
