BEGIN{
	sym="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
	min=100000000;i=0
}
{ 
	pv[x++]=$1;
	if($1>max)max=$1;
	if($1<min)min=$1;
} 
END{
	step=(max-min)/62;
	if(step==0) step=1
	for(i=0;i<NR;i++) printf "%c", substr(sym, ((pv[i]-min)/step+0.5)-((pv[i]-min)/step+0.5)%1, 1)
} 
