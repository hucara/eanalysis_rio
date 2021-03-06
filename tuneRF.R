require(caret)
require(doParallel)
require(randomForest)
# load data
# source("loadUsedTweets.R")

set.seed(1234)
cluster <- makeCluster(6)
registerDoParallel(cluster)

rf_ctrl <- trainControl(method="repeatedcv",
                        number=5,
                        repeats= 5,
                        summaryFunction = multiClassSummary,
                        classProbs = TRUE,
                        verboseIter = TRUE)


# Tune with tuneRF and decide which results are better (says mtry = 14)
bestmtry <- tuneRF(mtrain, train.y, stepFactor=1.5, improve=1e-5, ntreeTry=600, do.trace = TRUE, plot = TRUE)
grid <- expand.grid(mtry = c(14))

rf_tunedx <- train(mtrain, train.y, method = "rf", metric="Mean_Balanced_Accuracy", na.action = na.omit, ntree = 600, tuneGrid = grid, trControl = rf_ctrl)
rf_tuned <- train(mtrain, train.y, method = "rf", metric="Accuracy", na.action = na.omit, ntree = 600, trControl = rf_ctrl)

rf_pred <- predict(rf_tuned, mtest)
rf_pred_probs <- predict(rf_tuned2, mtest, type = "prob")

rf_conf <- confusionMatrix(rf_pred, test.y)
rf_mauc <- pROC::multiclass.roc(rf_pred, as.numeric(test.y))
rf_auc  <- pROC::auc(rf_pred, as.numeric(test.y))
rf_sum <- caret::multiClassSummary(data.frame(obs = test.y, pred=rf_pred), lev = as.numeric(test.y))

sum <- rf_sum
f1 <- (2*sum[["Mean_Sensitivity"]]*sum[["Mean_Pos_Pred_Value"]])/(sum[["Mean_Sensitivity"]]+sum[["Mean_Pos_Pred_Value"]])

# save data
# save(rf_tuned, file = "./models/rf_tuned.Rdata")
# save(rf_pred, file = "./models/rf_pred.Rdata")
# save(rf_pred_probs, file = "./models/rf_pred_probs.RData")
# save(rf_conf, file = "./models/rf_conf.Rdata")
# save(rf_mauc, file = "./models/rf_mauc.Rdata")
# save(rf_auc, file = "./models/rf_auc.Rdata")
# save(rf_sum, file = "./models/rf_sum.Rdata")

stopCluster(cluster)
