library(Rmisc)

data(diamonds, package='ggplot2')
dt = Rmisc::summarySE(data=diamonds, measurevar = 'price', groupvar=c('cut', 'color')) 

library(ggplot2)
ggplot(data = dt, aes(x = cut, y = price,fill = color)) + 
  geom_bar(stat = 'identity', position = position_dodge()) +
  geom_errorbar(aes(ymin=price-se, ymax= price+se), width = 0.3, position = position_dodge(0.9))

for(n in 1:10)
  if(n != 5)
    print(n)
