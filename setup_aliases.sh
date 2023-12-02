#!/bin/bash

# 显示 Logo
echo -e "\e[32m"
cat << "EOF"
Your ASCII Art Logo Here
EOF
echo -e "\e[0m"

# add_alias 函数：添加新别名
# 你可以修改这个函数来调整别名的存储位置或逻辑
add_alias() {
    local alias_name="$1"
    local alias_command="$2"
    local alias_file="$HOME/.bash_aliases"

    if grep -q "$alias_name" "$alias_file"; then
        echo "Alias $alias_name already exists."
    else
        echo "alias $alias_name='$alias_command'" >> "$alias_file"
        echo "Alias $alias_name added successfully."
    fi
}

# show_aliases 函数：显示所有别名
show_aliases() {
    local alias_file="$HOME/.bash_aliases"
    echo "Defined aliases:"
    cat "$alias_file"
}

# remove_alias 函数：删除别名
remove_alias() {
    local alias_name="$1"
    local alias_file="$HOME/.bash_aliases"

    # 使用 sed 命令删除别名
    sed -i "/$alias_name/d" "$alias_file"
    echo "Alias $alias_name removed."
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
    echo "1. Add Alias"
    echo "2. Show Aliases"
    echo "3. Remove Alias"
    echo "4. Edit Alias"
    echo "5. Exit"
    read -p "Enter your choice [1-5]: " choice

    case $choice in
        1)
            read -p "Enter alias name: " alias_name
            read -p "Enter command: " alias_command
            add_alias "$alias_name" "$alias_command"
            ;;
        2)
            show_aliases
            ;;
        3)
            read -p "Enter alias name to remove: " alias_name
            remove_alias "$alias_name"
            ;;
        4)
            read -p "Enter alias name to edit: " alias_name
            read -p "Enter new command: " new_command
            edit_alias "$alias_name" "$new_command"
            ;;
        5)
            break
            ;;
        *)
            echo "Invalid choice, please try again."
            ;;
    esac
done

# 退出消息
echo "Script exited. Have a nice day!"
