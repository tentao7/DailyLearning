library(caret)
#idx=sample(1:150,size=50,replace = F)

idx<-createDataPartition(iris$Species, p=0.7, list=F)

iris_train<-iris[idx, ] #생성된 인덱스를 이용, 70%의 비율로 학습용 데이터 세트 추출
iris_test<-iris[-idx, ] #생성된 인덱스를 이용, 30%의 비율로 평가용 데이터 세트 추출

table(iris_test$Species) 
### 나이브 베이즈 기법 적용
library(e1071)
naive.result<-naiveBayes(iris_train, iris_train$Species,laplace=1) #나이브 베이즈 적합
naive.pred<-predict(naive.result, iris_test, type="class") #테스트 데이터 평가
table(naive.pred, iris_test$Species) #분류 결과 도출

confusionMatrix(naive.pred, iris_test$Species)


### 다항로지스틱 회귀 (0,1)
library(nnet) #다항 로지스틱 회귀를 사용하기 위한 nnet 패키지 로딩
multi.result<-multinom(Species~., iris_train) #훈련 데이터 통한 모형 적합
multi.pred<-predict(multi.result, iris_test) #테스트 데이터 이용한 평가
table(multi.pred, iris_test$Species) #분류 결과도출
confusionMatrix(multi.pred, iris_test$Species)

## 의사결정 트리 rpart
library(rpart) #의사결정트리 기법을 사용하기 위한 rpart 패키지 로딩
rpart.result<-rpart(Species~., iris_train) #훈련데이터 통한 모형 적합
rpart.result
rpart.pred<-predict(rpart.result, iris_test, type="class") #테스트 데이터 이용 평가
table(rpart.pred, iris_test$Species) #분류 결과도출

## 서포트 백터 머신 
library(kernlab)
model=ksvm(Species~.,data = iris_train,kernel='rbfdot')
result=predict(model, iris_test,type ='response')
svm.result=ksvm(Species~., iris_train, kernal='rbfdot') # 훈련 데이타 통한 모형 적합 
svm.pred=predict(svm.result, iris_test,type ='response')  #테스트 데이타 평가 
table(svm.pred,iris_test$Species) # 분류 결과 도출 

confusionMatrix(svm.pred, iris_test$Species)


# 6 랜덤포레스트 기법
library(randomForest)
rf.result = randomForest(Species~., iris_train, ntree=500) # 훈련 데이타 통한 모형 적합 
rf.pred =predict(svm.result, iris_test, type='response') # 테스트 데이터 이용 평가 
table(rf.pred, iris_test$Species)  # 분류결과 도출 
confusionMatrix(svm.pred,iris_test$Species)
