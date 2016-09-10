# Rio2016 pipeline
rm(list=ls())

# download, preprocess and saving
# source("downloadTweets_Rio2016.R")
# source("pipeline_balanced_rio2016.R")

# cleaning a bit
rm(list= ls())

# loading interesting objects again
message("Loading data...")
load("./mat/balanced_test_rio2016.Rdata")
load("./mat/balanced_train_rio2016.Rdata")
load("./mat/balanced_train_y_rio2016.Rdata")
load("./mat/balanced_test_y_rio2016.Rdata")
load("./mat/balanced_train_dtm_rio2016.Rdata")
load("./mat/balanced_test_dtm_rio2016.Rdata")

tweets <- read.csv("./data/tweets_Rio2016.csv", stringsAsFactors = FALSE)
tweets$class <- as.factor(tweets$class)
tweets$X <- NULL
cat("\nDim tweets: ", dim(tweets))
cat("\nDim mtrain: ", dim(mtrain))
cat("\nDim mtest: ", dim(mtest))


source("tuneRF.R")
save(rf_tuned, file = "./models/rf_tuned_rio2016.Rdata")
save(rf_pred, file = "./models/rf_pred_rio2016.Rdata")
save(rf_conf, file = "./models/rf_conf_rio2016.Rdata")
save(rf_mauc, file = "./models/rf_mauc_rio2016.Rdata")
save(rf_auc, file = "./models/rf_auc_rio2016.Rdata")
save(rf_sum, file = "./models/rf_sum_rio2016.Rdata")

source("tuneSVM.R")

message(" DONE! ")