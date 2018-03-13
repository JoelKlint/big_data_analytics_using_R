library(googlevis)
M <- gvisMotionChart(Fruits,
                     idvar="Fruit",
                     timevar="Year")
plot(M)

bubble <- gvisBubbleChart(Fruits, 
                          idvar='Fruit',
                          xvar='Sales', 
                          yvar='Expenses',
                          colorvar='Year', 
                          sizevar='Profit')
plot(bubble)

poptable <- gvisTable(Population, option=list(page='enable'), 
                      formats=list(Population='####', '% of World Population'='#.##%'))
plot(poptable)

org = gvisOrgChart(Regions,
                   options=list(width=600, height=300, size='large', allowCollapse=TRUE))
plot(org)

library(ggvis)
mtcars %>% 
  ggvis(~wt, ~mpg, fill:='red', stroke:='black',
        size:= input_slider(10, 100, label='point size'),
        opacity:=input_slider(0, 1, label='opacity')) %>% 
  layer_points()

house <- read.csv('RealEstate.csv', header=TRUE)
head(house, 2)
house %>%
  ggvis(~Size, 
        ~Price, 
        fill:=input_select(
          choices = c('red', 'blue', 'green'),
          selected = 'red',
          label='Color'),
        size:=input_slider(1, 10),
        opacity:=input_slider(0, 1)
        ) %>% layer_points()

house %>%
  ggvis(~Status, 
        ~Bathrooms, 
        fill:=input_select(
          c('red', 'blue'),
          label='Fill Color')
        ) %>%
  layer_bars()

house %>%
  ggvis(~Size,
        ~Price,
        fill=~Status,
        size:=input_slider(10, 50, label='Point Size:'),
        opacity:=input_slider(0.1, 1, label = 'Opacity:')
        ) %>% 
  layer_points()

library(rCharts)
rPlot(mpg~wt | am+vs, data = mtcars, type = 'point', color = 'gear')

hair_eye <- as.data.frame(HairEyeColor)
p2 <- nPlot(Freq~Hair, 
            group = 'Eye',
            data = subset(hair_eye, Sex=='Female'),
            type = 'multiBarChart'
            )
p2$chart(color = c('brown', 'blue', '#594c26', 'green'))
p2
