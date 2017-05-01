
#include<iostream>
#include<vector>
#include<stack>
#include<cstdlib>
#include<algorithm>
using namespace std;
 
/**把数组分为两部分，轴pivot左边的部分都小于轴右边的部分**/
template <typename Comparable>
int partition(vector<Comparable> &vec,int low,int high){
    Comparable pivot=vec[low];  //任选元素作为轴，这里选首元素
    while(low<high){
        while(low<high && vec[high]>=pivot)
            high--;
        vec[low]=vec[high];
        while(low<high && vec[low]<=pivot)
            low++;
        vec[high]=vec[low];
    }
    //此时low==high
    vec[low]=pivot;
    return low;
}
 
/**使用栈的非递归快速排序**/
template<typename Comparable>
void quicksort2(vector<Comparable> &vec,int low,int high){
    stack<int> st;
    if(low<high){
        int mid=partition(vec,low,high);
        if(low<mid-1){
            st.push(low);
            st.push(mid-1);
        }
        if(mid+1<high){
            st.push(mid+1);
            st.push(high);
        }
        //其实就是用栈保存每一个待排序子串的首尾元素下标，下一次while循环时取出这个范围，对这段子序列进行partition操作
        while(!st.empty()){
            int q=st.top();
            st.pop();
            int p=st.top();
            st.pop();
            mid=partition(vec,p,q);
            if(p<mid-1){
                st.push(p);
                st.push(mid-1);
            }
            if(mid+1<q){
                st.push(mid+1);
                st.push(q);
            }       
        }
    }
}
 
int main(){
    int len=1000000;
    vector<int> vec;
    for(int i=0;i<len;i++)
        vec.push_back(rand()); 
    clock_t t1=clock();
    quicksort1(vec,0,len-1);
    clock_t t2=clock();
    cout<<"recurcive  "<<1.0*(t2-t1)/CLOCKS_PER_SEC<<endl;
     
    //重新打乱顺序
    random_shuffle(vec.begin(),vec.end());
         
    t1=clock();
    quicksort2(vec,0,len-1);
    t2=clock();
    cout<<"none recurcive  "<<1.0*(t2-t1)/CLOCKS_PER_SEC<<endl;
     
    return 0;
}