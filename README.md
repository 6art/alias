# 别名设置脚本

这个仓库包含一个Shell脚本,用于在Linux/Unix系统上设置命令行别名。

## 用法

1. 使用以下命令下载并执行脚本:

```bash
curl -sS https://raw.githubusercontent.com/[your_github_username]/[repo_name]/main/setup_aliases.sh | bash
```

2. 替换上述命令中的`[your_github_username]`和`[repo_name]`。  

3. 该脚本将检查您的`.bashrc`文件并添加任何新别名。已存在的别名不会重复添加。

4. 通过添加更多`add_alias`调用来插入新的别名。参见脚本中的示例。

## 脚本内容  

```bash  
#!/bin/bash

# 定义函数以添加别名  
function add_alias(){...}

# 添加示例别名
add_alias "lion" "command"

# 添加更多别名  
add_alias "alias2" "command2"
```

## 许可

该项目使用 MIT 许可。有关详细信息,请参阅 LICENSE 文件。

## 贡献  

欢迎通过拉取请求贡献代码或建议改进。

## 联系  

有任何问题或建议,请打开 issue 或联系我。

祝您使用愉快!
