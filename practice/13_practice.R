#page 4
install.packages("randomForest")

#page 6
#additional codes
n <- which.min(rf$mse)
rf2 <- randomForest(medv~., data=Boston, subset=train,
                    ntree=n, importance=TRUE, na.action=na.omit)
importance(rf2)      

#page 8
install.packages("tree")

#page 12
library(ggplot2)
ggplot(iris, aes(x=Petal.Length, y=Petal.Width)) +
  geom_point(shape=19,size=2,aes(color=Species)) +
  facet_grid(cut(Sepal.Width,8)~cut(Sepal.Length,8)) +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
  theme_bw()

#page 13
#Plotting Error vs Number of Trees
plot(iris_rf, col=1:4, lty=c(1,1,1,1),
     main="Random Forest Classification for iris Data")
legend("topright", colnames(iris_rf$err.rate), col=1:4, lty=c(1,1,1,1),
       bty='n',  y.intersp=0.5)

#page 15
ggplot(iris, aes(Petal.Length,Petal.Width,color=cls)) +
  geom_point() + stat_ellipse() + theme_bw() +
  theme(legend.justification=c(1,0),legend.position=c(1,0))

#page 16
install.packages("party")
