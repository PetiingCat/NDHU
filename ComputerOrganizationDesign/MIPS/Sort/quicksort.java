class Solution {
    public int findKthLargest(int[] nums, int k) {
        
        int pivot = partition(nums,0, nums.length - 1);
        k = nums.length - k;
        while(pivot != k) {
            if (pivot>k) {
                pivot = partition(nums, 0, pivot - 1);
            } else {
                pivot = partition(nums, pivot + 1, nums.length - 1);
            }
        }
        return nums[pivot];
    }
    
    
    private int partition(int[] nums, int start, int end) {
        if (start == end) {
            return start;
        }
        int r = (int)(Math.random() * (end - start + 1)) + start;
        swap(nums,r,end);
        int pivotValue = nums[end];
        int less = start - 1;
        for (int i = start; i < end; i++) {
            if (nums[i] < pivotValue) {
                swap(nums, i, ++less);
            }
        }
        swap(nums,end, ++less);
        return less;
    }
    
    
    private void swap(int[] nums, int i1, int i2) {
        int temp = nums[i1];
        nums[i1] = nums[i2];
        nums[i2] = temp;
    }
    
}