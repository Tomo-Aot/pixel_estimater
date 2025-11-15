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
  mutate(
    data = map(dir, image_read)
  ) |> 
  select(data) |> 
  unlist(data)

# define seaweed areas
# test with a herbarium picture
pic = data$data1

# extract pixel data
pixels = as.data.frame(pic[[1]])

r = as.raster(pic)

pixels = expand_grid(
  x = seq_len(nrow(r)),
  y = seq_len(ncol(r))
)

pixels = pixels |> 
  mutate(colour = as.vector(r))


pixels = pixels |> 
  mutate(
    RGB = t(col2rgb(colour)),
    red = RGB[, 1],
    green = RGB[, 2],
    blue = RGB[, 3]
  ) |> 
  select(x, y, colour, red, green, blue)



king = pixels |> 
  mutate(
    is_redbrown = 
      (red >= 30 & red <= 170) &
      (green >= 5 & green <= 90)  &
      (blue >= 0 & blue <= 80)
  ) |> 
  mutate(colour = ifelse(is_redbrown == TRUE, "#ff0000", colour))

king |> 
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


king |> 
  filter(is_redbrown == TRUE) |> 
  nrow()



