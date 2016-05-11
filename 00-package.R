##=======================================================================
## ?å®?Ç§◊ŸÄ ?Ñ§Ïπ? Î∞? ?†Å?û¨ 
##=======================================================================

.packages.default = c("readr", "dplyr", "testthat", "stringr", 'treemap','zoo','xtable',
                      "tidyr", "ggvis", "readxl", 'lubridate','splines', 'extrafont', 'ROCR', 'rpart')
.packages.map = c("ggplot2", "ggmap", "sp", "maptools", "RJSONIO", "leaflet",
                  "rworldmap", "tmap", "htmlwidgets","mefa")

.packages <- c(.packages.default, .packages.map)
.packages
# Install CRAN packages (if not already installed)
.inst <- .packages %in% installed.packages()
if(length(.packages[!.inst]) > 0) install.packages(.packages[!.inst])

# Load packages into session 
lapply(.packages, require, character.only=TRUE)

#print(.libPaths())
#print(sessionInfo())
#print(version)

#install.packages("rworldmap")
#library(ggmap)

##=======================================================================
## ?ï®?àò 
##=======================================================================

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}


##=======================================================================
## Í∑∏Îûò?îÑ ?ïúÍ∏Ä?Ñ§?†ï
##=======================================================================

suppressPackageStartupMessages({
  library(ggplot2)
  library(ggthemes)
  library(extrafont)
})


#Í∞úÏù∏?ôî?êú ?Öå◊∫? ?ûë?óÖ
theme_gogamza<- function(base_size = 12, base_family = "NanumGothic"){
  (theme_foundation(base_size = base_size, base_family = base_family) +
     theme(line = element_line(colour = "black"), rect = element_rect(fill = ggthemes_data$fivethirtyeight["ltgray"],
                                                                      linetype = 0, colour = NA), text = element_text(colour = ggthemes_data$fivethirtyeight["dkgray"]),
           axis.title = element_text(), axis.text = element_text(),
           axis.ticks = element_blank(), axis.line = element_blank(),
           legend.background = element_rect(), legend.position = "bottom",
           legend.direction = "horizontal", legend.box = "vertical",
           panel.grid = element_line(colour = NULL), panel.grid.major = element_line(colour = ggthemes_data$fivethirtyeight["medgray"]),
           panel.grid.minor = element_blank(), plot.title = element_text(hjust = 0,
                                                                         size = rel(1.5), face = "bold"), plot.margin = grid::unit(c(1,
                                                                                                                                     1, 0.5, 0.5), "lines"), strip.background = element_rect(), panel.margin.x=NULL, panel.margin.y=NULL))
}

#ggplot2 ◊ºîÏù∏ ?Öå◊∫àÎ°ú ?Ñ§?†ï
#theme_set(theme_gogamza())
theme_set(theme_gray(base_family='NanumGothic'))
