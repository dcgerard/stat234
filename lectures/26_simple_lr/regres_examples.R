data(elmhurst)
plot(elmhurst$family_income,elmhurst$gift_aid)
elm=lm(gift_aid~family_income,data=elmhurst)
summary(elm)
abline(elm,col="red")
plot(elmhurst$family_income,elm$residuals)
qqnorm(elm$residuals/sd(elm$residuals))
abline(0,1)
mfi=mean(elmhurst$family_income)
sdfi=sd(elmhurst$family_income)
mgi=mean(elmhurst$gift_aid)
sdgi=sd(elmhurst$gift_aid)
plot((elmhurst$family_income-mfi)/sdfi,(elmhurst$gift_aid-mgi)/sdgi)
abline(0,-1)
R=cor(elmhurst$family_income,elmhurst$gift_aid)
R
abline(0,R,col="red")

plot(husbands.wives$Ht_Husband,husbands.wives$Ht_Wife)
mm=lm(husbands.wives$Ht_Wife~husbands.wives$Ht_Husband)
abline(mm)
summary(mm)
cor(husbands.wives$Ht_Husband,husbands.wives$Ht_Wife)
cor(husbands.wives$Ht_Husband,husbands.wives$Ht_Wife)^2




plot(stopping$speed,stopping$dist)
slm=lm(dist~speed,data=stopping)
abline(slm)
plot(stopping$speed,slm$residuals)

plot(stopping$speed,sqrt(stopping$dist))
sslm=lm(sqrt(dist)~speed,data=stopping)
abline(sslm)
plot(stopping$speed,sslm$residuals)