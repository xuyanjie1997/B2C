package com.xyj.shop.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import tools.FmtEmpty;

public class Upload {

    public static Map<String, Object> upload(HttpServletRequest request) throws FileUploadException, IOException {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> items = upload.parseRequest(request);
        Map<String, Object> map = new HashMap<String, Object>();
        List<String> filenames = new ArrayList<String>();
        for (FileItem item : items) {
            if (item.isFormField()) {
                // System.out.println("1--" + item.getFieldName());
                String value = item.getString();
                value = new String(value.getBytes("ISO-8859-1"), "UTF-8");
                map.put(item.getFieldName(), value);
            } else {
                InputStream is = item.getInputStream();
                byte[] b = new byte[1024 * 1024];
                int length = is.read(b);
                if (length < 0)
                    continue;
                String fn = getFName();
                OutputStream fos = new FileOutputStream(getFPath() + "/" + fn);
                fos.write(b, 0, length);
                fos.flush();
                fos.close();
                is.close();
                filenames.add(fn);
            }
        }
        map.put("list", filenames);
        return map;
    }

    private static String getFName() {
        String filename = UUID.randomUUID().toString() + ".jpg";
        return filename;
    }

    private static File getFPath() {
    	File f = new File("D:/Office/image");
        if (!f.exists()) {
            f.mkdir();
        }
        return f;
    }

    public static void delFile(String filename) {
        if (FmtEmpty.isEmpty(filename))
            return;
        File file = new File(getFPath() + "/" + filename);
        file.delete();
    }

}
