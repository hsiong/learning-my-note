package wordTest.image;

import org.junit.Test;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.BufferedImageOp;
import java.awt.image.ConvolveOp;
import java.awt.image.Kernel;
import java.io.File;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/9/26
 */
public class PngResizer {

    @Test
    public void resize() throws Exception {
        // 输入的 PNG 文件和输出的 PNG 文件路径
        String inputFilePath = "/Users/vjf/Desktop/2048.png";
        String outputFilePath = "/Users/vjf/Desktop/outputb.jpg";
        FileUtil.generateOutFile(outputFilePath);

        // 新的宽度和高度
        int newWidth = 114; // 新宽度
        int newHeight = 20; // 新高度

        // 读取原始图像
        BufferedImage originalImage = ImageIO.read(new File(inputFilePath));
        
        // 创建目标图像
        BufferedImage resizedImage = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_ARGB);

        // 使用高质量的缩放算法
        Graphics2D g2d = resizedImage.createGraphics();
        g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g2d.drawImage(originalImage, 0, 0, newWidth, newHeight, null);
        g2d.dispose();

        // 应用锐化滤镜
        BufferedImage sharpenedImage = sharpenImage(resizedImage);

        // 保存缩小并锐化后的图像
        File outputFile = new File(outputFilePath);
        ImageIO.write(resizedImage, "PNG", outputFile);
    }

    // 锐化图像的方法
    private static BufferedImage sharpenImage(BufferedImage image) {
        float[] sharpenMatrix = {
            -1, -1, -1,
            -1,  9, -1,
            -1, -1, -1
        };

        BufferedImageOp sharpenFilter = new ConvolveOp(new Kernel(3, 3, sharpenMatrix), ConvolveOp.EDGE_NO_OP, null);
        return sharpenFilter.filter(image, null);
    }
}
