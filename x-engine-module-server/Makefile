push-to-pods:
	# https://github.com/azu/podspec-bump
	podspec-bump -w  
	git tag $$(podspec-bump --dump-version)
	git commit -am "prod(*): push to pods"
	git push --tags
	pod repo push x-engine-pods x-engine-module-*.podspec --use-libraries --sources='https://github.com/CocoaPods/Specs.git,https://github.com/zkty-team/x-engine-pods.git'  --allow-warnings

push:
	pod repo push x-engine-pods x-engine-module-server.podspec --use-libraries   --allow-warnings
