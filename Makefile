ENABLE_PROXY ?= true                        # 默认关闭代理
PROXY_ADDR := http://10.10.1.81:2345z  # 代理服务器地址

# 自动导出代理环境变量（同时兼容大小写写法）
ifeq ($(ENABLE_PROXY), true)
export http_proxy = $(PROXY_ADDR)
export https_proxy = $(PROXY_ADDR)
export HTTP_PROXY = $(PROXY_ADDR)
export HTTPS_PROXY = $(PROXY_ADDR)

PACKAGE_DIR := $(CURDIR)/package

### service
SERVICE_NAME := gpt-oi-web

### frontend static resource name
FRONTEND := web

ifeq ($(ENV), test)
BUILD_STAGE := stage
else
BUILD_STAGE := prod
endif

BUILD_CMD := build

.PHONY: install-deps clean pack

### build step
clean:
	rm -rf $(PACKAGE_DIR)
	rm -rf $(CURDIR)/build_tmp
	@echo "clean success"

install-deps:
	npm install

pack:
	npm run ${BUILD_CMD}
	mkdir -p $(CURDIR)/build_tmp/
	mv $(CURDIR)/build $(CURDIR)/build_tmp/${FRONTEND}
	# 仓库中的nginx配置仅对容器生效，对虚拟机和物理机部署时，仍需要手动调整nginx配置
	cp -r $(CURDIR)/nginx/${ENV}/$(SERVICE_NAME) $(CURDIR)/build_tmp/nginx
	mkdir -p $(PACKAGE_DIR)
	mv $(CURDIR)/build_tmp $(PACKAGE_DIR)/$(SERVICE_NAME)
	rm -rf $(CURDIR)/build_tmp
	@echo "build success"
