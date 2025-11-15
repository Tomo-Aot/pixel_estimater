# Pixel Estimater

このリポジトリでは、
画像データから特定の色のピクセルを抽出するスクリプトを共有します。

# Loading Packages

はじめに、
今回使用するパッケージを読み込みます。
パッケージは予めインストールしておきましょう。

```
library(tidyverse)
library(magick)
library(ggpubr)
library(ggtext)
library(showtext)
```

# Preapare Image Files

画像データが複数存在することを想定して、
ここでは$tibble()$を使用してファイル名をリスト化します。


