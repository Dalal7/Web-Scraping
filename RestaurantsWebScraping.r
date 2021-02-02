library(rvest)
library(stringr)

zom <- read_html("https://www.tripadvisor.com/Restaurants-g298545-Al_Khobar_Eastern_Province.html")

titles <- zom %>% 
  html_nodes("._15_ydu6b") %>% 
  html_text()

rate <- zom %>% 
  html_nodes("._3KcXyP0F") %>% 
  html_attr('title')

rate <- str_replace(rate,"of 5 bubbles","")

type <- zom %>% 
  html_nodes(".MIajtJFg._1cBs8huC._3d9EnJpt > span:nth-child(1)") %>% 
  html_text()

reviews <- zom %>% 
  html_nodes("._3bvktyA3") %>% 
  html_text()


reviews <- str_replace(reviews,'”“',"\n ")
reviews <- str_replace_all(reviews,'“',"")
reviews <- str_replace_all(reviews,'”',"")

restaurants <- as.data.frame(cbind(titles, rate, type, reviews))
View(restaurants)

write.csv(restaurants,"C:\\myscripts\\KhobarRestaurants.csv")
