/**
 * 固定最後一個數值為基準值(Pivot)
 */ 
var swap = function(data, i, j){ 
    var tmp = data[i];
    data[i] = data[j];
    data[j] = tmp;
};

/**
 * 將比Pivot小的數值右移，比Pivot大的數值左移
 * 最後回傳Pivot的位置 
 */
var partition = function(data, left, right){
    var i = left - 1;
    for(var j = left; j < right; j++){
        if(data[j] < data[right]){   // data[right]為Pivot
            i++;                     // 計數有幾個比Pivot小的數值
            swap(data, i, j);
        }
    }
    swap(data, i+1, right);          // 將Pivot移到中間
    return i+1;
};

var quickSort = function(data, left, right){
    if(left < right){
        var pivotLocation = partition(data, left, right);
        quickSort(data, left, pivotLocation-1);
        quickSort(data, pivotLocation+1, right);
    }
};