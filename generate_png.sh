if [[ $# < 1 ]]; then
	echo "Usage: $0 nodeid"
fi

node=$1

dtbeg=`date +%Y%m%d -d "15 days ago"`
dtend=`date +%Y%m%d -d "1 days ago"`
dir=/dataAnlysis/qing.guojq/png/$dtend

mkdir $dir
echo "select * from table_${node}_result where day>='$dtbeg' order by day;" |mysql -u log_platform_dev -D database_log_stat_platform_result_data --password=loganalysis  > tmp

nf=`head -n 1 tmp | awk -F'\t' '{print NF}'`
echo $nf
for (( i=3; i <= $nf; ++i ));do
	field_name=` head -n 1 tmp | awk -F'\t' '{print $'$i'}'`
	while true;do
		sed '1d' tmp | awk -F'\t' '{print $'$i'}' | sh getpng.sh > $dir/${dtend}_${node}_$field_name.png
		result=$?
		if [ $result -ne 0 ];then
			echo "generate png failed: $node $field_name"
			sleep 1
		else
			echo "generate png ok: $node $field_name"
			break
		fi
	done
done
