version:
	#lerna version --conventional-commits
	lerna version --force-publish

publish:
	lerna publish --no-verify-access --force-publish

# 重新 link
install:
	lerna clean
	rm -rdf node_modules
	yarn install
