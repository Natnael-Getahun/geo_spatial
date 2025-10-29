library(sp)
library(gstat)

data("muse.all")
data = muse.all

sps <- SpatialPoints(data[, c("x", "y")], proj4string = CRS("+proj=utm +
                                                            zone=32"))
spst <- spTransform(sps, CRS("+proj=longlat +datum=WGS84"))
data[, c("long", "lat")] <- coordinates(spst)
cords=cbind(data$long, data$lat)
cord=cbind(data$dist.m, data$dist.m)
cord2=cbind(data$elev, data$elev)

library(spdep)
sep.dist <- as.matrix(dist(cords))
w_Ex <- exp(-sep.dist)
rs_Ex <- rowSums(w_Ex)
w_Ex <- apply(w_Ex, 2, function(q) q/rs_Ex)

Inv_w = as.matrix(1/dist(cords));diag(Inv_w)
rs_inv <- rowSums(Inv_w)
Inv_w <- apply(Inv_w, 2, function(q) q/rs_inv)