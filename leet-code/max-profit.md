# Max Profit \(easy\)

### Question

Say you have an array for which the_i_thelement is the price of a given stock on day _i_.

If you were only permitted to complete at most one transaction \(i.e., buy one and sell one share of the stock\), design an algorithm to find the maximum profit.

Note that you cannot sell a stock before you buy one.

### Idea

* The point of the question is finding the difference between the day with the lowest price \(local min\) and the highest price \(local max\)

```cplusplus
int sellstock(vector<int> prices) {
    int profit = 0;
    int min = numeric_limits<int>::max();
    for (int i = 0; i < prices.size(); i++) {
        if (prices[i] < min) min = prices[i];
        else if (prices[i] - min > profit) profit = prices[i] - min;
    }
    return profit;
}
```



