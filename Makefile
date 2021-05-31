version:
	#lerna version --conventional-commits
	lerna version --force-publish

publish:
	lerna publish --no-verify-access --force-publish

# 重新 link
# help: https://zhuanlan.zhihu.com/p/71385053
init:
	@echo "将初始化开发环境!"
	@echo "注意,任何未在版本管理的代码将被删除!"
	git clean -fdx
	lerna clean               # 清理所有的node_modules
	rm -rdf node_modules
	# yarn workspaces run clean # 执行所有package的clean操作
	yarn install              # 等价于 lerna bootstrap --npm-client yarn --use-workspaces
