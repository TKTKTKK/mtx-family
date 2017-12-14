package com.mtx.family.service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseService;
import com.mtx.common.entity.Attachment;
import com.mtx.common.mapper.AttachmentMapper;
import com.mtx.common.utils.StringUtils;
import com.mtx.family.entity.*;
import com.mtx.family.mapper.LogisticsMapper;
import com.mtx.family.mapper.MerchantMapper;
import com.mtx.family.mapper.RepairMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class RepairService extends BaseService<RepairMapper,Repair> {

    @Autowired
    public void setMapper(RepairMapper mapper) {
        super.setMapper(mapper);
    }

    @Autowired
    private AttachmentMapper attachmentMapper;
    @Autowired
    private MerchantService merchantService;
    @Autowired
    private RepairWorkerService repairWorkerService;

    public List<Repair> queryRepairForSnnoRepeat(Repair repair) {
        return this.mapper.selectRepairForSnnoRepeat(repair);
    }

    public void saveRepair(Repair repair, String[] repairImgs) {

        this.mapper.insert(repair);

        saveRepairImg(repair,repairImgs);
    }

    private void saveRepairImg(Repair repair, String[] repairImgs) {
        if(null != repairImgs){
            for(String img : repairImgs){
                Attachment attachment = new Attachment();
                attachment.setRefid(repair.getUuid());
                attachment.setName(img);
                attachment.setType("REPORTER");
                attachmentMapper.insert(attachment);
            }
        }
    }

    public void updateRepair(Repair repair, String[] repairImgs) {
        this.mapper.updatePartial(repair);

        saveRepairImg(repair,repairImgs);
    }

    public PageList<Repair> queryRepairList(Repair repair, String startDateTimeStr, String endDateTimeStr, PageBounds pageBounds) {
        return this.mapper.selectRepairList(repair,startDateTimeStr,endDateTimeStr,pageBounds);
    }

    public String saveMachineInfoForRepair(String repairId, Machine machine) {
        String returnMsg = "";
        Merchant merchant = merchantService.queryMerchantByMachineInfo(machine);
        if(null != merchant){
            Repair repair = new Repair();
            repair.setUuid(repairId);
            repair = this.mapper.retrieveByPk(repair);

            repair.setMerchantid(merchant.getUuid());
            repair.setMachinemodel(machine.getMachinemodel());
            repair.setMachineno(machine.getMachineno());
            repair.setEngineno(machine.getEngineno());
            repair.setProductiondt(machine.getProductiondate());
            this.mapper.updatePartial(repair);
        }else{
            returnMsg = "此机器不存在,请确认信息！";
        }

        return returnMsg;
    }

    public int distributeRepair(Repair repair) {
        repair.setStatus("DISTRIBUTED");
        this.mapper.updatePartial(repair);
        return 1;
    }

    public int startRepair(Repair repair) {
        repair.setStatus("REPAIRING");
        this.mapper.updatePartial(repair);
        return 1;
    }

    public void saveRepairInfo(Repair repair, RepairWorker repairWorker, String[] repairImgs) {

        this.mapper.updatePartial(repair);

        if(StringUtils.isNotBlank(repairWorker.getUuid())){
            repairWorkerService.updatePartial(repairWorker);
        }else{
            repairWorkerService.insert(repairWorker);
        }

        if(null != repairImgs){
            for(String img : repairImgs){
                Attachment attachment = new Attachment();
                attachment.setRefid(repair.getUuid());
                attachment.setName(img);
                attachment.setType("worker");
                attachmentMapper.insert(attachment);
            }
        }
    }

    public int finishRepair(Repair repair) {
        repair.setStatus("FINISH");
        this.mapper.updatePartial(repair);
        return 1;
    }
}