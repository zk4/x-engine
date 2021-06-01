version:
	#lerna version --conventional-commits
	lerna version --force-publish

publish:
	lerna publish --no-verify-access --force-publish

# 重新 link
install:
	rm -rdf node_modules
	rm -rdf npm-modules/*/node_modules
	rm -rdf ./microApps/*/node_modules
	# link npm modules in root for develop
	yarn install
	yarn workspace @zkty-team/x-engine-ui lib
