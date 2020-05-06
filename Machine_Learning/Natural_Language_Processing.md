# Summary of Tasks in NLP
## Tokenization
- Breaking down text to words and sentences
- We can use the nltk library in python to achieve this
```python
import nltk
from nltk.tokenize import word_tokenize, sent_tokenize
# word.tokenize tokenizes the text to individual words
# sent.tokenize tokenizes the text to individual sentences
sentence = 'This is my sentence. This is another sentence'
sents = sent_tokenzie(sentence)
# This gives ['This is my sentence.', 'This is another sentence']
words = word_tokenize(sentence)
# This gives ['This', 'is', 'my', 'sentence', '.', 'This', 'is', 'another', 'sentence']
# Punctuations are also tokenized into individual words
```

## Stopword Removal
- Words that doesn't add much meaning to the context (e.g. for grammatical structure)
- They can be removed berfore we start to extract meaning from the text
- We can get the list of stopwords from the nltk library
```python
from nltk.corpus import stopwords
from string import punctuation

customStopWords = set(stopwords.words('english') + list(punctuation))
```

## N-Grams
- Words that has a special meaning when grouped together (e.g. New York is a bigram)
```python
from nltk.collocations import *
bigram_measures = nltk.collocations.BigramAssocMeasures()
finder = BigramCollocationFinder.from_words(wordsWOStopwords)
sorted(finder.ngram_fd.items())
```

## Word Sense Disambiguation
- Identify the meaning of the word depending on the context
    - e.g. the word cool
```python
from nltk.wsd import lesk
sense = lesk(word_tokenize("Sing in a lower tone, along with the bass"), "bass", "bass")
# (Synset('bass.n.07'), u'the member of the lowest range of a family of musical instruments')
```
## Parts-of-speech
- Identify the role of a word within the text (noun, verb, adj etc.)
```python
ntlk.pos_tag(word_tokenize(text))
```
- Check the nltk documentation for details in formatting

## Stemming
- Words with different ending that means the same
    - close vs. closed
- Can use the lancaster stemming library
```python
from nltk.stem.lancaster import LancasterStemmer
st = LancasterStemmer()
stemmedWords = [st.stem(word) for word in word_tokenize(text)]
```

# Clustering
- Categorizing items into different groups
    - Items within the same group should be *similar* to each other
    - Items in different groups should be *dissimliar* to each other

## Term Frequency - Inverse Document Frequency
- *Term frequency* refers to the number of occurence of a word within a document
    - If we have a collection of articles with *n* distinct words, the term frequency of each word is the number of occurence of that word within one given article (or *document*)
    - A document a be represented by a tuple of *n* numbers, with each number corresponding to number of occurence of that word within the document. This is also referred to as the *term frequency representation*
        - Note that this presentation does not incorporate the order of the words in the initial document
- *Document frequency* refers to the number of documents that a word appears in

- The weight (or importance) of any given term can be calculated by (term frequency) / (doc frequency)

## K-means clustering
- Since a document can be represented by a tupe of *n* numbers, it can be seen as a point within a *n*-dimensional hypercube
    - This way a distance can be calculated between each points
- Depending on how many clusters you want to group the documents into (in this case *k*), you can initialize a set of *k* points acts like a centroid of the clusters
1. Each point is assigned to the nearest mean
1. A new mean can be calculated by averaging all the points within a cluster
1. Points are again, reassigned to the nearest mean
1. Rinse and repeat this process until the means no longer change (or after a certain iteration)