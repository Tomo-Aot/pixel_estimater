# 2025-11-13
# Tomoyuki Aota
# Estimate seaweed community area from a picture
# loading packages
library(tidyverse)
library(ggpubr)
library(ggtext)
library(showtext)
library(magick)

# loading raw data
path = "./raw_data"

data = tibble(
  dir = dir(path = path,
            full.names = TRUE)
) |> 
  mutate(data = map(dir, image_read)) |> 
  select(dir) |> 
  as.character()


# define seaweed areas
# test with a herbarium picture
pic = image_read(data)

# extract pixel data
pixels = as.data.frame(pic[[1]])

r = as.raster(pic)

pixels = expand_grid(
  x = seq_len(nrow(r)),
  y = seq_len(ncol(r))
)

pixels = pixels |> 
  mutate(colour = as.vector(r))


pixels |> 
  ggplot() + 
  geom_raster(
    aes(x = x, y = y, fill = colour)
  ) + 
  theme(
    legend.position = "none",
    axis.title = element_blank(),
    axis.text = element_blank()
  ) + 
  scale_fill_identity() + 
  coord_fixed() + 
  theme_void()

