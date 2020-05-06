# Two Sum (easy)

Given an array of integers, return indices of the two numbers such that they add up to a specific target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

```
Given nums = [2, 7, 11, 15], target = 9,

Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1].
```
## Solution
- Create a hashtable with target - nums[i] as key and the index as the value
    - Tells you what value the number of the current index needs in order to reach the target value
- Lookback while inserting numbers into the hashtable
```cpp
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        unordered_map<int, int> hash;
        vector<int> results;
        for(int i = 0; i < nums.size(); i++) {
            if (hash.find(nums[i]) != hash.end()) {
                results.push_back(hash[nums[i]]);
                results.push_back(i);
                break;
            }
            hash[target - nums[i]] = i;
        }
        return results;
    }
};
```