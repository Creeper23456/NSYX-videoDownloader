@echo off
goto config
:config
REM �ű�PigeonClub��������Ȩ���� https://club.cnklp.cn
REM �������л�������ʼ��FFMPEG��annie

set tmp="C:\tmp"
set output="C:\Users\Administrator\Desktop"
set runtime_tmp="C:\runtime_tmp"
set net_test_addr=www.baidu.com
set um_path="D:\CloudMusic"
set msg=wscript.exe "D:\RunTimePath\batch\msg.vbs"
set Version=beta3

::�趨AMVת��������

set amv_trans_arg=

goto network_check

:network_check
title ������ - ��Ƶ���ء�ת����
echo ���ڼ������������...
ping %net_test_addr% /n 2 >nul
if %errorlevel% == 1 (set err_rea=������ʧ�ܣ��޷���������������&&goto error)
%msg% ע�⣺ʹ����Ƶ���ع���ʱ��ɱ��������ܻᱨ������������Ρ�
cls
REM ��ʼִ��
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
title ��Ƶ���ء�ת���� - ���˵�
echo =====��ӭʹ����Ƶ����ת����=====
echo =======��ѡ������Ҫ�Ĺ���=======
echo ================================
echo ===1��������Ƶ��ת����MP3��ʽ===
echo ==2��������Ƶ�����浽·��������=
echo =3��ת����Ƶ�ļ���MP3�ɲ��Ÿ�ʽ=
echo ============0������=============
echo ================================
echo ������֧��bilibili���ſᣬ�����ջ�YouTube�ȳ���ƽ̨���ء�
set /p start_var=�������Ӧ������ţ�
if %start_var% == 1 (goto video2mp3)
::if %start_var% == 0 (goto about)
if %start_var% == 0 (%msg% ����BATCH�ű����س��򣬻���Annie������FFmpegʵ�֡��汾��:%Version%��Creeper23456������PigeonClub�������Ȩ���С� &&goto about)
if %start_var% == 3 (goto amvtrans)
if %start_var% == 2 (goto videodl) else (cls && echo �����˴������ţ� &&goto start_1)

:video2mp3
cls
del /q /s %tmp%\* >nul
title ������Ƶ...
echo �뱣֤����ĵ�ַ��https://��ͷ��
set /p download_url=����bv��av�ţ���bվ��Ƶ�������ַ����������и��ƣ���
annie -o %tmp% %download_url%
if %errorlevel% == 1 (set err_rea=��Ƶ�����ڡ���Ƶ�������������������⣡&&goto error)

cls
echo ��ת��ΪMP3...
title ��ת��ΪMP3...
dir /b /on %tmp%>%runtime_tmp%\list.txt
set /p trans_filename=<%runtime_tmp%\list.txt
ffmpeg -i "%tmp%\%trans_filename%" -f mp3 -vn "%output%\%trans_filename%.mp3"
if %errorlevel% == 1 (set err_rea=ת�������ȷ����ӵ��ִ�г����Ȩ�ޣ����ļ������Ƿ�������⣡&&goto error)
cls

color 0c
title ת����ɣ�
echo ========================================================
echo ת���Ѿ���ɣ�����������ص����˵���
echo ���棺�ڼ���֮ǰ���뽫�����ϵ��ļ��ƶ������¼���ʻ�U�̡�
echo ��������һ������ɾ����һ����ɵ�ת�������ء�
echo ========================================================
pause
del /q /s %tmp%\* >nul
goto start

pause

:videodl
cls
title ������Ƶ...
set download_dir=%output%
set /p download_url=����bv��av�ţ���bվ��Ƶ�������ַ����������и��ƣ���
set /p download_dir=���뱣���ļ���·����ֱ�ӻس�ȷ��Ĭ��Ϊ���棺
annie -o %download_dir% %download_url%
if %errorlevel% == 1 (set err_rea=��Ƶ�����ڡ���Ƶ�������������������⣡&&goto error)
cls
echo ������ɣ���������������ļ��С�
pause
explorer %download_dir%
exit

:about
title ����
cls
color f0
echo ����BATCH�ű����س��򣬻���Annie������FFmpegʵ�֡�
echo ��PigeonClub������Creeper23456��д��������https://club.cnklp.cn
echo ������������RunTimePath��������֧�֣��벻Ҫ�޸��������ע���
echo �ҵĸ�����վ��https://blog.cnklp.cn
echo �汾%Version%
echo ����ָ�����ִ�����²�����
echo update�����±�����
echo website���鿴���ǵĹٷ���վ
echo blog���鿴�ҵĸ��˲���
echo repo���鿴������Դ����(Gtihub)
echo back���������˵�
set /p about_var=������������Ĳ������س�ȷ�ϣ�
if %about_var% == update (goto update)
if %about_var% == website (start https://club.cnklp.cn)
if %about_var% == repo (start https://github.com/Creeper23456/NSYX-videoDownloader/)
if %about_var% == back (goto start)
if %about_var% == blog (start https://blog.cnklp.cn) else (goto about)

:error
cls
title ������!
echo �����ˣ�
echo ��ִ�г���ʱ��������һ������%err_rea%
pause
goto start

:um
::cls
title ���������֡�QQ���ֽ��ܽ���
echo ������֧������������NCM��QQ����MCG���ṷ����������KGM�ļ��Ľ�������롣
set /p um_path=�������������������ֻ�QQ���ֵ�����Ŀ¼��
rem echo �����Ƿ���Ҫת�뵽MP3���粻��Ҫ�������ʽ��������Ϊ��Ӧ�������ļ���
rem set /p um_mode=���������ļ������޷���MP3��¼�����������ţ�����YES��ȷ��ת��������س�������

::��ʼת��
::cls
echo ���ڽ��ܣ����Ժ�...
rem if %um_mode% == yes (set um_output=%tmp%)
um -o %output% -i %um_path%
if %errorlevel% == 1 (set err_rea=����ʧ�ܣ�������������������˼����㷨�������������˴��������Ŀ¼����������ԡ�&&goto error)
rem if %um_mode% == yes (goto um_ffmpeg)

cls
echo ������ɣ����ܵ��ļ��Ѿ���������档
pause

goto start

:um_ffmpeg
exit

:amvtrans
title AMVת����
cls
echo ע�⣺ת��֮ǰ��ȷ��MP3�Ƿ������Ƶ���Ź��ܡ�
echo ת����ʱ�ϳ����뱣�ֳ������С�
set /p amv_input=���뱻ת����Ƶ�ļ���·�����������ļ����˴��ڣ�
cls
echo ��ʼ��...
echo �����ļ��������ļ���...
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
title ����ת��...
ffmpeg %amv_trans_arg% %output%\%trans_filename%.avi

if %errorlevel% == 1 (set err_rea=ת��ʱ������һ�����󣡿�����Ƶ����֧�ֻ�·������&&goto error) 
echo �ɹ�����������ص����˵����ļ��ѱ����������档
pause
goto start

:update
%msg% ���������У�
goto about