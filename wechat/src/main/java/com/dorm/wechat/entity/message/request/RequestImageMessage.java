package com.dorm.wechat.entity.message.request;


/**
 * 图片消息
 *
 */
public class RequestImageMessage extends BaseRequestMessage {
    // 图片链接
    private String PicUrl;

    public String getPicUrl() {
        return PicUrl;
    }

    public void setPicUrl(String picUrl) {
        PicUrl = picUrl;
    }
}

