# 版本更新信息

### v3.0.0 (24/08/25)
- 文件结构变更
- 挂载逻辑优化，支持更多的ROM
- 模块更新支持
- ..


### v2.7.0 (23/08/04)
- 发现MIUI系统下模块失效，仅修改模块说明
- 版号错误，将错就错了
- ..


### v2.0.6 (23/08/02)
- 修复chcon参数读取失败的问题
- 更改配置加载方式，修复注释无效问题
- ..


### v2.0.5 (23/07/21)
- 修复挂载后媒体内容不加载的问题，该方法仍来自高雄佬（酷安@落叶凄凉TEL）
- 变更挂载配置方式
- 已知完全解除挂载必须禁用模块后重启
- ..


### v2.0.4 (23/07/20)
- 修复挂载后内容不可见的问题
- ..


### v2.0.3 (23/07/16)
- 优化卸载顺序
- ..


### v2.0.2 (23/07/15)
- 修复配置文件解析错误的问题，挂载配置的分隔符由`;`变更为`,`
- ..


### v2.0.1 (23/07/12)
- 配置文件中挂载配置改为数组，避免注释失效
- ..


### v2.0.0 (23/07/12)
- 更改挂载路径为`/mnt/runtime/full/emulated/0`，成功实现普通软件可读写
- 完善模块，配置独立
- chcon基于挂载前路径修改安全上下文
- 文件夹权限基于挂载前路径的权限
- ..


### v1.5.0 (23/07/10)
- 更改挂载路径为`/storage/emulated/0`，挂载后路径可读不可写
- 调整权限
- ..


### v1.0.0 (23/07/)
- 基于高雄佬（酷安@落叶凄凉TEL）的模块简单修改
- 挂载后普通软件无法读取
- ..