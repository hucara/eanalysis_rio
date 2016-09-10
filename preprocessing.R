# Preprocessing

#' Cleans a list of texts
#' removes the elements: @, RT, #, urls, punctuation
#' Transforms to lower case
#' Removes emoji codes
#' 
#' \code{cleanTexts} returns a list with the clean texts
#' 
#' @param array with texts to be processed
#' @return list with the clean texts for each tweet
#' @example cleanTexts(texts)
#' @export
cleanTexts <- function(texts, keepHashtags = TRUE, removeEmojis = TRUE)
{
  if(require(plyr) && require(stringr) && require(tm))
  {
    cleaned <- aaply(.data = texts, .margins = 1, .progress = progress_text(char = "."), .fun = function(i)
    {
      # remove emojis
      if(removeEmojis)
      {
        # Remove all emoji codes
        i <- str_replace_all(i, '<U\\+\\w+?>', '')
        i <- str_replace_all(i, '<ed>', '')
        i <- iconv(i, "latin1", "ASCII", sub="")
      }
      
      # remove usual @ conventions
      i <- str_replace_all(i, '(@[[:alnum:]_]*)', '')
      # remove @ hashtags
      if(keepHashtags)
      {
        i <- str_replace_all(i, '(#)', '')
      }
      else
      {
        i <- str_replace_all(i, '#\\S+', '')
      }
      # remove usual RT: conventions
      i <- str_replace_all(i, '(RT : [[:alnum:]_]*)', '')
      # remove the urls
      i <- str_replace_all(i, 'http[^[:blank:]]+', '')
      # remove more strange charagers
      i <- str_replace_all(i, '(RT|via)((?:\\b\\W*@\\w+)+)', '')
      # remove punctuation symbols
      i <- str_replace_all(i, '(?!\')[[:punct:]]', '')
      i <- removePunctuation(i)
      # lower case
      i <- tolower(i)
      
      # remove numbers
      i <- str_replace_all(i, '[0-9\\-]', ' ')
      i <- removeNumbers(i)
      
      # fix consecutive spaces
      i <- str_replace_all(i, '\\s+', ' ')
    })
  }
  
  return(cleaned)
}


removeEmojisUnicodes <- function(texts)
{
  if(require(plyr) && require(stringr))
  {
    texts <- aaply(.data = texts, .margins = 1, .progress = progress_text(char = "."), .fun = function(i)
    {
      # Remove all emoji codes
      i <- str_replace_all(i, '<U\\+\\w+?>', '')
      i <- str_replace_all(i, '<ed>', '')
      i <- iconv(i, "latin1", "ASCII", sub="")
    })
  }
  
  return(texts)
}

unTokenizeList <- function(texts)
{
  if(require(plyr) && require(stringr) && length(texts)>0)
  {
    sentences <- ldply(.data = texts, .progress = progress_text(char = "."), .fun = function(i)
    {
      i <- paste(i, collapse=' ')
    })
    
    return(sentences)
  }
}

# require(quanteda)
# # tokenize text
# tk <- tokenize(tweets$chtext, what = "word", removePunct = TRUE, removeNumbers = TRUE, removeSymbols = TRUE, removeTwitter = TRUE, removeHyphens = TRUE, removeURL = TRUE)
# # remove stopwords
# tk <- removeFeatures(tk, sw)
# # stemming
# tk <- wordstem(tk, language="english")
