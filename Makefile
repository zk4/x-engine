version:
	lerna version --conventional-commits

publish:
	lerna publish --no-verify-access --force-publish

# 重新 link
install:
	rm -rdf node_modules
	yarn install
