var fg01=0,fg02=0, a=[],cnt=0,str1='',str2='',i;
	function doit(){
		if(fg01==0){
			id_n01.value='被按了';
			fg01=1;
		}else{
			id_n01.value='已新增表格';
			fg01=0;
		}
		cnt++;
		str1='<tr><th><a href="https:www.google.com.tw/">'+cnt+'</a></th><th></th></tr>';
		a.push(str1);
		id_n03.text=a.length;
		doit3();
	}
	function doit2(){
		if(fg02==0){
			id_n02.text='被按了';
			fg02=1;
		}else{
			id_n02.text='已刪除表格';
			fg02=0;
		}
		if(cnt>0){cnt--;a.pop();}else cnt=0;
		id_n03.text=a.length;
		doit3();
	}
	function doit3(){
		str1='';
		for(i=0;i<cnt;i++){
		str1+=a[i];}
		document.getElementById('id_tb').innerHTML=str1;
	}
	function doit4(){
		while(a.length!=0){a.pop();cnt--;}
		str='';
		id_n03.text=a.length;
		document.getElementById('id_tb').innerHTML=str;
	}
	function generateTable(){
		var str1='',str2='',i=0,cnt=0;
		for(i=0;i<2;i++){
			cnt=cnt+1;
			str1='<tr><th><a href="https:www.google.com.tw/">'+cnt+'</a></th><th></th></tr>';
			str2=str2+str1;
		}
		document.getElementById('id_tb').innerHTML=str2;
	}
	function main(){
		id_n03.text=a.length;
		//generateTable();
	}
	window.onload=main();