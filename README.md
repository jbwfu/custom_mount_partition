# custom_mount_partition
    本模块仅在 crDroid 系统得到测试，其他系统可能不可用
```
模块路径/data/adb/modules
  └── .
    ├── broadcast.sh    <--- 广播媒体文件
    ├── conf    <--- 模块配置文件
    ├── end.sh    <--- 扫尾工作
    ├── function.sh  <--- 模块函数
    ├── module.prop <--- 模块元数据
    ├── mount.sh    <--- 挂载时执行
    ├── umount.sh   <--- 临时卸载时执行
    └── log.txt       <--- 日志文件: 咕咕咕
```
- Magisk 20.4+
- 支持KernelSU

## 为什么会有这个模块
- 将主要文件存放在第二分区，刷机免备份，易迁移
- 用于在多系统中共享数据

## 模块特性
- 权限与挂载前路径权限一致
- chcon 基于原路径属性修改安全上下文
- 默认挂载位置基于`/mnt/runtime/full/emulated/0/`，挂载后普通软件可读写

## TODO
- 免重启解除挂载
- 适配MIUI系统

## 使用方法
1. 模块刷入后重启自动生效,默认仅挂载分区及 ex_sd 目录
2. 解压至任意有执行权限的目录（非/storage/emulated/0/）后以 root 权限执行 mount.sh

访问原始路径请使用 /data/media/0/

```
# 查看挂载状态
homeRootDir="/mnt/runtime/full/emulated/0/"
mount |grep $homeRootDir
```

## 自定义挂载
详见 conf 及 mount.sh 文件
