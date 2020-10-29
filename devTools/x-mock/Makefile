
install:
	npm link

publish: 
	find . -name .DS_Store -print0 | xargs -0 rm 
	git commit -am 'before publish' || echo ""
	npm version patch
	npm publish --access public
	git push
