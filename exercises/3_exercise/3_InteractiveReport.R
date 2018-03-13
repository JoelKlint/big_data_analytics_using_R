# Exercise 2
library(googleVis)
clinic <- read.csv('exercises/SeoulClinicTransposed.csv', header=TRUE)
column <- gvisColumnChart(clinic,
                          xvar='Clinic',
                          options = list(
                            title = 'Seoul Clinics',
                            legend = 'top'
                          )
)
plot(column)

#Exercise 3
library(ggvis)
trees %>% 
  ggvis(~Girth, 
        ~Height,
        size=~Volume,
        fill:=input_select(c('orange', 'lime', 'turquoise'), label = 'Color')
        ) %>% 
  layer_points()
