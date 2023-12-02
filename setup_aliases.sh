#!/bin/bash

# 添加一个新的别名函数
# 这个函数接受两个参数：别名和对应的命令
add_alias() {
    local alias_name=$1
    local command=$2

    # 检查 .bashrc 文件中是否已经存在这个别名
    # grep -q 用于安静模式搜索，不输出到控制台
    if grep -q "alias $alias_name=" ~/.bashrc; then
        echo "别名 '$alias_name' 已存在，无需重复添加。"
    else
        # 如果别名不存在，则添加到 .bashrc
        echo "alias $alias_name='$command'" >> ~/.bashrc
        echo "别名 '$alias_name' 已添加。"
    fi
}

# 使用 add_alias 函数添加你的别名
# 你可以根据需要添加更多别名
# 调用格式：add_alias "别名" "命令"

# 示例：添加别名 lion
add_alias "lion" "curl -sS -O https://raw.githubusercontent.com/kejilion/sh/main/kejilion.sh && chmod +x kejilion.sh && ./kejilion.sh"

# 重复上述模式以添加更多别名
# 例如，添加别名 "tiger" 的示例命令：
# add_alias "tiger" "你的命令"

# 重新加载 .bashrc 以应用更改
# 注意：这只会影响当前的shell会话
# 新的shell会话（例如新开的终端）会自动获取更新
source ~/.bashrc

exec bash
