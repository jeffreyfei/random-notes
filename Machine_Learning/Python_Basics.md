# Definitions

## Regression
- Continious values
- price = A * width + B * length
## Classification
- Discrete values
- Small, medium, large etc.
- True, False
## Overfitting
- Describes when the model fits the training data too well which causes high discrepancies between the result produced by the training data and actual data
- Developer can set the **Regularization hyperparameter** to determine how much the algorithm precisely fit every corner case of the training data
- **Cross validation** can also be used to improve performance
    - Specifically k-fold cross validation. It is the idea of dividing the training data into n sets, and one set acts as the validation data while others are the training data. This process is repeated until every set has been used as the validation set. This can help tuning the hyperparameter

# Algorithms
## Naive Bayes
- Based on Baye's theorem
    - Likelyhood and probability
- Assumes every attribute has the same weight
- Assumes every attribute is independent from the others

## Logistics Regression
- Returns a binary value
- Weighs the relationship between each attributes and their contribution to the result

## Decision Tree
- A binary tree
- Each node contains a decision that allows us to go down a path based on the attribute value
- Require a lot of data