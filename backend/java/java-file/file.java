package com.yiibai.io;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

// 文件输出流是一种用于处理原始二进制数据的字节流类。为了将数据写入到文件中，必须将数据转换为字节，并保存到文件。请参阅下面的完整的例子。

public class WriteFileExample {
 public static void main(String[] args) {

  FileOutputStream fop = null;
  File file;
  String content = "This is the text content";

  try {

   file = new File("c:/newfile.txt");
   fop = new FileOutputStream(file);

   // if file doesnt exists, then create it
   if (!file.exists()) {
    file.createNewFile();
   }

   // get the content in bytes
   byte[] contentInBytes = content.getBytes();

   fop.write(contentInBytes);
   fop.flush();
   fop.close();

   System.out.println("Done");

  } catch (IOException e) {
   e.printStackTrace();
  } finally {
   try {
    if (fop != null) {
     fop.close();
    }
   } catch (IOException e) {
    e.printStackTrace();
   }
  }
 }
}