df <- coef(lmList(Reaction ~ Days | Subject, sleepstudy))
fclow <- subset(df, `(Intercept)` < 251)
fchigh <- subset(df, `(Intercept)` > 251)
cc1 <- as.data.frame(coef(fm2)$Subject)
names(cc1) <- c("A", "B")
df <- cbind(df, cc1)
ff <- fixef(fm2)
with(df,
     print(xyplot(`(Intercept)` ~ Days, aspect = 1,
                  x1 = B, y1 = A,
                  panel = function(x, y, x1, y1, subscripts, ...) {
                    panel.grid(h = -1, v = -1)
                    x1 <- x1[subscripts]
                    y1 <- y1[subscripts]
                    larrows(x, y, x1, y1, type = "closed", length = 0.1,
                            angle = 15, ...)
                    lpoints(x, y,
                            pch = trellis.par.get("superpose.symbol")$pch[2],
                            col = trellis.par.get("superpose.symbol")$col[2])
                    lpoints(x1, y1,
                            pch = trellis.par.get("superpose.symbol")$pch[1],
                            col = trellis.par.get("superpose.symbol")$col[1])
                    lpoints(ff[2], ff[1], 
                            pch = trellis.par.get("superpose.symbol")$pch[3],
                            col = trellis.par.get("superpose.symbol")$col[3])
                    ltext(fclow[,2], fclow[,1], row.names(fclow),
                          adj = c(0.5, 1.7))
                    ltext(fchigh[,2], fchigh[,1], row.names(fchigh),
                          adj = c(0.5, -0.6))
                  },
                  key = list(space = "top", columns = 3,
                             text = list(c("Mixed model", "Within-group", "Population")),
                             points = list(col = trellis.par.get("superpose.symbol")$col[1:3],
                                           pch = trellis.par.get("superpose.symbol")$pch[1:3]))
     )))
