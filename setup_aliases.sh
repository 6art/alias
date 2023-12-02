#!/bin/bash

# 添加一个新的别名函数
# 这个函数接受两个参数:别名和对应的命令
add_alias() {
    local alias_name=$1
    local command=$2

    # 检查是否已存在
    if ! grep -q "alias $alias_name=" ~/.bashrc; then
        echo "alias $alias_name='$command'" >> ~/.bashrc
        echo "别名 '$alias_name' 已添加。"
    else
        echo "别名 '$alias_name' 已存在,无需重复添加。"
    fi
}

# 使用 add_alias 函数添加你的别名
# 你可以根据需要添加更多别名
# 调用格式:add_alias "别名" "命令"
# 示例:添加别名 lion
add_alias "lion" "curl -sS -O https://raw.githubusercontent.com/kejilion/sh/main/kejilion.sh && chmod +x kejilion.sh && ./kejilion.sh"

# 重复上述模式以添加更多别名
# 比如: add_alias "tiger" "your_command"

# 重新加载以立即应用
source ~/.bashrc
