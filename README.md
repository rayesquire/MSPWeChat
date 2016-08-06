# MSPWeChat
## 介绍
这是一个我个人仿写微信iOS客户端的项目。
因为最初的代码是我刚学习iOS开发3个月时所写，乱七八糟不忍直视。但至少还有那么点可利用的地方，所以我开始了浩浩荡荡的重写之路。
因为我技术太低，不会写接口，所以所有与网络打交道的数据都打算用本地的来替代。
出于学习的目的，会列出想要实现的功能列表，并对已完成的做出标记。
ps:已经被移除的文件都未删除，所以有很多不在project中的无用的文件，说不定会有参考价值

## 目标
1.微信聊天界面
2.聊天列表界面
3.朋友圈
4.个人相册
5.整体界面

## Diary
08/05 今天是我开始的第一天，修改了部分文件的命名与实现代码，完成了“我”以及它的衍生界面的大体改造。考虑到无论是朋友圈还是好友列表，都要用到大量的数据，下一步准备删掉之前的SQLite部分，以Realm为数据库来构建。
08/06 完成了Realm数据库的搭建，虽然一开始没什么需要存储的数据。随便写了几个联系人，完成了通讯录界面的代码重写。下一步则是联系人的详细资料界面，并且针对之前所有的UI界面，采用AutoLayout或是masonry重构。

