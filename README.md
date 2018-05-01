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
