
library(dplyr)
#install.packages('rCharts')
library(rCharts)


df=read.csv('C:/Users/shery/Desktop/seoul_ IT/R_ex/example_2015_expenditure.csv')
str(df)
df1=df
head(df1)
colnames(df1)[6]='value'
df1['value']=round(df1['value']/1000)
df1
df2=df1
head(df2)
dim(df2)
sum1=df2 %>% group_by(소관명, 회계명) %>% summarise(sum(value))
sum1
sum2=df2 %>% group_by(회계명,분야명) %>% summarise(sum(value))
sum3=df2 %>% group_by(부문명, 회계명) %>% summarise(sum(value))
sum4=df2 %>% group_by(프로그램명, 회계명) %>% summarise(sum(value))

# sankey library needs 'source' 'target' 'value' as variable names
colnames(sum1)=c('source','target','value')
colnames(sum2)=c('source','target','value')
colnames(sum3)=c('source','target','value')
colnames(sum4)=c('source','target','value')


# 만든 객체를 하나로 합친다. 
sum1=as.data.frame(sum1)
sum2=as.data.frame(sum2)
sum3=as.data.frame(sum3)
sum4=as.data.frame(sum4)

df3=rbind(sum1,sum2,sum3,sum4)


## dplyr 속성을 파악 

#install.packages("devtools")
#install.packages("Rcpp")
library(devtools)
library(Rcpp)
#install_github('ramnathv/rCharts', force= TRUE)


library(rCharts)
# 사용할 라이브러리 지정 
# setLib, setTemplate는 라이브러리를 지정하는 rCharts 객체함수
sankeyPlot=rCharts$new() 
sankeyPlot$setLib('libraries/sankey')
sankeyPlot$setTemplate(script='libraries/sankey/layouts/chart.html')

head(df3)

df4 =df3[1:8,]
df4

library(networkD3)
nodes = data.frame('name' = 
                     c('A부서', 
                       '과학관련', 
                       '발전균형특별', 
                       '보험특별',
                       '사업특별',
                       '에너지및 자원',
                       '예금 특별',
                       '일반',
                       '과학관',
                       '과학관관련'))
links = as.data.frame(matrix(c(
  0, 1, 1, 
  0, 1, 2, 
  0, 2, 3, 
  0, 2, 4,
  0, 2, 5,
  0, 2, 60,
  0, 2, 10,
  1, 2, 1,
  1, 2, 2),
  byrow = TRUE, ncol = 3))
names(links) = c("source", "target", "value")
sankeyNetwork(Links = links, Nodes = nodes,
              Source = "source", Target = "target",
              Value = "value", NodeID = "name",
              fontSize= 12, nodeWidth = 13)

