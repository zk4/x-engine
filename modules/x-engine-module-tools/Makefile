.PHONY: h5 dev push push-to-pods mac x
dev:
	watchexec --exts ts x-cli model.ts 

h5:
	cd h5 && npm run dev


ts-dev:
	watchexec --exts ts ts-node ../x-engine-api-generator/src/model_parser.ts model.ts

server:
	kitty @ launch --title model.ts --keep-focus
	kitty @ send-text --match title:model.ts cd $$(pwd)  \\x0d make dev  \\x0d
	kitty @ launch --title h5 --keep-focus
	kitty @ send-text --match title:h5 cd $$(pwd)/h5  \\x0d npm run dev  \\x0d

x: server
	cd iOS && open *.xcworkspace || open *.xcodeproj

r: x
	./run.sh


publish: 
	find . -name .DS_Store -print0 | xargs -0 rm 
	git commit -am 'before publish' || echo "!! nothing changed!"
	npm version patch
	npm publish --access public
	git push
