@echo off
goto config
:config
REM 脚本PigeonClub技术部版权所有 https://club.cnklp.cn
REM 定义运行环境，初始化FFMPEG与annie

set tmp="C:\tmp"
set output="C:\Users\Administrator\Desktop"
set runtime_tmp="C:\runtime_tmp"
set net_test_addr=www.baidu.com
set um_path="D:\CloudMusic"
set msg=wscript.exe "D:\RunTimePath\batch\msg.vbs"
set Version=beta3

::设定AMV转换器参数

set amv_trans_arg=

goto network_check

:network_check
title 网络监测 - 视频下载、转换器
echo 正在检查网络连接性...
ping %net_test_addr% /n 2 >nul
if %errorlevel% == 1 (set err_rea=网络监测失败！无法连接至服务器。&&goto error)
%msg% 注意：使用视频下载功能时，杀毒软件可能会报毒，请添加信任。
cls
REM 开始执行
goto start

:start
md %tmp% >nul
md %runtime_tmp% >nul
cls
goto start_1
:start_1
set start_var=START
set about_var=START
color 0f
title 视频下载、转换器 - 主菜单
echo =====欢迎使用视频下载转换器=====
echo =======请选择你需要的功能=======
echo ================================
echo ===1、下载视频并转换成MP3格式===
echo ==2、下载视频并保存到路径或桌面=
echo =3、转换视频文件到MP3可播放格式=
echo ============0、关于=============
echo ================================
echo 本程序支持bilibili，优酷，爱奇艺或YouTube等常见平台下载。
set /p start_var=请输入对应功能序号：
if %start_var% == 1 (goto video2mp3)
::if %start_var% == 0 (goto about)
if %start_var% == 0 (%msg% 简易BATCH脚本下载程序，基于Annie程序与FFmpeg实现。版本号:%Version%，Creeper23456制作。PigeonClub技术组版权所有。 &&goto about)
if %start_var% == 3 (goto amvtrans)
if %start_var% == 2 (goto videodl) else (cls && echo 输入了错误的序号！ &&goto start_1)

:video2mp3
cls
del /q /s %tmp%\* >nul
title 下载视频...
echo 请保证输入的地址以https://开头。
set /p download_url=输入bv或av号，非b站视频请输入地址（在浏览器中复制）：
annie -o %tmp% %download_url%
if %errorlevel% == 1 (set err_rea=视频不存在、视频链接有误或网络出现问题！&&goto error)

cls
echo 正转换为MP3...
title 正转换为MP3...
dir /b /on %tmp%>%runtime_tmp%\list.txt
set /p trans_filename=<%runtime_tmp%\list.txt
ffmpeg -i "%tmp%\%trans_filename%" -f mp3 -vn "%output%\%trans_filename%.mp3"
if %errorlevel% == 1 (set err_rea=转码错误，请确认你拥有执行程序的权限，或文件本身是否存在问题！&&goto error)
cls

color 0c
title 转换完成！
echo ========================================================
echo 转换已经完成！按下任意键回到主菜单。
echo 警告：在继续之前，请将桌面上的文件移动到你的录音笔或U盘。
echo 继续到下一步将会删除上一步完成的转换与下载。
echo ========================================================
pause
del /q /s %tmp%\* >nul
goto start

pause

:videodl
cls
title 下载视频...
set download_dir=%output%
set /p download_url=输入bv或av号，非b站视频请输入地址（在浏览器中复制）：
set /p download_dir=输入保存文件的路径，直接回车确认默认为桌面：
annie -o %download_dir% %download_url%
if %errorlevel% == 1 (set err_rea=视频不存在、视频链接有误或网络出现问题！&&goto error)
cls
echo 下载完成，按任意键打开下载文件夹。
pause
explorer %download_dir%
exit

:about
title 关于
cls
color f0
echo 简易BATCH脚本下载程序，基于Annie程序与FFmpeg实现。
echo 由PigeonClub技术部Creeper23456编写，官网：https://club.cnklp.cn
echo 本程序依赖于RunTimePath自启程序支持，请不要修改启动项或注册表。
echo 我的个人网站：https://blog.cnklp.cn
echo 版本%Version%
echo 输入指令可以执行以下操作：
echo update：更新本程序
echo website：查看我们的官方网站
echo blog：查看我的个人博客
echo repo：查看本程序源代码(Gtihub)
echo back：返回主菜单
set /p about_var=键入你想继续的操作，回车确认：
if %about_var% == update (goto update)
if %about_var% == website (start https://club.cnklp.cn)
if %about_var% == repo (start https://github.com/Creeper23456/NSYX-videoDownloader/)
if %about_var% == back (goto start)
if %about_var% == blog (start https://blog.cnklp.cn) else (goto about)
goto about

:error
cls
title 出错了!
echo 出错了！
echo 在执行程序时，发现了一个错误：%err_rea%
pause
goto start

:um
::cls
title 网易云音乐、QQ音乐解密解码
echo 本程序支持网易云音乐NCM、QQ音乐MCG、酷狗、酷我音乐KGM文件的解密与解码。
set /p um_path=请输入或黏贴网易云音乐或QQ音乐的下载目录：
rem echo 请问是否需要转码到MP3？如不需要，无损格式将被解密为对应的无损文件，
rem set /p um_mode=部分无损文件可能无法被MP3或录音笔正常播放，输入YES以确认转换，否则回车继续。

::开始转换
::cls
echo 正在解密，请稍后...
rem if %um_mode% == yes (set um_output=%tmp%)
um -o %output% -i %um_path%
if %errorlevel% == 1 (set err_rea=解密失败！可能是音乐软件升级了加密算法，或者是输入了错误的下载目录，请检查后重试。&&goto error)
rem if %um_mode% == yes (goto um_ffmpeg)

cls
echo 解密完成！解密的文件已经存放在桌面。
pause

goto start

:um_ffmpeg
exit

:amvtrans
title AMV转换器
cls
echo 注意：转换之前请确认MP3是否存在视频播放功能。
echo 转换耗时较长，请保持程序运行。
set /p amv_input=输入被转换视频文件的路径，或拖入文件到此窗口：
cls
echo 初始化...
echo 复制文件到缓存文件夹...
copy %amv_input% %tmp%
dir /b /on %tmp%>%runtime_tmp%\list.txt
set /p trans_filename=<%runtime_tmp%\list.txt

set  amv_trans_arg=%amv_trans_arg% -y
set  amv_trans_arg=%amv_trans_arg% -hide_banner
set  amv_trans_arg=%amv_trans_arg% -threads auto
set  amv_trans_arg=%amv_trans_arg% -strict "experimental"
set  amv_trans_arg=%amv_trans_arg% -err_detect ignore_err
set  amv_trans_arg=%amv_trans_arg% -flags "-output_corrupt"
set  amv_trans_arg=%amv_trans_arg% -fflags "+discardcorrupt+autobsf"
set  amv_trans_arg=%amv_trans_arg% -flags2 "+ignorecrop"
set  amv_trans_arg=%amv_trans_arg% -i %tmp%\%trans_filename%
set  amv_trans_arg=%amv_trans_arg% -movflags "+faststart"
set  amv_trans_arg=%amv_trans_arg% -qscale:v 2
set amv_trans_arg=%amv_trans_arg% -bsf:v "mpeg4_unpack_bframes,remove_extra=freq=all"
set amv_trans_arg=%amv_trans_arg% -bsf:a "mp3decomp"
set amv_trans_arg=%amv_trans_arg% -start_at_zero
set amv_trans_arg=%amv_trans_arg% -avoid_negative_ts        "make_zero"
set  amv_trans_arg=%amv_trans_arg% -vf "fifo
set  amv_trans_arg=%amv_trans_arg%,setpts=PTS-STARTPTS
set  amv_trans_arg=%amv_trans_arg%,yadif=0:-1:0
set  amv_trans_arg=%amv_trans_arg%,dejudder=cycle=20
set  amv_trans_arg=%amv_trans_arg%,mpdecimate
set  amv_trans_arg=%amv_trans_arg%,crop=trunc(in_w/2)*2:trunc(in_h/2)*2
set  amv_trans_arg=%amv_trans_arg%,scale=208:176
set  amv_trans_arg=%amv_trans_arg%,eq=gamma=1.2:saturation=1.1
set  amv_trans_arg=%amv_trans_arg%,hqdn3d"
set  amv_trans_arg=%amv_trans_arg% -pix_fmt yuv420p

cls
title 正在转换...
ffmpeg %amv_trans_arg% %output%\%trans_filename%.avi

if %errorlevel% == 1 (set err_rea=转换时出现了一个错误！可能视频不受支持或路径错误&&goto error) 
echo 成功！按任意键回到主菜单，文件已被保存在桌面。
pause
goto start

:update
%msg% 功能完善中！
goto about
