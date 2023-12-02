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
    "lion=curl -sS -O https://raw.githubusercontent.com/kejilion/sh/main/kejilion.sh && chmod +x kejilion.sh && ./kejilion.sh"
    "tiger=your_command"
    # 你可以根据需要添加更多的别名
)

# add_alias 函数：添加新别名
# 你可以修改这个函数来调整别名的存储位置或逻辑
add_alias() {
    local alias_name="$1"
    local alias_command="$2"
    local alias_file="$HOME/.bash_aliases"

    if grep -q "$alias_name" "$alias_file"; then
        echo "别名 $alias_name 已存在。"
    else
        echo "alias $alias_name='$alias_command'" >> "$alias_file"
        echo "别名 $alias_name 添加成功。"
    fi
}

# show_aliases 函数：显示所有别名
show_aliases() {
    local alias_file="$HOME/.bash_aliases"
    echo "已定义的别名："
    cat "$alias_file"
}

# remove_alias 函数：删除别名
remove_alias() {
    local alias_name="$1"
    local alias_file="$HOME/.bash_aliases"

    # 使用 sed 命令删除别名
    sed -i "/$alias_name/d" "$alias_file"
    echo "别名 $alias_name 删除成功。"
}

# edit_alias 函数：编辑别名
edit_alias() {
    local alias_name="$1"
    local new_command="$2"
    local alias_file="$HOME/.bash_aliases"

    # 首先删除旧的别名，然后添加新的
    remove_alias "$alias_name"
    add_alias "$alias_name" "$new_command"
}

# 菜单系统
while true; do
    echo "1. 添加别名"
    echo "2. 查看别名"
    echo "3. 删除别名"
    echo "4. 编辑别名"
    echo "5. 退出脚本"
    read -p "请输入您的选择 [1-5]: " choice

    case $choice in
        1)
            read -p "请输入别名名称: " alias_name
            read -p "请输入对应的命令: " alias_command
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
            echo "无效的选择，请重试。"
            ;;
    esac
done

# 退出消息
echo "脚本已退出。祝您有美好的一天！"

# 检查是否是第一次运行脚本，如果是，就添加默认的别名
if [ ! -f ~/.bash_aliases ]; then
    for default_alias in "${default_aliases[@]}"; do
        # 使用 = 号分割别名和命令，并传递给 add_alias 函数
        IFS="=" read -r alias_name alias_command <<< "$default_alias"
        add_alias "$alias_name" "$alias_command"
    done

    # 重新加载 .bashrc 文件，使新添加的别名生效
    source ~/.bashrc

fi
