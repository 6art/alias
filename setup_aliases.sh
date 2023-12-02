#!/bin/bash

# 显示 logo
echo -e "\e[32m"
cat << "EOF"
   ,---,        ,--,                                     
  '  .' \     ,--.'|     ,--,                            
 /  ;    '.   |  | :   ,--.'|                            
:  :       \  :  : '   |  |,                  .--.--.    
:  |   /\   \ |  ' |   `--'_      ,--.--.    /  /    '   
|  :  ' ;.   :'  | |   ,' ,'|    /       \  |  :  /`./   
|  |  ;/  \   \  | :   '  | |   .--.  .-. | |  :  ;_     
'  :  | \  \ ,'  : |__ |  | :    \__\/: . .  \  \    `.  
|  |  '  '--' |  | '.'|'  : |__  ," .--.; |   `----.   \ 
|  :  :       ;  :    ;|  | '.'|/  /  ,.  |  /  /`--'  / 
|  | ,'       |  ,   / ;  :    ;  :   .'   \'--'.     /  
`--''          ---`-'  |  ,   /|  ,     .-./  `--'---'   
                        ---`-'  `--`---'                  
EOF
echo -e "\e[0m"

# 添加一个新的别名函数
# 这个函数接受两个参数:别名和对应的命令
add_alias() {
    local alias_name=$1
    local command=$2

    # 检查是否已存在
    if ! grep -q "alias $alias_name=" /etc/bash.bashrc; then
        # 使用 echo 命令和重定向 >> 追加到文件末尾
        echo "alias $alias_name='$command'" >> /etc/bash.bashrc
        echo "source /etc/bash.bashrc" >> /etc/bash.bashrc
        echo "别名 '$alias_name' 已添加。你现在可以使用这个别名来执行你的命令了！"
    else
        echo "别名 '$alias_name' 已存在，无需重复添加。你可以直接使用这个别名来执行你的命令！"
    fi
}

# 显示所有别名及其对应的命令
show_aliases() {
    echo -e "序号\t别名\t命令"
    grep '^alias ' /etc/bash.bashrc | cat -n | while read line; do
        number=$(echo "$line" | awk '{print $1}')
        alias_name=$(echo "$line" | cut -d' ' -f2 | sed "s/alias //g" | sed "s/=.*//g")
        command=$(echo "$line" | cut -d"'" -f2)
        printf "%-5s %-10s %s\n" "$number" "$alias_name" "$command"
    done
    echo "按任意键返回主菜单..."
    read
}

# 显示菜单并获取用户的选择
while true; do
    echo "------------------------"
    echo "请选择一个操作："
    echo "1. 添加所有收藏脚本的别名"
    echo "2. 查看所有收藏脚本"
    echo "0. 退出脚本"
    echo "------------------------"
    read -p "请输入你的选择（1、2 或 0）：" choice

    # 根据用户的选择执行相应的操作
    case "$choice" in
        1)
            # 使用 add_alias 函数添加你的别名
            # 你可以根据需要添加更多别名
            # 调用格式:add_alias "别名" "命令"
            # 示例:添加别名 lion
            add_alias "lion" "curl -sS -O https://raw.githubusercontent.com/kejilion/sh/main/kejilion.sh && chmod +x kejilion.sh && ./kejilion.sh"

            # 重复上述模式以添加更多别名
            # 比如: add_alias "tiger" "your_command"

            # 重新加载以立即应用
            echo "source /etc/bash.bashrc" >> /etc/bash.bashrc
            ;;
        2)
            show_aliases
            ;;
        0)
            break
            ;;
        *)
            echo "无效的选择。"
            ;;
    esac
done
