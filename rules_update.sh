#/bin/bash
echo -e "-------下载新版本规则文件-------"
cd /tmp
wget -O daily.txt https://raw.githubusercontent.com/koolproxy/merlin-koolproxy/master/koolproxy/koolproxy/data/rules/daily.txt
wget -O koolproxy.txt https://raw.githubusercontent.com/koolproxy/merlin-koolproxy/master/koolproxy/koolproxy/data/rules/koolproxy.txt
wget -O kp.dat https://raw.githubusercontent.com/koolproxy/merlin-koolproxy/master/koolproxy/koolproxy/data/rules/kp.dat
wget -O user.txt https://raw.githubusercontent.com/koolproxy/merlin-koolproxy/master/koolproxy/koolproxy/data/rules/user.txt
# 下载扩展规则合并
#wget -O user_tmp.txt https://gitee.com/hongh2/kpr_video_list/raw/master/kpr_video_list.txt
#wget -O daily_tmp.txt https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules/yhosts.txt
#cat user_tmp.txt >>user.txt
#cat daily_tmp.txt >>daily.txt
echo -e "-------移动到/root/koolproxy目录-------"
mv -f /tmp/daily.txt /root/koolproxy
mv -f /tmp/koolproxy.txt /root/koolproxy
mv -f /tmp/kp.dat /root/koolproxy
mv -f /tmp/user.txt /root/koolproxy
echo -e"-------获取规则更新时间-------"
cd /tmp
wget https://github.com/koolproxy/merlin-koolproxy/tree/master/koolproxy/koolproxy/data/rules
day=`grep datetime= rules |head -3|tail -1|awk -F" " '{ print $4 }'|awk -F"\"" '{ print $2 }'|awk -F"T" '{  print $1 }'`
time=`grep datetime= rules |head -3|tail -1|awk -F" " '{ print $4 }'|awk -F"\"" '{ print $2 }'|awk -F"T" '{  print $2 }'|awk -F: '{ print $1":"$2 }'`
date1=$day" "$time

#time1=`cat koolproxy.txt  | sed -n '3p'|awk '{print $3,$4}'`

#year=`echo $time1|cut -b 1-4`
#month=`echo $time1|cut -b 5-6`
#day=`echo $time1|cut -b 7-8`
#hour=`echo $time1|cut -b 9-10`
#min=`echo $time1|cut -b 11-12`

#date1=$year-$month-$day" "$hour":"$min
#date1=`date +%F" "%R`
echo -e "-------把规则更新日期写入koolproxy.txt文件-------"
cd /root/koolproxy
sed -i "3i\!x  -----update[video]: $date1" koolproxy.txt
sed -i "3i\!x  -----update[rules]: $date1" koolproxy.txt
echo -e "-------删除rules文件-------"
rm -f /tmp/rules

echo -e "-------上传到github-------"
cd /root/koolproxy
/usr/bin/git add .
/usr/bin/git commit -m "更新规则"
/usr/bin/git push origin master

