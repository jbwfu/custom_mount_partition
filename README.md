# custom_mount_partition
> 本模块仅在类原生系统中测试通过，其他系统未测试
> 须确保已使用 "多系统工具箱" 或类似工具进行分区

```
模块路径/data/adb/modules
    └── /custom_mount_partition
      ├── custommount        <--- 自定义的脚本目录，请务必存放于该目录，否则更新可能丢失
      ├── conf               <--- 模块配置文件
      ├── function.sh        <--- 模块函数
      ├── mount.sh           <--- 挂载时执行
      ├── umount.sh          <--- 卸载时执行
      ├── custom_mount.sh    <--- 自定义挂载
      ├── custom_umount.sh   <--- 自定义挂载的卸载
      ├── module.prop        <--- 模块元数据
      └── *.log            <--- 日志文件
```

## 为什么会有这个模块
- 将主要文件存放在第二分区，免于备份
- 用于在多系统中共享数据

## 模块特性
- `conf` 配置可使在 `/sdcard` 的挂载供非root软件读写
- 自适应不同系统对 `/data/media/0/` 目录下文件夹的挂载
- 支持自定义挂载
- 多用户支持（仅为当前用户挂载）

## 使用方法
~~① 解压执行~~ 暂不支持
② 作为模块开机自动挂载（请确保模块能够正常工作，更新模块须同步个人配置至模块后刷入）
  - Magisk 20.4+
  - 支持 KernelSU
  - 支持 Apatch

## 自定义挂载
挂载至 `/sdcard` 可使用 `conf` 文件进行简单配置

复杂的自定义挂载请使用 `custom_mount.sh` 文件，同时在 `custom_umount.sh` 配置相应卸载操作
