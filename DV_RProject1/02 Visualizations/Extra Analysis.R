require("ggplot2")
require("jsonlite")
require("RCurl")

df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from titanic where survived is not null"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_gmg954', PASS='orcl_gmg954', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

require(extrafont)
ggplot() + 
  coord_cartesian() + 
  scale_y_continuous() +
  
  scale_x_discrete()+
  #facet_wrap(~SURVIVED) +
  #facet_grid(.~SURVIVED, labeller=label_both) + # Same as facet_wrap but with a label.
  #facet_grid(PCLASS~SURVIVED, labeller=label_both) +
  labs(title='Titanic') +
  labs(t="Age", x=paste("Survived")) +
  layer(data=df, 
        mapping=aes(y=as.numeric(as.character(AGE)), x=as.character(SURVIVED)), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(fill="white",colour="blue"), 
        #position=position_identity()
        position=position_jitter(width=.3, height=0)
  )

