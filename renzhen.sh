#!/bin/bash
if [ `top -n 1 -b | grep -c renzhen.sh` -gt 3 ]
then
top -n 1 -b | grep -c renzhen.sh
echo 脚本已经运行
exit 1
else
while getopts ":p:d:k:" opt  
do  
    case $opt in  
        p)  
        echo "参数ip的值$OPTARG"  
         ip=$OPTARG
        ;;  
        d)  
        echo "参数id的值$OPTARG"  
	     id=$OPTARG
        ;;  
        k)  
        echo "参数pasd的值$OPTARG"  
	    key=$OPTARG
        ;;  
        ?)  
        echo "未知参数"  
        exit 1;;  
    esac  
done 
while true
do
funRenzhen(){
#天翼认证
curl -d "wlanuserip=$ip&wlanacname=hhzyxx&chal_id=&chal_vector=&auth_type=PAP&seq_id=&req_id=&wlanacIp=183.56.21.173&ssid=&vlan=&mac=&message=&bank_acct=&isCookies=&version=0&authkey=hhzyxx&url=&usertime=0&listpasscode=0&listgetpass=0&getpasstype=0&randstr=&domain=HHZYXX&isRadiusProxy=false&usertype=0&isHaveNotice=0&times=12&weizhi=0&smsid=0&freeuser=&freepasswd=&listwxauth=0&templatetype=1&tname=5&logintype=0&act=&is189=true&terminalType=&useridtemp=$id&userid=$id&passwd=$key" http://219.136.125.139/portalAuthAction.do
}
if_funRenzhen(){
while (![ funRenzhen >/dev/null ]) #判断天翼数据库打开没
do
echo 天翼数据库没打开60s后重试
sleep 60
done
echo 天翼数据库已打开
}
ruijie(){
state=true
while($state)
do
if /bin/ping -c 1 172.16.254.250 >/dev/null #判断有没有锐捷认证成功
then
funRenzhen 
echo "ip的值$ip key的值$key id的值$id"
echo 锐捷已认证!若提示帐号错误请检查IP帐号密码有无错误
state=false
else
sleep 15
echo 锐捷没认证,脚本重试中..
fi
done
}
time(){      
mm=`date '+%M'`
if [ $mm -gt 15 ]      #分钟重定向
then
echo 分钟重定向到整点-15分...防止6:59执行判断
sleep  `expr 65 - $mm`m
fi
}
ruijie
hh=`date '+%H'`
while([ $hh -ge 7 ])   #判断有没有在7点之后
do
if /bin/ping -c 1 114.114.114.114 >/dev/null
then
echo 天翼认证成功!
time
echo 网络正常!休眠一小时后重新判断
sleep 3600
else
if_funRenzhen
echo 网络连接错误!天翼认证失败!正在重连...15s间隔
funRenzhen >/dev/null
sleep 16
fi
done
echo 校园网没开放!一个小时后重试
sleep 3600
done 
fi

