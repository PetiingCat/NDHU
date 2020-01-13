var a=[],str='',cnt=0;
function EchoTable(){
	str='<tr><th>%FileName%</th><th><a href="127.0.0.1:7000/%FileName%">Download</a></th></tr>';
	a[cnt]=str;
	cnt++;
}
function ShowTable(){
	let i;str='';
	for(i=0;i<cnt;i++){str+=a[i];}
	document.getElementById('id_tb').innerHTML=str;
}
function SortTable(){
}
function main(){
	EchoTable();
	ShowTable();
}
window.onload=main();