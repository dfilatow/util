install.packages("bcmaps")
install.packages("bcdata")
library(bcmaps)
library(sf)
library(bcdata)

es <- ecosections(force=TRUE)
head(es)
esFRB <- filter(es, ECOSECTION_CODE =="FRB")
gwellsFRB <- bcdc_query_geodata("e4731a85-ffca-4112-8caf-cb0a96905778") %>% filter(INTERSECTS(esFRB)) %>% collect()
head(gwellsFRB)
plot(st_geometry(gwells))

dem <- raster("//imagefiles.bcgov/dem/elevation/trim_25m/bcalbers/tif/bc_elevation_25m_bcalb.tif")
gwellsFRB$elev <- extract(dem, gwells)
hist(gwellsFRB$elev)

gwells <- bcdc_get_data("e4731a85-ffca-4112-8caf-cb0a96905778")
head(gwells)
hist(gwells$BEDROCK_DEPTH)
hist(gwells$BEDROCK_DEPTH[gwells$BEDROCK_DEPTH < 500])
# also could tru this https://edwinth.github.io/blog/outlier-bin/
gwells$elev <- extract(dem, gwells) # not working on my govbc computer but worked on my home laptop. rgdal version issue.
hist(gwells$elev)

# find the gwells record with a really large depth to bedrock that is throwing off the graph.
gwellsERROR <- bcdc_query_geodata("e4731a85-ffca-4112-8caf-cb0a96905778") %>% filter(BEDROCK_DEPTH > 4000) %>% collect()
