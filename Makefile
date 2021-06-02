version:
	#lerna version --conventional-commits
	lerna version --force-publish

publish:
	lerna publish --no-verify-access --force-publish

# 重新 link
init:
	@echo "将初始化开发环境!"
	@echo "注意,任何未在版本管理的代码将被删除! 回车继续!! C-c 取消!" 
	@read
	git clean  -fdx
	yarn install
	cd ./npm-modules/x-engine-vue/vuex && yarn build
	cd ./npm-modules/x-engine-vue/vue-router && yarn build
	cd ./npm-modules/x-engine-vue/ui && yarn lib
	cd ./npm-modules/x-engine-vue/lifecycle && yarn build
	

