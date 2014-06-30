print(xyplot(Reaction ~ Days | Subject, sleepstudy, aspect = "xy",
             layout = c(9,2), type = c("g", "p", "r"),
             coef.list = df[,3:4],
             panel = function(..., coef.list) {
               panel.xyplot(...)
               panel.abline(as.numeric(coef.list[packet.number(),]),
                            col.line = trellis.par.get("superpose.line")$col[2],
                            lty = trellis.par.get("superpose.line")$lty[2]
               )
               panel.abline(fixef(fm2),
                            col.line = trellis.par.get("superpose.line")$col[4],
                            lty = trellis.par.get("superpose.line")$lty[4]
               )
             },
             index.cond = function(x,y) coef(lm(y ~ x))[1],
             xlab = "Days of sleep deprivation",
             ylab = "Average reaction time (ms)",
             key = list(space = "top", columns = 3,
                        text = list(c("Within-subject", "Mixed model", "Population")),
                        lines = list(col = trellis.par.get("superpose.line")$col[c(2:1,4)],
                                     lty = trellis.par.get("superpose.line")$lty[c(2:1,4)]))))
