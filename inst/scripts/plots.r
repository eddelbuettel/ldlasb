#!/usr/bin/r

library(ldlasb)

#pdf("release.pdf")
png("release.png", 800, 600)
demo(release, ask=FALSE)
dev.off()

#pdf("grow.pdf")
png("grow.png", 800, 600)
demo(grow, ask=FALSE)
dev.off()
