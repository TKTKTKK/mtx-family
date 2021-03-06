<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
</head>
<style>
</style>
<body class="">

<section id="content">
    <section class="vbox">
        <header class="panel-heading bg-white text-lg">
            宿舍管理 / <span class="font-bold  text-shallowred"> 电费管理</span>
        </header>
        <section class="scrollable padder">
            <div class="row">
                <div class="bg-white closel newclosel">
                    <c:if test="${not empty wechatBinding}">
                        <form method="post" action="" action="${ctx}/admin/wefamily/echargeManage" class="form-horizontal bg-white padding20 b-t b-b b-l b-r" data-validate="parsley" id="searchForm">
                            <div class="row">

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                           name="startDateStr" value="${startDateStr}"
                                           data-date-format="yyyy-mm-dd" id="starttime" placeholder="起始日期">

                                    <div class="text-danger" id="dateError">
                                    </div>
                                </div>
                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input class="datepicker-input form-control" size="16" type="text" data-type="dateIso"
                                           name="endDateStr" value="${endDateStr}"
                                           data-date-format="yyyy-mm-dd" id="endtime" placeholder="截止日期">
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="form-control" name="dormitoryid" id="dormitoryid" onchange="getLayerList()">
                                        <c:if test="${fn:length(dormitoryList) > 1}">
                                            <option value="">宿舍楼</option>
                                        </c:if>
                                        <c:forEach items="${dormitoryList}" var="dormitory">
                                            <option value="${dormitory.uuid}" <c:if test="${student.dormitoryid == dormitory.uuid}">selected="selected"</c:if>>${dormitory.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>


                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <select class="form-control" name="layer">
                                        <option value="">楼层(单元)</option>
                                    </select>
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="roomno" name="roomno" onblur="trimText(this)" value="${echarge.roomno}"
                                           placeholder="房间"
                                    />
                                </div>

                                <div class="col-sm-3 col-xs-12 m-b-sm" style="padding-right: 0px">
                                    <input type="text" class="form-control" id="stuno" name="stuno" onblur="trimText(this)" value="${echarge.stuno}"
                                           placeholder="缴费人学号"
                                    />
                                </div>

                            </div>

                            <div class="row col-sm-12 text-center text-white" style="margin-top: 20px">
                                <a class="btn btn-submit btn-s-xs " onclick="submitSearch()"
                                   id="searchBtn" style="color: white">查 询
                                </a>
                            </div>
                        </form>
                        <div style="margin-top: 30px">
                            <span class="text-success">${successMessage}</span>
                            <span class="text-danger">${errorMessage}</span>
                        </div>
                        <div class="table-responsive" >
                            <table class="table table-striped b-light b-a text-center">
                                <thead>
                                <tr>
                                    <th class="text-center">宿舍楼</th>
                                    <th class="text-center">楼层（单元）</th>
                                    <th class="text-center">房间号</th>
                                    <th class="text-center">缴费金额</th>
                                    <th class="text-center">缴费人</th>
                                    <th class="text-center">缴费方式</th>
                                    <th class="text-center">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${echargePageList}" var="echarge">
                                    <tr>
                                        <td>
                                                ${echarge.dormitoryname}
                                        </td>
                                        <td>
                                                ${echarge.layer}
                                        </td>
                                        <td>
                                                ${echarge.roomno}
                                        </td>
                                        <td>
                                                ${echarge.price}
                                        </td>
                                        <td>
                                                ${echarge.stuname}
                                        </td>
                                        <td>
                                                ${web:getCodeDesc("ECHARGE_PAYTYPE",echarge.paytype)}
                                        </td>
                                        <td>
                                            <a href="${ctx}/admin/wefamily/echargeInfo?echargeId=${echarge.uuid}" class="btn  btn-infonew btn-sm" style="color: white" >详情</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <c:if test="${not empty echargePageList}">
                                <web:pagination pageList="${echargePageList}" postParam="true"/>
                            </c:if>

                        </div>

                        <div class="navbar-left">
                            <a class="btn btn-sm btn-info" href="javascript:showEchargeInfo()"
                               style="color:white">添加电费缴费记录</a>

                            <button class="btn btn-sm btn-submit" onclick="exportQualityMgmtList()">导出</button>
                        </div>
                        <div style="clear: both"></div>
                    </c:if>
                    <c:if test="${empty wechatBinding}">
                        <span>您还没有添加公众号，请先去</span>
                        <a href="${ctx}/admin/account/search" class="text-info">添加公众号</a>
                    </c:if>
                </div>
            </div>
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<script src="${ctx}/static/admin/js/jquery.blockui.min.js"></script>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">

    window.onload = function(){
        //显示父菜单
        showParentMenu('宿舍服务');

        getLayerList();
    }

    function showEchargeInfo(){
        window.location.href = "${ctx}/admin/wefamily/echargeInfo";
    }


    //提交查询
    function submitSearch() {
        $("#searchForm").parsley("validate");
        //比较起始日期和截止日期 且 表单合法
        if (compareBeginEndDate('starttime', 'endtime', 'dateError')
                && $('#searchForm').parsley().isValid()) {
            $('#searchBtn').attr('disabled', true);
            //ui block
            pleaseWait();
            document.getElementById('searchForm').submit();
        }
    }

    //比较起始日期和截止日期
    function compareBeginEndDate(startDateStr, endDateStr, dateError) {
        var startDateStr = document.getElementById(startDateStr);
        var endDateStr = document.getElementById(endDateStr);
        var dateError = document.getElementById(dateError);
        dateError.innerHTML = '';

        //比较起始和截止日期的大小
        var arr = startDateStr.value.split("-");
        var bgDate = new Date(arr[0], arr[1], arr[2]);
        var starttimes = bgDate.getTime();

        var arrs = endDateStr.value.split("-");
        var edDate = new Date(arrs[0], arrs[1], arrs[2]);
        var edtimes = edDate.getTime();

        if (starttimes > edtimes) {
            dateError.innerHTML = '起始日期不能大于截止日期';
            return false;
        }
        return true;
    }

    function resubmitSearch(page){
        $("#searchForm").parsley("validate");
        //比较起始日期和截止日期 且 表单合法
        if (compareBeginEndDate('starttime', 'endtime', 'dateError')
                && $('#searchForm').parsley().isValid()) {
            $('#searchBtn').attr('disabled', true);
            //ui block
            pleaseWait();
            var searchForm = document.getElementById("searchForm");
            searchForm.action = "${ctx}/admin/wefamily/repairManage?page=" + page;
            searchForm.submit();
        }
    }


    //获取分层列表
    function getLayerList() {
        var dormitoryid = $("select[name='dormitoryid'] option:selected").val();
        if (dormitoryid.length > 0) {
            $.get("${ctx}/admin/wefamily/" + dormitoryid + "/layer", function (data, status) {
                var layerList = data.layerList;
                initLayerList();
                for (i = 0; i < layerList.length; i++) {

                    $("select[name='layer']").append($("<option>").val(layerList[i].layer).text(layerList[i].layer));

                    if ('${student.dormitoryid}' == dormitoryid && '${student.layer}' == layerList[i].layer) {
                        $("select[name='layer']").val(layerList[i].layer);
                    }
                }
            });
        }
    }

    function initLayerList() {
        $("select[name='layer']").empty();
        $("select[name='layer']").append($("<option>").val("").text("楼层(单元)"));
    }

</script>
</body>
</html>