library(plotly)
library(MASS)

music = read.csv("music-sub.txt", row.names=1)
music.numeric= scale(music[,4:7])
d=dist(music.numeric)
res=isoMDS(d,k=2)
coords=res$points

coordsMDS=as.data.frame(coords)
coordsMDS$name=rownames(coordsMDS)
coordsMDS$Artist=music$Artist

plot_ly(coordsMDS, x=~V1, y=~V2, type="scatter", hovertext=~name, color= ~Artist)
