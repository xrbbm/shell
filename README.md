<h1>自动认证天翼脚本 shell</h1><br>
这个脚本的锐捷判断IP需要找到本校锐捷的路由器或者交换机<br>
（IP需要满足锐捷认证前ping不通,锐捷认证后天翼认证前ping的通)<br>
我这个脚本只是提供一个思路,希望大神可以改进.<br>
<br>
如果是老毛子固件或者路由器带curl的可以参考我设置的配置(老毛子设置:自定义设置-脚本-在WAN上行/下行启动后执行)<br>
我的脚本是放在certification目录下面,记得添加执行权限.<br>
$3是IPv4的地址,按住我的配置可以由脚本获取ip.<br>
 
<pre>
<code>
#天翼认证 -p [学校分配的ip} -d [登录网站的帐号不用域名] -k [密码] <br>
logger -t "【天翼认证】" "脚本开始执行" <br>
if [ `top -n 1 -b | grep -c renzhen.sh` -le 1 ] <br>
then <br>
/etc/storage/certification/renzhen.sh -p $3 -d [登录网站的帐号] -k [密码] & <br>
logger -t "【天翼认证】" "脚本挂入后台" <br>
else <br>
logger -t "【天翼认证】" "脚本已运行!" <br>
fi <br>
</code>
</pre>

<h2>自动认证脚本无后台版<h2>
<p>注意:需要老毛子固件<br>
路由器web管理设置:自定义设置-脚本-在WAN上行/下行启动后执行<br>
复制下面的代码块到设置里面保存就好<br>
<pre>
<code>
id=XX
key=XX
funRenzhen(){      #天翼认证
curl -d "wlanuserip=$3&wlanacname=hhzyxx&chal_id=&chal_vector=&auth_type=PAP&seq_id=&req_id=&wlanacIp=183.56.21.173&ssid=&vlan=&mac=&message=&bank_acct=&isCookies=&version=0&authkey=hhzyxx&url=&usertime=0&listpasscode=0&listgetpass=0&getpasstype=0&randstr=&domain=HHZYXX&isRadiusProxy=false&usertype=0&isHaveNotice=0&times=12&weizhi=0&smsid=0&freeuser=&freepasswd=&listwxauth=0&templatetype=1&tname=5&logintype=0&act=&is189=true&terminalType=&useridtemp=$id&userid=$id&passwd=$key" http://219.136.125.139/portalAuthAction.do
}
while ([ /bin/ping -c 1 114.114.114.114 >/dev/null ])
do
logger -t "【天翼认证】" "脚本执行失败!15s后重新执行"
funRenzhen >/dev/null
sleep 15
doen
logger -t "【天翼认证】" "脚本执行成功!"
</code>
</pre>
</p>
