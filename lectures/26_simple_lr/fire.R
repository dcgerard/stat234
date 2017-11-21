fire.dat <- read.table(file="fire.dat")
names(fire.dat) <- c("obs","dist","damage")
attach(fire.dat)

plot(dist,damage,pch=16,
     xlab="Distance (mi.)",ylab="Damage ($000s)",
     main="Damage vs. Distance to Fire Station")

fire.lm <- lm(damage~dist)

plot(dist,fire.lm$res,
     xlab="Distance (mi.)",ylab="Residual",
     main="Residuals vs. Explanatory Variable",pch=16)
abline(h=0)

qqnorm(fire.lm$res,pch=16)

newx<-seq(0,7)
prd<-predict(fire.lm,newdata=data.frame(x=newx),interval = c("confidence"), 
             level = 0.90,type="mean")
abline(fire.lm)
aa=anova(fire.lm)
sig=sqrt(aa$`Mean Sq`[2])

nn=rnorm(1500,0,sig)
dim(nn)=c(15,100)

par(mfrow=c(2,2))
for (j in (1:4))
{
dist=fire.dat$dist
damage=dist*fire.lm$coefficients[2]+fire.lm$coefficients[1]+nn[,j]
nlm=lm(damage~dist)
print(nlm$coefficients)
plot(dist,damage,pch=16,xlab="Distance (mi.)",
     ylab="Damage ($1Ks)",xlim=c(0,7),ylim=c(8,40))
abline(nlm)
}
  
   
list
lines(newx,prd[,2],col="red",lty=2)
lines(newx,prd[,3],col="red",lty=2)
