version:
	#lerna version --conventional-commits
	lerna version --force-publish

publish:
	lerna publish --no-verify-access --force-publish

# 重新 link
init:
	@echo "将初始化开发环境!"
	rm -rdf node_modules
	yarn install              # 等价于 lerna bootstrap --npm-client yarn --use-workspaces
	# yarn workspaces run clean # 执行所有package的clean操作
	cd ./npm-modules/vue/vuex && yarn build
	cd ./npm-modules/vue/vue-router && yarn build
	cd ./npm-modules/vue/ui && yarn lib
	cd ./npm-modules/vue/lifecycle && yarn build
	@echo "注意,任何未在版本管理的代码将被删除!"
	# git clean -fdx
	

