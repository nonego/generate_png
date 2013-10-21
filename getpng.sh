code=`awk -f sencode.awk`
curl "http://chart.apis.google.com/chart?cht=lc&chs=70x32&chd=s:${code}&chf=bg,s,d4e3e5&chm=o,FF0000,0,7.0,5.0|o,FF0000,0,14.0,5.0&chg=100,50" 2>/dev/null
exit $?
