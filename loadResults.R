#SVM
load("./results_rio2016/svm_tuned.Rdata")
load("./results_rio2016/svm_conf.Rdata")
load("./results_rio2016/svm_mauc.Rdata")
load("./results_rio2016/svm_sum.Rdata")
sum <- svm_sum
svm_f1 <- (2*sum[["Mean_Sensitivity"]]*sum[["Mean_Pos_Pred_Value"]])/(sum[["Mean_Sensitivity"]]+sum[["Mean_Pos_Pred_Value"]])

#Random Forest
load("./results_rio2016/rf_tuned.Rdata")
load("./results_rio2016/rf_conf.Rdata")
load("./results_rio2016/rf_mauc.Rdata")
load("./results_rio2016/rf_sum.Rdata")
sum <- rf_sum
rf_f1 <- (2*sum[["Mean_Sensitivity"]]*sum[["Mean_Pos_Pred_Value"]])/(sum[["Mean_Sensitivity"]]+sum[["Mean_Pos_Pred_Value"]])

#XGB
load("./results_rio2016/xgb_tuned.Rdata")
load("./results_rio2016/xgb_conf.Rdata")
load("./results_rio2016/xgb_mauc.Rdata")
load("./results_rio2016/xgb_sum.Rdata")
sum <- xgb_sum
xgb_f1 <- (2*sum[["Mean_Sensitivity"]]*sum[["Mean_Pos_Pred_Value"]])/(sum[["Mean_Sensitivity"]]+sum[["Mean_Pos_Pred_Value"]])

#Naive Bayes
load("./results_rio2016/nb_tuned.Rdata")
load("./results_rio2016/nb_conf.Rdata")
load("./results_rio2016/nb_mauc.Rdata")
load("./results_rio2016/nb_sum.Rdata")
sum <- nb_sum
nb_f1 <- (2*sum[["Mean_Sensitivity"]]*sum[["Mean_Pos_Pred_Value"]])/(sum[["Mean_Sensitivity"]]+sum[["Mean_Pos_Pred_Value"]])

#Neural Net
load("./results_rio2016/nn_tuned.Rdata")
load("./results_rio2016/nn_conf.Rdata")
load("./results_rio2016/nn_mauc.Rdata")
load("./results_rio2016/nn_sum.Rdata")
sum <- nn_sum
nn_f1 <- (2*sum[["Mean_Sensitivity"]]*sum[["Mean_Pos_Pred_Value"]])/(sum[["Mean_Sensitivity"]]+sum[["Mean_Pos_Pred_Value"]])


maucs <- c(svm_mauc$auc[[1]], rf_mauc$auc[[1]], xgb_mauc$auc[[1]], nb_mauc$auc[[1]], nn_mauc$auc[[1]])
accs <- c(svm_sum[["Mean_Balanced_Accuracy"]], rf_sum[["Mean_Balanced_Accuracy"]], xgb_sum[["Mean_Balanced_Accuracy"]], nb_sum[["Mean_Balanced_Accuracy"]], nn_sum[["Mean_Balanced_Accuracy"]])
f1s <- c(svm_f1, rf_f1, xgb_f1, nb_f1, nn_f1)
datares <- data.frame(ACC = accs, AUC = maucs, FScore = f1s, row.names = c("SVM", "RF", "XGB", "NB", "NN"))
write.csv(data, "./results/results_table.csv")

