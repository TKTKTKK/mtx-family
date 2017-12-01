package com.mtx.wechat.service;

import com.mtx.wechat.WechatConstants;
import com.mtx.wechat.entity.admin.WechatBinding;
import com.mtx.wechat.entity.message.request.BaseRequestMessage;
import com.mtx.wechat.entity.message.request.RequestQRCodeEventMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ScanService implements MessageProcessService {

    private static Logger logger = LoggerFactory.getLogger(ScanService.class);

    @Autowired
    private AutoReplyService autoReplyService;

    @Override
    public String processMessage(BaseRequestMessage reqMessage, WechatBinding wechatBinding) {

        if(reqMessage instanceof RequestQRCodeEventMessage){
            RequestQRCodeEventMessage qrCodeEventMessage = (RequestQRCodeEventMessage)reqMessage;
            logger.info("**********ScanService : EventKey = " + qrCodeEventMessage.getEventKey() + " *******************");
        }
        return WechatConstants.DEFAULT_REPLY_MSG;
    }
}
