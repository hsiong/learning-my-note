
先后尝试了多种办法

## Apache batik
处理效果极差, 甚至存在文字丢失

```
      <dependency>
          <groupId>org.apache.xmlgraphics</groupId>
          <artifactId>batik-all</artifactId>
          <version>1.17</version>
      </dependency>
```

## imagemagick
+ scale
convert 2048.png -scale 25% -quality 100 output.png 

+ resize
convert ~/Desktop/2048.png -resize 114x20 output2.png 

最后效果, scale 毛刺和平滑度大于resize

## BufferedImage
直接效果最差, 但是由 java 实现, 可以通过优化插值算法/锐化算法等方式优化


## canvas
与 imagemagick 效果一致

## java FX
效果极差

> JavaFX runtime components are missing, and are required to run this application
> https://codeantenna.com/a/qsMjTxMVI5