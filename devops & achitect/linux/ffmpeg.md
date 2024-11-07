> install ffmpeg: https://ffmpeg.org/documentation.html

# **FFmpeg 的基本使用**

- **查看帮助信息**：

  ```
  ffmpeg -h
  ```

- **基本命令示例**：

  - 将视频转换为 MP3 音频：

    ```
    ffmpeg -i input_video.mp4 output_audio.mp3
    ```

  - 压缩视频文件：

    ```
    ffmpeg -i input_video.mp4 -vcodec h264 -acodec mp2 output_video.mp4
    ```

  - 截取视频中的一帧作为图片：

    ```
    ffmpeg -i input_video.mp4 -ss 00:00:10 -frames:v 1 output_image.jpg
    ```

# 实战

```python
import os
import subprocess
import time
from datetime import datetime
import logging

def capture_frame_from_hls(url, output_dir, interval=300):
    '''
    Capture a frame from an HLS stream at specified intervals.

    Args:
        url: The URL of the HLS stream.
        output_dir: Directory to save the captured frames.
        interval: Time in seconds between captures.
    '''
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    # Configure logging
    logging.basicConfig(
        filename='capture_frames.log',
        level=logging.INFO,
        format='%(asctime)s %(levelname)s:%(message)s'
    )

    while True:
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        output_image_path = os.path.join(output_dir, f'{timestamp}.jpg')

        ffmpeg_command = [
            'ffmpeg',
            '-y',  # Overwrite output file if it exists
            '-i', url,
            '-frames:v', '1',  # Capture only one frame
            '-q:v', '2',  # Set image quality (lower value means higher quality)
            output_image_path
        ]

        try:
            logging.info(f"Capturing frame from HLS stream...")
            result = subprocess.run(
                ffmpeg_command,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                check=True,
                timeout=30  # Timeout to prevent hanging
            )
            logging.info(f"Frame captured and saved to {output_image_path}")
        except subprocess.CalledProcessError as e:
            logging.error(f"FFmpeg error: {e.stderr.decode('utf-8')}")
        except subprocess.TimeoutExpired:
            logging.error(f"FFmpeg process timed out.")
        except Exception as e:
            logging.exception(f"An unexpected error occurred: {e}")

        # Wait until the next interval
        time.sleep(interval)

```

