package com.dorm.family.entity;

import com.dorm.common.base.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Table;

/**
 * Created by TK on 2017/12/4.
 */
@Table(name = "tb_mtx_train")
public class Train extends BaseEntity {

    @Column
    private String snno;
    @Column
    private String merchantid;
    @Column
    private String machinemodel;
    @Column
    private String machineno;
    @Column
    private String engineno;
    @Column
    private String productiondt;
    @Column
    private String person;
    @Column
    private String personname;
    @Column
    private String personphone;
    @Column
    private String program;
    @Column
    private String type;
    @Column
    private String traindt;
    @Column
    private String situation;
    @Column
    private String situationremarks;
    @Column
    private String location;
    @Column
    private String status;
    @Column
    private String praisestatus;
    @Column
    private String praiseremarks;

    private String merchantname;

    private String typeDesc;

    private String statusDesc;

    private String praisestatusDesc;

    public String getSnno() {
        return snno;
    }

    public void setSnno(String snno) {
        this.snno = snno;
    }

    public String getMerchantid() {
        return merchantid;
    }

    public void setMerchantid(String merchantid) {
        this.merchantid = merchantid;
    }

    public String getMachinemodel() {
        return machinemodel;
    }

    public void setMachinemodel(String machinemodel) {
        this.machinemodel = machinemodel;
    }

    public String getMachineno() {
        return machineno;
    }

    public void setMachineno(String machineno) {
        this.machineno = machineno;
    }

    public String getEngineno() {
        return engineno;
    }

    public void setEngineno(String engineno) {
        this.engineno = engineno;
    }

    public String getProductiondt() {
        return productiondt;
    }

    public void setProductiondt(String productiondt) {
        this.productiondt = productiondt;
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }

    public String getPersonname() {
        return personname;
    }

    public void setPersonname(String personname) {
        this.personname = personname;
    }

    public String getPersonphone() {
        return personphone;
    }

    public void setPersonphone(String personphone) {
        this.personphone = personphone;
    }

    public String getProgram() {
        return program;
    }

    public void setProgram(String program) {
        this.program = program;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTraindt() {
        return traindt;
    }

    public void setTraindt(String traindt) {
        this.traindt = traindt;
    }

    public String getSituation() {
        return situation;
    }

    public void setSituation(String situation) {
        this.situation = situation;
    }

    public String getSituationremarks() {
        return situationremarks;
    }

    public void setSituationremarks(String situationremarks) {
        this.situationremarks = situationremarks;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMerchantname() {
        return merchantname;
    }

    public void setMerchantname(String merchantname) {
        this.merchantname = merchantname;
    }

    public String getPraisestatus() {
        return praisestatus;
    }

    public void setPraisestatus(String praisestatus) {
        this.praisestatus = praisestatus;
    }

    public String getPraiseremarks() {
        return praiseremarks;
    }

    public void setPraiseremarks(String praiseremarks) {
        this.praiseremarks = praiseremarks;
    }

    public String getTypeDesc() {
        return typeDesc;
    }

    public void setTypeDesc(String typeDesc) {
        this.typeDesc = typeDesc;
    }

    public String getStatusDesc() {
        return statusDesc;
    }

    public void setStatusDesc(String statusDesc) {
        this.statusDesc = statusDesc;
    }

    public String getPraisestatusDesc() {
        return praisestatusDesc;
    }

    public void setPraisestatusDesc(String praisestatusDesc) {
        this.praisestatusDesc = praisestatusDesc;
    }
}