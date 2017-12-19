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
            会员管理 / <span class="font-bold  text-shallowred"> 会员管理</span>
        </header>
        <section class="scrollable padder">
            <div class="row">
                <div class="bg-white closel newclosel">
                    <c:if test="${not empty wechatBinding}">
                        <form method="post" action="" class="form-horizontal bg-white padding20 b-t b-b b-l b-r" data-validate="parsley" id="searchForm">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="control-label col-sm-4 my-display-inline-lbl" style="padding-top: 7px"><span class="text-danger"></span> 姓名：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <input type="text" class="form-control" name="name" id="name" data-maxlength="90"
                                               onblur="trimText(this)" value="${wpUser.name}">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="control-label col-sm-4 my-display-inline-lbl" style="padding-top: 7px"><span class="text-danger"></span> 电话：</label>
                                    <div class="col-sm-7  my-display-inline-box">
                                        <input type="text" class="form-control" name="contactno" id="contactno" data-maxlength="90"
                                               onblur="trimText(this)" value="${wpUser.contactno}">
                                    </div>
                                </div>
                                <div class="col-sm-4 text-center text-white">
                                    <a type="submit"  class="btn btn-submit btn-s-xs"
                                       onclick="searchWpUser()"
                                       id="searchBtn" style="color: #fff">查 询</a>
                                </div>
                            </div>
                        </form>
                            <div style="margin-top: 30px">
                                <span class="text-success">${successMessage}</span>
                                <span class="text-success">${successFlag}</span>
                            </div>
                            <div class="table-responsive" >
                                <table class="table table-striped b-t b-light  b-l b-r b-b">
                                    <thead>
                                    <tr>
                                        <th width="15%">姓名</th>
                                        <th width="15%">手机号</th>
                                        <th width="15%">详细地址</th>
                                        <th width="10%">微信昵称</th>
                                        <th width="15%">微信头像</th>
                                        <th width="10%">积分</th>
                                        <th width="20%">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${wpUserList}" var="wpUser">
                                        <tr>
                                            <td>
                                                    ${wpUser.name}
                                            </td>
                                            <td>
                                                    ${wpUser.contactno}
                                            </td>
                                            <td>
                                                    ${wpUser.address}
                                            </td>
                                            <td>
                                                    ${wpUser.nickname}
                                            </td>
                                            <td>
                                                <img src="${wpUser.headimgurl}" width="50" height="50">
                                            </td>
                                            <td>
                                                    ${wpUser.points}
                                            </td>
                                            <td>
                                                <a href="${ctx}/admin/wefamily/goWpUser?uuid=${wpUser.uuid}"
                                                   class="btn  btn-infonew btn-sm" style="color: white">
                                                    修改
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <web:pagination pageList="${wpUserList}" postParam="true"/>
                                <%--<button class="btn btn-sm btn-submit" onclick="showWpUserInfo()"> 添加</button>--%>
                            </div>
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
        showParentMenu('会员管理');
    }
    function deleteWpUser(uuid){
        qikoo.dialog.confirm('确定要删除吗？',function(){
            //确定删除
            $.post("${ctx}/admin/wefamily/deleteWpUser?uuid="+uuid,function(data){
                //删除成功
                if(data.deleteFlag){
                    var searchForm = document.getElementById("searchForm");
                    searchForm.action = "${ctx}/admin/wefamily/mtxWpUserManage?deleteFlag=1";
                    searchForm.submit();
                }
            });
        },function(){
            //取消删除
        });
    }
    function resubmitSearch(page){
        var searchForm = document.getElementById("searchForm");
        searchForm.action = "${ctx}/admin/wefamily/mtxWpUserManage?page="+page;
        searchForm.submit();
    }


    function showWpUserInfo(){
        window.location.href = "<%=request.getContextPath()%>/admin/wefamily/goWpUser";
    }
    function searchWpUser(){
        var searchForm = document.getElementById("searchForm");
        searchForm.action = "${ctx}/admin/wefamily/mtxWpUserManage";
        searchForm.submit();
    }
</script>
</body>
</html>