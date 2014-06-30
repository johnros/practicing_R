ll <- with(Multilocation, reorder(Location, Adj))
print(dotplot(reorder(reorder(Grp, Adj), as.numeric(ll)) ~ Adj|ll, Multilocation,
              groups=Trt, type=c("p","a"), strip=FALSE, strip.left=TRUE, layout=c(1,9),
              auto.key=list(columns=4,lines=TRUE),
              scales = list(y=list(relation="free"))))
