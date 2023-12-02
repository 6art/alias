#!/bin/bash

# 显示 Logo
echo -e "\e[32m"
cat << "EOF"
您的 ASCII 艺术 Logo
EOF
echo -e "\e[0m"

# 预设的默认别名
# 这里你可以添加你常用的别名和对应的命令
default_aliases=(
    "ll='ls -alF'"
    "la='ls -A'"
    "l='ls -CF'"
    "lion='curl -sS -O https://raw.githubusercontent.com/kejilion/sh/main/kejilion.sh && chmod +x kejilion.sh && ./kejilion.sh'"
    # 更多别名...
)

# 检查并添加默认别名
initialize_aliases() {
    local alias_file="$HOME/.bash_aliases"
    # 检查别名文件是否存在，如果不存在则创建
    [[ ! -f "$alias_file" ]] && touch "$alias_file"

    # 添加默认别名
    for alias in "${default_aliases[@]}"; do
        local alias_name=${alias%%=*}
        # 检查别名是否已存在
        if ! grep -q "alias $alias_name=" "$alias_file"; then
            echo "$alias" >> "$alias_file"
            echo "添加默认别名：$alias_name"
        fi
    done
}

# 添加新别名
add_alias() {
    local alias_name="$1"
    local alias_command="$2"
    local alias_file="$HOME/.bash_aliases"

    if grep -q "alias $alias_name=" "$alias_file"; then
        echo "别名 $alias_name 已存在。"
    else
        echo "alias $alias_name='$alias_command'" >> "$alias_file"
        echo "别名 $alias_name 添加成功。"
    fi
}

# 显示所有别名
show_aliases() {
    local alias_file="$HOME/.bash_aliases"
    echo "已定义的别名："
    cat "$alias_file"
}

# 删除别名
remove_alias() {
    local alias_name="$1"
    local alias_file="$HOME/.bash_aliases"

    sed -i "/alias $alias_name=/d" "$alias_file"
    echo "别名 $alias_name 已移除。"
}

# 编辑别名
edit_alias() {
    local alias_name="$1"
    local new_command="$2"
    local alias_file="$HOME/.bash_aliases"

    remove_alias "$alias_name"
    add_alias "$alias_name" "$new_command"
}

# 初始化别名（如果是首次运行脚本）
initialize_aliases

# 菜单系统
while true; do
    echo "1. 添加新别名"
    echo "2. 显示所有别名"
    echo "3. 删除别名"
    echo "4. 编辑别名"
    echo "5. 退出"
    read -p "请输入您的选择 [1-5]: " choice

    case $choice in
        1)
            read -p "请输入别名名称: " alias_name
            read -p "请输入命令: " alias_command
            add_alias "$alias_name" "$alias_command"
            ;;
        2)
            show_aliases
            ;;
        3)
            read -p "请输入要删除的别名名称: " alias_name
            remove_alias "$alias_name"
            ;;
        4)
            read -p "请输入要编辑的别名名称: " alias_name
            read -p "请输入新的命令: " new_command
            edit_alias "$alias_name" "$new_command"
            ;;
        5)
            break
            ;;
        *)
            echo "无效的选择，请重新输入。"
            ;;
    esac
done

echo "脚本已退出。祝您有美好的一天！"
