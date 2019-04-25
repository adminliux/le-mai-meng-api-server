<%@ page import="com.qcloud.cos.auth.COSCredentials" %>
<%@ page import="com.qcloud.cos.auth.BasicCOSCredentials" %>
<%@ page import="com.qcloud.cos.region.Region" %>
<%@ page import="com.qcloud.cos.model.PutObjectRequest" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.net.URL" %>
<%@ page import="com.daolezuche.constants.QcloudConstant" %>
<%@ page import="com.qcloud.cos.ClientConfig" %>
<%@ page import="com.qcloud.cos.COSClient" %>
<%@ page import="org.apache.commons.fileupload.FileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="java.io.File" %>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%@ page import="java.util.UUID" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String secretId = QcloudConstant.SecretId;
    String secretKey = QcloudConstant.SecretKey;
    FileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
    upload.setHeaderEncoding("UTF-8");
    List items = upload.parseRequest(request);
    Iterator itr = items.iterator();
    String savePath = pageContext.getServletContext().getRealPath("/") + "kindEditor/attached/";

    while (itr.hasNext()) {

        FileItem item = (FileItem) itr.next();
        if (!item.isFormField()) {
            String fileName = item.getName();
            fileName = UUID.randomUUID().toString() + fileName;
            long fileSize = item.getSize();
            if (fileSize > 1000000) {
                out.println(getError("上传文件大小超过限制。"));
                return;
            }
            File uploadedFile = null;
            try {
                uploadedFile = new File(savePath, fileName);
                item.write(uploadedFile);
            } catch (Exception e) {
                out.println(getError("上传文件失败。"));
                return;
            }

            COSCredentials cred = new BasicCOSCredentials(secretId, secretKey);
            // 2 设置bucket的区域, COS地域的简称请参照
            // https://cloud.tencent.com/document/product/436/6224
            ClientConfig clientConfig = new ClientConfig(new Region((String) session.getServletContext().getAttribute("service.config.properties")));
            // 3 生成cos客户端s
            COSClient cosClient = new COSClient(cred, clientConfig);
            String bucketName = (String) session.getServletContext().getAttribute("tencent.bucket-name");
            // 简单文件上传, 最大支持 5 GB, 适用于小文件上传, 建议 20 M 以下的文件使用该接口
            // 大文件上传请参照 API 文档高级 API 上传
            // 指定要上传到 COS 上的路径

            PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, "/" + fileName, uploadedFile);
            cosClient.putObject(putObjectRequest);
            cosClient.shutdown();
            Date expiration = new Date(new Date().getTime() + 5 * 60 * 10000);
            URL url = cosClient.generatePresignedUrl(bucketName, "/" + fileName, expiration);
            if (uploadedFile.exists()) {
                uploadedFile.delete();
            }

            JSONObject obj = new JSONObject();
            obj.put("error", 0);
            obj.put("url", url.getProtocol() + "://" + url.getHost() + url.getPath());
            out.println(obj.toJSONString());
        }
    }


%>
<%!
    private String getError(String message) {
        JSONObject obj = new JSONObject();
        obj.put("error", 1);
        obj.put("message", message);
        return obj.toJSONString();
    }
%>