.PHONY: install uninstall

install:
	git checkout counter/
	cp -r counter-original/src/. counter/src/
	cp vendor-secret/Env.elm counter/src
	npx elm-review --config preview counter/src --debug --fix-all

elm-json:
	elm-json install MartinSStewart/elm-nonempty-string

uninstall:
	cp vendor-open/Env.elm src/
	cp -r counter-original/src/. counter/src/