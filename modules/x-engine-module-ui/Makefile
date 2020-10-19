.PHONY: h5 dev push push-to-pods mac x
push-to-pods:
	# https://github.com/azu/podspec-bump
	podspec-bump -w  
	git tag $$(podspec-bump --dump-version)
	git commit -am "prod(*): push to pods"
	git push --tags
	pod repo push x-engine-pods x-engine-module-*.podspec --use-libraries --sources='https://github.com/CocoaPods/Specs.git,https://github.com/zkty-team/x-engine-pods.git'  --allow-warnings

push:
	pod repo push x-engine-pods x-engine-module-xxxx.podspec --use-libraries   --allow-warnings

dev:
	#  brew install watchexec
	#  npm install @zk4/x-cli
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
