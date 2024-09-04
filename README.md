# custom_mount_partition
> 须确保已使用 "多系统工具箱" 或类似工具进行分区

```
模块路径/data/adb/modules
    └── /custom_mount_partition
      ├── custommount        <--- 自定义的脚本存放目录，请务必存放于该目录，否则模块更新后将遗失
      │ ├── ...
      │ └── ...
      ├── conf               <--- 模块配置文件
      ├── custom_mount.sh    <--- 自定义挂载
      ├── custom_umount.sh   <--- 自定义挂载的卸载
      ├── function.sh        <--- 模块函数
      ├── init.sh            <--- 解压执行，作为非模块的使用方式
      ├── mount.sh           <--- 挂载时执行
      ├── module.prop        <--- 模块元数据
      ├── umount.sh          <--- 卸载时执行
      └── *.log              <--- 日志文件
```

## 为什么会有这个模块
- 将主要文件存放在第二分区，免于备份
- 用于在多系统中共享数据

## 模块特性
- 提供 `conf` 文件用于配置
- 自适应不同系统对 `/data/media/0/` 目录下文件夹的挂载
- 自定义挂载支持
- 多用户支持（仅针对当前用户）
- 同时支持Magisk、KernelSU、Apatch

## 使用方法
- 解压执行
1. 解压后执行 `init.sh` 文件进行初始化
2. 配置 `conf` 文件后执行 `mount.sh`

- 作为模块开机自动挂载
1. 通过模块管理器刷入
2. 配置模块路径中的 `conf` 文件后再次刷入（可选）
3. 重启


## 自定义挂载
自定义挂载请使用 `custom_mount.sh` 文件，同时在 `custom_umount.sh` 配置相应卸载操作，若有额外脚本请放置于 `custommount` 目录，否则更新模块后将遗失。
