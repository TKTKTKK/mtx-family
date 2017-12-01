<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>
    <%--<link href="${ctx}/static/admin/css/sweetalert.css" rel="stylesheet">--%>
        <link href="${ctx}/static/admin/css/qikoo/qikoo.css" rel="stylesheet">
    <style type="text/css">
        .permit-list{
            display: none;
            position: absolute;
            top: 0%;
            left: 10%;
            background: sandybrown;
            color: black;
            z-index: 10;
            border-radius: 5px;
            padding: 10px;
        }
        @media (min-width: 768px){
            .hsspan {
                vertical-align: top;
                width: 500px;
                display: inline-block;
                word-wrap: break-word;
            }
        }
        @media (max-width: 767px){
            .hsspan {
                vertical-align: top;
                width: 100px;
                display: inline-block;
                overflow-x: hidden;
                text-overflow: ellipsis;/*超出内容显示为省略号*/
                white-space: nowrap;/*文本不进行换行*/
            }
        }
        .pading{
            padding-top: 0px;
            padding-bottom: 10px;
            border:1px solid transparent;
            height: 30px;
            line-height: 30px;

            padding-left: 12px;
        }
        .pading:hover{
            background-color: #c4e1ff;
            color: #000;
        }
        .feetype-ul{
            display:block;
            height: 150px;
            overflow-x:hidden;
            margin: 0;
            padding: 2px;
            border-radius: 4px;
            border:1px solid #cbd5dd;
        }
        .feetype-ul, li{
            list-style: none;
            margin: 0;
            padding: 0
        }
    </style>
</head>
<body class="">

<section id="content"  class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-md b-b">
                用户 /
                <a href="javascript:backRoleDistribute()">用户管理</a> /
                <span class="font-bold text-shallowred">用户</span>
            </header>
            <div class="row" style="margin-right:25px;float: right">
                <a href="javascript:backRoleDistribute()" class="btn btn-submit btn-s-md a-noline" style="color: #fff"
                >返回</a>
            </div>
                <div class="col-sm-12 pos">
                    <ul id="myTab" class="nav nav-tabs font-bold text-md">
                        <c:choose>
                            <c:when test="${empty querytype or querytype eq 'user'}">
                                <li class="active" onclick="toggleTab('user')"><a data-toggle="tab">用户信息</a></li>
                                <li onclick="toggleTab('district')"><a data-toggle="tab">片区信息</a></li>
                            </c:when>
                            <c:when test="${'district' eq querytype}">
                                <li onclick="toggleTab('user')"><a data-toggle="tab">用户信息</a></li>
                                <li class="active" onclick="toggleTab('district')"><a data-toggle="tab">片区信息</a></li>
                            </c:when>
                        </c:choose>
                    </ul>
                    <c:if test="${empty querytype or querytype eq 'user'}">
                        <div style="margin-bottom: 5px">
                            <span id="successMessage" class="text-success">${successMessage}</span>
                            <span id="errorMessage" class="text-danger">${errorMessage}</span>
                        </div>
                        <form class="form-horizontal  form-bordered" data-validate="parsley" action="${ctx}/admin/usermanage/saveUserInfo" method="POST"
                              onsubmit="return submitUserInfo()" id="frm">
                            <section class="panel panel-default m-n">
                                <header class="panel-heading  mintgreen">
                                    <i class="fa fa-gift"></i>
                                    <span class="text-lg">用户信息：</span>
                                </header>
                                <div class="panel-body p-0-15">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>用户名：</label>

                                        <c:if test="${empty platformUser.uuid}">
                                            <div class="col-sm-9  b-l bg-white">
                                                    <input type="text" class="form-control" data-required="true" name="username" id="username" data-maxlength="30"
                                                           onblur="validateChineseText(30, this, 'usernameError')" value="${platformUser.username}"/>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty platformUser.uuid}">
                                            <div class="col-sm-5  b-l bg-white" style="padding-right: 0px;margin-top: 15px">
                                                    <input type="text" class="form-control" data-required="true" name="username" id="username" data-maxlength="30"
                                                           onblur="validateChineseText(30, this, 'usernameError')" value="${platformUser.username}" readonly/>
                                            </div>
                                            <div class="col-sm-2" style="padding-right: 15px;margin-top: 15px;margin-bottom: 15px;">
                                                <button class="btn btn-yellow btn-sm a-noline form-control glyphicon glyphicon-pencil"
                                                        data-toggle="modal" data-target=".bs-example-modal-lg"
                                                        onclick="saveUuidAndVersionno('${platformUser.uuid}','${platformUser.versionno}')">
                                                    修改用户名
                                                </button>
                                            </div>
                                            <div class="col-sm-2" style="padding-right: 15px;margin-top: 15px;margin-bottom: 15px;">
                                                <button class="btn btn-success btn-s-xs form-control"
                                                        data-toggle="modal" data-target=".bs-example-modal-lg-reset"
                                                ><i class="glyphicon glyphicon-repeat"></i>&nbsp;重置密码
                                                </button>
                                            </div>
                                        </c:if>
                                        <span id="usernameError" class="text-danger"></span>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>姓名：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <input type="text" class="form-control" data-required="true" name="name" id="name" data-maxlength="90"
                                                   onblur="validateChineseText(90, this, 'nameError')" value="${platformUser.name}"/>
                                            <span id="nameError" class="text-danger"></span>
                                        </div>
                                    </div>

                                        <input name="queryCommunityid" id="queryCommunityid" value="${queryCommunityid}" type="hidden">
                                        <input name="queryUsername" id="queryUsername" value="${queryUsername}" type="hidden">
                                        <input name="queryName" id="queryName" value="${queryName}" type="hidden">
                                        <input name="queryTopAccount" id="queryTopAccount" value="${queryTopAccount}" type="hidden">
                                        <input name="wechatUserInfoId" id="wechatUserInfoId" value="${wechatUserInfoId}" type="hidden">

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">职位：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <div class="" style="position: relative">
                                                <input type="text" class="form-control my-feetype-ul"  name="title" id="platformUserTitle"
                                                       onkeyup="autoQueryPlatformUserTitleList(this,undefined,undefined)"
                                                       name="platformUserTitle"
                                                       value="${platformUser.title}"
                                                       placeholder="请输入职位"
                                                >
                                                <a class="btn btn-default btn-sm a-noline my-supplier-ul"
                                                   style="margin-top: 2px;position: absolute;top: 0;right: 2px;border: 0;box-shadow: 0 0 0 rgba(255,255,255,1);"
                                                   onclick="queryPlatformUserTitleList(undefined, undefined)"
                                                ><i class="fa fa-search"></i></a>
                                            </div>
                                            <i class="icon-close hidden" id="platformUserTitleClose" style="cursor:pointer;margin-top: 17px;position: absolute;top: 38px;right: 20px;border: 0;box-shadow: 0 0 0 rgba(255,255,255,1);"></i>
                                            <ul class="feetype-ul hidden" id="platformUserTitleUl" style=" padding-top:20px">
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><span class="text-danger">*</span>手机号码：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <input type="text" data-type="phone" data-required="true" class="form-control"
                                                   name="cellphone" id="cellphone" data-maxlength="20"
                                                   onblur="checkPhone(this.value)" value="${platformUser.cellphone}"/>
                                            <span class="text-danger" id="contactnoError"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">状态：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <c:choose>
                                                <c:when test="${platformUser.uuid == null}">
                                                    <input type="text"  class="form-control"  value="正常" readonly/>
                                                    <input type="hidden"   name="status" id="status"  value="NORMAL"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="text"  class="form-control"   value="${web:getCodeDesc('USER_STATUS',platformUser.status )}" readonly/>
                                                    <input type="hidden"   name="status" id="status"  value="${platformUser.status}"/>
                                                </c:otherwise>
                                            </c:choose>

                                        </div>
                                    </div>
                                    <c:if test="${not empty roleList}">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">角色：</label>
                                            <div class="col-sm-9  b-l bg-white">

                                                <c:forEach items="${roleList}" var="role">
                                                    <div class="checkbox i-checks" style="padding-left: 0px;position: relative">
                                                        <label class="checkbox m-n">
                                                                <%--<input type="checkbox" name="roles" value="${role.uuid}"><i></i> ${role.rolename}--%>

                                                            <c:set var="showFlag" value="0" scope="page"></c:set>
                                                            <c:forEach items="${platformUser.roles}" var="userRole">
                                                                <c:if test="${userRole == role.uuid}">
                                                                    <c:set var="showFlag" value="1" scope="page"></c:set>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${showFlag == 1}">
                                                                <input type="checkbox" name="roles" value="${role.uuid}" onclick="checkFinantion()" checked>
                                                                <i></i>
                                                            <span onmouseover="queryPermitListByRoleId(this, '${role.uuid}')"
                                                                  onmouseout="hidePermitList(this)">${role.rolename}</span>
                                                            </c:if>
                                                            <c:if test="${showFlag == 0}">
                                                                <input type="checkbox" name="roles" value="${role.uuid}" onclick="checkFinantion()">
                                                                <i></i>
                                                            <span onmouseover="queryPermitListByRoleId(this, '${role.uuid}')"
                                                                  onmouseout="hidePermitList(this)">${role.rolename}</span>
                                                            </c:if>
                                                        </label>
                                                        <div class="permit-list"></div>
                                                    </div>
                                                </c:forEach>
                                                <span id="remarksError" class="text-danger"></span>
                                            </div>
                                        </div>
                                    </c:if>


                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">绑定微信：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <div class="col-sm-4 col-xs-12">
                                                <input id="openid" name="openid" class="form-control" value="${platformUser.openid}"
                                                       onchange="showGroup(this.value),checkIfSubscribe()"/>
                                            </div>
                                                <%--<label class="col-sm-1"></label>--%>
                                            <div class="col-sm-5">
                                                <a class="btn btn-default btn-s-xs" onclick="sendTestMessage()">发送测试模板消息</a>
                                                <span style="margin-left: 10px" id="subscribeInfo"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group" id="wechatGroupId" style="display:none;">
                                        <label class="col-sm-3 control-label">用户分组：</label>
                                        <div class="col-sm-9  b-l bg-white">
                                            <select  class="form-control" name="groupId" id="groupId" value="${platformUser.groupId}">
                                                <c:forEach items="${wechatGroupList}" var="group">
                                                    <c:if test="${group.id == platformUser.groupId}">
                                                        <option value="${group.id}" selected>${group.name}</option>
                                                    </c:if>
                                                    <c:if test="${group.id !=  platformUser.groupId}">
                                                        <option value="${group.id}">${group.name}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                            <span id="wechatGroupError" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <input type="hidden" name="uuid" id="hidPlatformUserId" class="form-control" value="${platformUser.uuid}">
                                            <input type="hidden" name="versionno" id="hidVersionno" class="form-control" value="${platformUser.versionno}">
                                            <%--<input type="hidden" name="queryCommunityid" class="form-control" value="${queryCommunityid}">--%>
                                        </div>
                                    </div>
                                </div>
                                <footer class="panel-footer text-left bg-light lter">
                                    <c:if test="${empty view}">
                                        <button type="submit" class="btn btn-submit btn-s-xs"><i class="fa fa-check"></i>&nbsp;提&nbsp;交</button>
                                        <c:if test="${platformUser.uuid != null && currentUserId != platformUser.uuid}">
                                            <c:choose>
                                                <c:when test="${platformUser.status == 'FREEZE'}">
                                                    <a  href="javascript:changeUserStatus('${platformUser.uuid}','${platformUser.versionno}','${querytype}')" class="btn btn-success btn-s-xs" style="margin-left: 100px;">
                                                        <i class="glyphicon glyphicon-ok"></i>&nbsp;生&nbsp;效
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a  href="javascript:changeUserStatus('${platformUser.uuid}','${platformUser.versionno}','${querytype}')" class="btn btn-danger btn-s-xs" style="margin-left: 100px;">
                                                        <i class="	glyphicon glyphicon-remove"></i>&nbsp;冻&nbsp;结
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </c:if>
                                </footer>
                            </section>
                        </form>
                    </c:if>
                    <c:if test="${'district' eq querytype}">
                        <div style="margin-top: 5px">
                            <span id="successMessage" class="text-success">${successMessage}</span>
                            <span id="errorMessage" class="text-danger">${errorMessage}</span>
                        </div>
                        <div class="table-responsive top-margin">
                            <table class="table table-striped b-t b-light b-b b-l b-r">
                                <thead>
                                <tr>
                                    <th width="30%">小区名称</th>
                                    <th width="40%">楼栋号</th>
                                    <th width="30%">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${userCommunityList}" var="userCommunity" varStatus="stat">
                                    <tr>
                                        <td>
                                                ${userCommunity.communityname}
                                        </td>
                                        <td>
                                            <span class="hsspan">
                                                ${userCommunity.blknos}
                                            </span>
                                        </td>
                                        <td>
                                            <a onclick="showUserCommunityInfo('${userCommunity.uuid}')" type="button"
                                               class="btn btn-sm btn-dangernew  a-noline" style="color:white"
                                               data-toggle="modal" data-target=".bs-example-modal-tj"
                                            >
                                                修改</a>
                                            <c:if test="${currentUserId != platformUser.uuid}">
                                                <a href="javascript:deleteUserCommunityInfo('${userCommunity.uuid}', '${platformUser.uuid}')" type="button"
                                                   class="btn btn-sm btn-yellow a-noline" style="color:white">
                                                    删除</a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <c:if test="${not empty userCommunityList}">
                                <web:pagination pageList="${userCommunityList}"/>
                            </c:if>
                        </div>
                        <div class="navbar-left">
                            <c:if test="${fn:length(partialCommunityList) > 0}">
                                <a class="btn btn-primary btn-s-xs"
                                   data-toggle="modal" data-target=".bs-example-modal-tj" style="color: #fff"
                                   onclick="showUserCommunityInfo()"
                                >添 加</a>
                            </c:if>
                            <c:if test="${platformUser.uuid != null && currentUserId != platformUser.uuid && platformUser.status == 'FREEZE'}">
                                        <a  href="javascript:changeUserStatus('${platformUser.uuid}','${platformUser.versionno}','${querytype}')" class="btn btn-success btn-s-xs" style="margin-left: 20px;">
                                            <i class="glyphicon glyphicon-ok"></i>&nbsp;生&nbsp;效
                                        </a>
                            </c:if>
                        </div>
                        <!-- /.modal添加 -->
                        <div class="modal fade bs-example-modal-tj " tabindex="-1" role="dialog"
                             aria-labelledby="myLargeModalLabelTj" aria-hidden="false">
                            <div class="modal-dialog modal-lg" style="margin-top: 15%">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" id="modelCloseBtnAdd"><span
                                                aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                        <h4 class="modal-title" id="myLargeModalLabelAdd">片区信息</h4>
                                    </div>
                                    <form action="${ctx}/admin/usermanage/saveUserCommunity" method="POST" id="addUserCommunityFrm">
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="row static-info" id="communityAdd">
                                                        <div class="col-md-3 col-xs-4 name"><span class="text-danger">*</span>小区:</div>
                                                        <div class="col-md-9 col-xs-12 value">
                                                            <div class="my-display-inline-box">
                                                                <select class="form-control" name="communityid" id="communityid"
                                                                        onchange="queryBuildingnoesByCommunityid()"
                                                                        data-required="true"
                                                                >
                                                                    <c:if test="${fn:length(partialCommunityList) > 0}">
                                                                        <option value="">--请选择小区--</option>
                                                                    </c:if>
                                                                    <c:forEach items="${partialCommunityList}" var="community">
                                                                        <option value="${community.uuid}">${community.name}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div></div>
                                                    </div>
                                                    <div class="row static-info">
                                                        <div class="col-md-3 col-xs-4 name">楼栋号:</div>
                                                        <div class="col-md-9 col-xs-12 value">
                                                            <div class="row col-sm-12 checkbox i-checks hidden" id="sltAllDiv">
                                                                <label class="checkbox m-n col-sm-3">
                                                                    <input type="checkbox" name="sltAll" value="" id="sltAllBlknoes"
                                                                           onclick="selectAllOrNone('blknos','sltAllBlknoes')"><i></i>全选
                                                                </label>
                                                            </div>
                                                            <div class="row col-sm-12" style="padding-left: 0px">
                                                                <div class="row col-sm-12">
                                                                    <div class="checkbox i-checks " id="buildingnoes"
                                                                         onclick="modifySelectAllOrNone('blknos','sltAllBlknoes')"></div>
                                                                </div>
                                                                <%--<div class="row col-sm-12 text-right" style="margin-top: 8px">--%>
                                                                    <%--<a href="javascript:showOrHideBuildingnoes('OPEN')" class=" text-info" id="openBuildingnoes">展开》</a>--%>
                                                                    <%--<a href="javascript:showOrHideBuildingnoes('CLOSE')" class=" text-info hidden" id="closeBuildingnoes">《收起</a>--%>
                                                                <%--</div>--%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="hidden">
                                                        <input type="hidden" name="userid" value="${platformUser.uuid}">
                                                        <input type="hidden" name="uuid" id="userComId">
                                                        <input name="queryCommunityid" id="queryCommunityid" value="${queryCommunityid}" type="hidden">
                                                        <input name="queryUsername" id="queryUsername" value="${queryUsername}" type="hidden">
                                                        <input name="queryName" id="queryName" value="${queryName}" type="hidden">
                                                        <input name="queryTopAccount" id="queryTopAccount" value="${queryTopAccount}" type="hidden">
                                                        <input name="wechatUserInfoId" id="wechatUserInfoId" value="${wechatUserInfoId}" type="hidden">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer" style="text-align: center;border: 0;margin: 0;padding: 0 20px 20px 20px;">
                                                <a href="javascript:saveUserCommuintyInfo()"
                                                   class="btn btn-submit btn-s-md a-noline" style="color: #fff"
                                                   id="submitAddBtn"
                                                >提交</a>
                                                <a href="javascript:deleteUserCommunityInfo($('#userComId').val(), '${platformUser.uuid}')" type="button"
                                                   class="btn btn-s-md btn-yellow a-noline hidden" style="color:white" id="deleteBtn">
                                                    删除</a>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <!-- /.modal-content -->
                            </div>
                            <!-- /.modal-dialog -->
                        </div>
                        <!-- /.modal -->
                    </c:if>
            </div>
        </section>
        <!-- /.modal -->
        <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-lg" style="margin-top: 15%">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" id="modelCloseBtn"><span
                                aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title" id="myLargeModalLabel">修改</h4>
                    </div>
                    <form class="form-horizontal" data-validate="parsley" action=""
                          method="POST" id="newUsernamefrm">
                        <div class="modal-body">
                            <div class="row">
                                <label class="col-sm-3 control-label">用户名：</label>
                                <div class="col-sm-9">
                                    <input type="text" style="margin-top: 12px;" class="form-control" data-required="true" name="newUsername" id="newUsername" data-maxlength="30"
                                           onblur="validateChineseText(30, this, 'newUsernameError')" value="${platformUser.username}"/>
                                    <span id="newUsernameError" class="text-danger"></span>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer" style="text-align: center">
                            <a href="javascript:changeUsername($('#hidPlatformUserId').val(),$('#hidVersionno').val())"
                               class="btn btn-submit btn-s-md a-noline"
                            >保存</a>
                        </div>
                    </form>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->



        <!-- /.modal -->
        <div class="modal fade bs-example-modal-lg-reset" tabindex="-1" role="dialog"
             aria-labelledby="myLargeModalLabelForReset"
             aria-hidden="true"
             id="bs-example-modal-lgid-reset">
            <div class="modal-dialog modal-lg" style="margin-top: 15%">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" id="modelCloseBtnForReset"><span
                                aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title" id="myLargeModalLabelForReset">重置</h4>
                    </div>
                    <form class="form-horizontal" data-validate="parsley" action=""
                          method="POST" id="passwordfrm"
                          onsubmit="return checkFileType()">
                        <div class="modal-body">
                            <div class="row">
                                <label class="col-sm-3 control-label">密码：</label>
                                <div class="col-sm-9">
                                    <input type="password" style="margin-top: 12px;" class="form-control"  name="password" id="password" data-maxlength="30"
                                           onblur="checkPassword(this.value)" value=""/>
                                </div>
                            </div>
                            <div class="row">
                                <label class="col-sm-3 control-label">确认密码：</label>
                                <div class="col-sm-9">
                                    <input type="password" style="margin-top: 12px;" class="form-control"  name="checkpassword" id="checkpassword" data-maxlength="30"
                                           onblur="checkPassword(this.value)" value=""/>
                                    <span id="passwordError" class="text-danger"></span>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer" style="text-align: center">
                            <a href="javascript:resetPassword($('#hidPlatformUserId').val(),$('#hidVersionno').val(),$('#password').val())"
                               class="btn btn-submit btn-s-md a-noline"
                            >保存</a>
                        </div>
                    </form>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>
<%--<script src="${ctx}/static/admin/js/sweetalert.min.js"></script>--%>
<script src="${ctx}/static/admin/js/qikoo/qikoo.js"></script>
<script type="text/javascript">
        if('district' != '${querytype}'){
            var options = {
                url: function(phrase) {
                    //解决IE get 中文乱码
                    return encodeURI("${ctx}/admin/usermanage/getStaffInfoByName?name=" + phrase);
                },

                getValue: "openid",

                list: {
                    maxNumberOfElements: 10
                },

                template: {
                    type: "description",
                    fields: {
                        description: "name"
                    }
                }
            };
            $("#openid").easyAutocomplete(options);
        }
        //检查返回时用户是否有片区信息
        function backRoleDistribute(){
            var communityid = $('#queryCommunityid').val();
            var username = $('#queryUsername').val();
            var name = $('#queryName').val();
            var topAccount = $('#queryTopAccount').val();

            if('${platformUser.uuid}'=='' || '${view}'=='1'){
                window.location.href = "<%=request.getContextPath()%>/admin/usermanage/roleDistribute?communityid="+communityid+"&username="+username+"&name="+name+"&topAccount="+topAccount;
            }else{
                var url = "${ctx}/admin/usermanage/checkIfUserCommunity?userId=${platformUser.uuid}";
                $.get(url,function(data,status){
                    if(data.checkIfUserCommunityFlag == 'N'){
                        qikoo.dialog.confirm('未添加片区信息，确定返回？',function(){
                            //确定
                            window.location.href = "<%=request.getContextPath()%>/admin/usermanage/roleDistribute?communityid="+communityid+"&username="+username+"&name="+name+"&topAccount="+topAccount;
                        },function(){
                            //取消
                        });
                    }else{
                        window.location.href = "<%=request.getContextPath()%>/admin/usermanage/roleDistribute?communityid="+communityid+"&username="+username+"&name="+name+"&topAccount="+topAccount;
                    }
                });
            }


        }

    //提交用户信息
    function submitUserInfo(){
        //检查用户名
        var usernameValid = validateChineseText(30, document.getElementById('username'), 'usernameError');
         //检查姓名
        var nameValid = validateChineseText(90, document.getElementById('name'), 'nameError');
        //检查小区的合法性
//        var communityValid = checkCommunity();

        return usernameValid && nameValid;
    }


        function changeUsername(platformUserId,versionno){
            var communityid = $('#queryCommunityid').val();
            var username = $('#queryUsername').val();
            var name = $('#queryName').val();
            var topAccount = $('#queryTopAccount').val();
            window.location.href = "${ctx}/admin/usermanage/changeUsername?newUsername="+$('#newUsername').val()+"&platformUserId="+platformUserId+"&versionno="+versionno+"&queryCommunityid="+communityid+"&queryUsername="+username+"&queryName="+name+"&queryTopAccount="+topAccount;
        }
        function resetPassword(platformUserId,versionno,password){
            var communityid = $('#queryCommunityid').val();
            var username = $('#queryUsername').val();
            var name = $('#queryName').val();
            var topAccount = $('#queryTopAccount').val();
            $("#passwordfrm").parsley("validate");

            if($('#passwordfrm').parsley().isValid()){
                if(checkPassword(password)){
                    passwordfrm.action = "${ctx}/admin/usermanage/resetPassword?platformUserId="+platformUserId+"&versionno="+versionno+"&queryCommunityid="+communityid+"&queryUsername="+username+"&queryName="+name+"&queryTopAccount="+topAccount;
                    passwordfrm.submit();
                }
            }
        }
        function changeUserStatus(platformUserId,versionno,querytype){
            var communityid = $('#queryCommunityid').val();
            var username = $('#queryUsername').val();
            var name = $('#queryName').val();
            var topAccount = $('#queryTopAccount').val();
            if(${allCommunities && platformUser.status == 'FREEZE'}){
                var url = "${ctx}/admin/usermanage/checkIfUserCommunity?userId="+platformUserId;
                $.get(url,function(data,status){
                    if(data.checkIfUserCommunityFlag == 'N'){
                        qikoo.dialog.confirm('未添加片区信息，确定生效？',function(){
                            //确定
                            window.location.href = "${ctx}/admin/usermanage/changeUserStatus?platformUserId="+platformUserId+"&versionno="+versionno+"&querytype="+querytype+"&queryCommunityid="+communityid+"&queryUsername="+username+"&queryName="+name+"&queryTopAccount="+topAccount;
                        },function(){
                            //取消
                        });
                    }else{
                        window.location.href = "${ctx}/admin/usermanage/changeUserStatus?platformUserId="+platformUserId+"&versionno="+versionno+"&querytype="+querytype+"&queryCommunityid="+communityid+"&queryUsername="+username+"&queryName="+name+"&queryTopAccount="+topAccount;
                    }
                });
            }else{
                window.location.href = "${ctx}/admin/usermanage/changeUserStatus?platformUserId="+platformUserId+"&versionno="+versionno+"&querytype="+querytype+"&queryCommunityid="+communityid+"&queryUsername="+username+"&queryName="+name+"&queryTopAccount="+topAccount;
            }

        }
        //验证密码合法性
        function checkPassword(userPassword){
            var passwordError = document.getElementById("passwordError");
            passwordError.innerText = "";
            var pwdRes = /^[A-Za-z0-9_#@]{6,16}$/;
            //var pwdRes = /((?!^\\d+$)(?!^[a-zA-Z]+$)(?!^[_#@]+$)){8,}/;
            if(!pwdRes.test(userPassword)){
                passwordError.innerText = "该项只能输入字母、数字及特殊符号（_#@），且只能输入6-16位";
                return false;
            }
            var password = $('#password').val();
            var checkpassword = $('#checkpassword').val();
            if(password != checkpassword){
                passwordError.innerText = "两次密码输入不一致！";
                return false;
            }



            return true;
        }
        function checkPhone(phone) {
            var contactnoError = document.getElementById('contactnoError');
            contactnoError.innerHTML = "";
            trimText(document.getElementById('cellphone'));
            var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
            if (!myreg.test(phone)) {
                contactnoError.innerHTML = "请输入正确的手机号！";
                return false;
            } else {
                return true;
            }
        }
        //保存uuid和versionno
        function saveUuidAndVersionno(platformUserId, versionno) {
            $('#hidPlatformUserId').val(platformUserId);
            $('#hidVersionno').val(versionno);
        }
        //自动查询职位
        function autoQueryPlatformUserTitleList(obj,inputFlag,callback){
            trimText(obj);
            if($(obj).val().length >= 1){
                queryPlatformUserTitleList(inputFlag, callback);
            }
        }
        //查询已有的职位列表
        function queryPlatformUserTitleList(inputFlag, callback){
            trimText(document.getElementById('platformUserTitle'));
            var url = "${ctx}/admin/usermanage/queryPlatformUserTitleList?platformUserTitle=" + $('#platformUserTitle').val();
            $.get(url
                    ,function(data,status){
                        $('#platformUserTitleUl').html('');
                        if(data.platformUserTitleList.length > 0){
                            $('#platformUserTitleUl').removeClass('hidden');
                            $('#platformUserTitleClose').removeClass('hidden');
                        }else{
                            $('#platformUserTitleUl').addClass('hidden');
                            $('#platformUserTitleClose').addClass('hidden')
                        }

                        for(var i=0; i<data.platformUserTitleList.length; i++){
                            $('#platformUserTitleUl').append('<li class="pading">' + data.platformUserTitleList[i] + '</li>');
                        }

                        $('.pading').on('click', function(){
                            $('#platformUserTitle').val($(this).text());
                            if(undefined != callback){
                                callback();
                            }
                            $('#platformUserTitleUl').addClass('hidden');
                            $('#platformUserTitleClose').addClass('hidden')
                        });
                        $('#platformUserTitleClose').on('click', function(){
                            $('#platformUserTitleUl').addClass('hidden');
                            $('#platformUserTitleClose').addClass('hidden')
                        });
                    });
        }

    //检查小区的合法性
    function checkCommunity(){
        var title = $("select[name='title'] option:selected").val();
        var communityid = $("select[name='communityid'] option:selected").val();
        var communityidError = document.getElementById('communityidError');
        communityidError.innerText = '';
        //选择了工程人员时，小区必填
        if(title == 'ENGINEERING_PERSON' && communityid.length == 0 ){
            communityidError.innerText = '该项为必填项';
            return false;
        }

        return true;
    }


    //查询小区中的栋/幢
    function queryBuildingnoesByCommunityid(userCommunityId){
        //选择的小区
        var communityid = $('#communityid').val();
        //已选
        if(undefined != communityid && communityid.length > 0){
            //显示栋/幢
            $('#buildingnoesDiv').removeClass('hidden');
            $.get("${ctx}/admin/usermanage/queryBuildingnoByCommunityId?communityId="+communityid+"&userId=${platformUser.uuid}"+"&userCommunityId="+userCommunityId,function(data,status){
                var buildingnoList = data.buildingnoList;
                var managedBuildingnoes = data.managedBuildingnoes;
                var managedCommunityId = data.managedCommunityId;
                $("#buildingnoes").empty();
                for(i=0;i<buildingnoList.length;i++){
                    var managed = false;
                    if(managedBuildingnoes != null){
                        for(j=0; j<managedBuildingnoes.length; j++){
                            if(buildingnoList[i].buildingno == managedBuildingnoes[j]){
                                managed = true;
                                break;
                            }
                        }
                    }

                    if(communityid === managedCommunityId && managed){
                        $("#buildingnoes").append( '<label class="checkbox m-n col-sm-4">' +
                                '<input type="checkbox" name="blknos" checked value="'+buildingnoList[i].buildingno+'" ><i></i>'+formatBuildingno(buildingnoList[i].buildingno)+
                                '</label>');
                    }else{
                        $("#buildingnoes").append( '<label class="checkbox m-n col-sm-4">' +
                                '<input type="checkbox" name="blknos" value="'+buildingnoList[i].buildingno+'" ><i></i>'+formatBuildingno(buildingnoList[i].buildingno)+
                                '</label>');
                    }

                }
            });
        }else{
            var sltAllBlknoes = document.getElementById('sltAllBlknoes');
            if(null != sltAllBlknoes && undefined != sltAllBlknoes){
                //初始化栋幢全选复选框
                sltAllBlknoes.checked = false;
            }

            //清空栋幢
            $("#buildingnoes").empty();
            //隐藏栋/幢
            $('#buildingnoesDiv').addClass('hidden');
        }
    }

    window.onload = function(){
        //显示父菜单
        showParentMenu('用户');

        if('district' != '${querytype}'){
            checkFinantion();
            showGroup('${platformUser.groupId}');
        }
    }

    function resubmitSearch(page){
        <%--window.location.href = "<%=request.getContextPath()%>/admin/usermanage/userInfo?userId=${platformUser.uuid}&page="+page;--%>
        var frm = document.getElementById('frm');
        frm.action = "${ctx}/admin/usermanage/saveUserInfo?page=" + page;
        frm.submit();
    }

    function sendTestMessage(){
        var openid = document.getElementById("openid").value;
        if(openid==null||openid==""){
//            swal({
//                title: "微信openid不能为空",
//                type: "warning"
//                })
            qikoo.dialog.alert("微信openid不能为空");
        }else{
            <%--swal({--%>
                <%--title: "确定发送模板?",--%>
                <%--text: "你将发送一个消息至此微信openid!",--%>
                <%--type: "warning",--%>
                <%--showCancelButton: true,--%>
                <%--confirmButtonColor: "#DD6B55",--%>
                <%--confirmButtonText: "确定"--%>
            <%--}, function(isConfirm){--%>
                <%--if(isConfirm){--%>
                    <%--$.get("${ctx}/admin/usermanage/sendMessageToOpenid?openid="+openid,function(data,status){--%>

                        <%--if(data.successMessage != undefined || data.errorMessage != undefined){--%>
                            <%--if(data.successMessage != undefined){--%>
                                <%--$("#successMessage").text(data.successMessage);--%>
                            <%--}--%>
                            <%--if(data.errorMessage != undefined){--%>
                                <%--$("#errorMessage").text(data.errorMessage);--%>
                            <%--}--%>
                        <%--}--%>
                    <%--});--%>
                <%--}--%>
                <%--return;--%>
            <%--});--%>
            qikoo.dialog.confirm('确定发送模板？',function(){
                //确定
                $.get("${ctx}/admin/usermanage/sendMessageToOpenid?openid="+openid,function(data,status){

                    if(data.successMessage != undefined || data.errorMessage != undefined){
                        if(data.successMessage != undefined){
                            $("#successMessage").text(data.successMessage);
                        }
                        if(data.errorMessage != undefined){
                            $("#errorMessage").text(data.errorMessage);
                        }
                    }
                });
            },function(){
                //取消
            });
        }
    }

    function checkFinantion(){
       var chooseValues = document.getElementsByName("roles");
        console.log(chooseValues);
       for(var i =0;i<chooseValues.length;i++){
            if(chooseValues[i].checked && chooseValues[i].value == "2015122500000001"){
                document.getElementById("finantionId").style.display="block";
                return;
           }
       }
        document.getElementById("finantionId").style.display="none";
    }

    function showGroup(obj){
        if(obj !=null && obj !=""){
            $('#wechatGroupId').css('display','block');
        }else{
            $('#wechatGroupId').css('display','none');
        }
    }

    //检查是否已关注
    function checkIfSubscribe(){
        var openid = document.getElementById("openid").value.trim();
        var subscribeInfo = document.getElementById("subscribeInfo");
        subscribeInfo.innerHTML = "";
        if(openid.length > 0){
            //确定
            $.get("${ctx}/admin/usermanage/checkIfSubscribe?openid="+openid+"&version="+Math.random(),function(data,status){

                if(data.subscribeFlag != undefined && data.subscribeFlag == 1){
                    subscribeInfo.innerHTML = "已关注 - " + data.nickname;
                }else{
                    subscribeInfo.innerHTML = "未关注";
                }
            });
        }
    }
    if('district' != '${querytype}'){
        checkIfSubscribe();
    }

    //全选 或 全不选
    function selectAllOrNone(communityid, sltAll){
        var communityids = document.getElementsByName(communityid);
        for(var i=0; i<communityids.length; i++){
            //全选
            if(document.getElementById(sltAll).checked){
                if(!communityids[i].checked){
                    communityids[i].checked = true;
                }
            }else{
                //全不选
                if(communityids[i].checked){
                    communityids[i].checked = false;
                }
            }
        }
        //点击小区的全选时
        if('communityid' == communityid){
            //清空栋幢
            $("#buildingnoes").empty();
            //隐藏栋/幢
            $('#buildingnoesDiv').addClass('hidden');
        }
    }

    //修改全选、全不选
    function modifySelectAllOrNone(communityid,sltAll){
        var communityids = document.getElementsByName(communityid);
        //小区选择的个数
        var sltCount = querySltCount(communityid);
        if(sltCount == communityids.length){
            var sltAllChk = document.getElementById(sltAll);
            if(undefined != sltAllChk && null != sltAllChk){
                sltAllChk.checked = true;
            }
        }else{
            var sltAllChk = document.getElementById(sltAll);
            if(undefined != sltAllChk && null != sltAllChk){
                sltAllChk.checked = false;
            }
        }
    }

    //显示或隐藏栋/幢
    function showOrHideBuildingnoes(type){
        if(type == 'OPEN'){
            $('#openBuildingnoes').addClass('hidden');
            $('#closeBuildingnoes').removeClass('hidden');
            $('#buildingnoes').removeClass('hidden');
        }else{
            $('#openBuildingnoes').removeClass('hidden');
            $('#closeBuildingnoes').addClass('hidden');
            $('#buildingnoes').addClass('hidden');
        }
    }

    //小区选择的个数
    function querySltCount(communityid){
        var communityids = document.getElementsByName(communityid);
        var sltCount = 0;
        for(var i=0; i<communityids.length; i++){
            if(communityids[i].checked){
                sltCount ++;
            }
        }
        return sltCount;
    }

    //根据角色查询权限
    function queryPermitListByRoleId(obj, roleId){
        $('.permit-list').hide();
        $.get("${ctx}/admin/usermanage/queryPermitListByRoleId?roleId="+roleId,function(data,status){
            var permitList = data.permitList;
            if(undefined != data.permitList.length && data.permitList.length > 0){
                var htmlStr = "";
                for(var i=0; i< permitList.length; i++){
                    var childHtmlStr = "";
                    if(undefined != permitList[i].childPermits){
                        for(var j=0; j<permitList[i].childPermits.length; j++){
                            childHtmlStr += "<span style='margin-left: 10px'>" + permitList[i].childPermits[j].permitname + "</span>";
                        }
                    }
                    htmlStr += "<div class='font-bold'>" + permitList[i].permitname+ "</div><div style='padding-left: 10px'>" + childHtmlStr +"</div>";
                }
                $(obj).parent().parent().find(".permit-list").html(htmlStr);
                $(obj).parent().parent().find(".permit-list").show();
            }
        });
    }

    //隐藏权限列表
    function hidePermitList(obj){
        $(obj).parent().parent().find(".permit-list").hide();
    }

    //切换选项卡
    function toggleTab(tabId){
        var communityid = $('#queryCommunityid').val();
        var username = $('#queryUsername').val();
        var name = $('#queryName').val();
        var topAccount = $('#queryTopAccount').val();
        var wechatUserInfoId = $('#wechatUserInfoId').val();
        window.location.href = "<%=request.getContextPath()%>/admin/usermanage/userInfo?userId=${platformUser.uuid}&querytype="+tabId+"&communityid="+communityid+"&username="+username+"&name="+name+"&topAccount="+topAccount+"&wechatUserInfoId="+wechatUserInfoId;
    }

    //保存片区信息
    function saveUserCommuintyInfo(){
        $("#addUserCommunityFrm").parsley("validate");
        //检查支信息合法性
        if($('#addUserCommunityFrm').parsley().isValid()){
            $('#addUserCommunityFrm').submit();
        }
    }

    //显示片区信息
    function showUserCommunityInfo(userCommunityId){
        //修改
        if(undefined != userCommunityId){
            $.get("${ctx}/admin/usermanage/queryUserCommunityInfo?userCommunityId="+userCommunityId+"&version=" + Math.random(),function(data,status){
                if(undefined != data.wpUserCommunity){
                    $('#communityid>option').remove('.updateCom');
                    $('#communityid').append($("<option>").val(data.wpUserCommunity.communityid).text(data.wpUserCommunity.communityname).addClass('updateCom'));
                    $('#communityid').val(data.wpUserCommunity.communityid);
                    $('#userComId').val(data.wpUserCommunity.uuid);
                    //查询小区中的栋/幢
                    queryBuildingnoesByCommunityid(userCommunityId);
                }
            });
            //显示删除按钮
            $('#deleteBtn').removeClass('hidden');
        }else{
            //添加
            $('#communityid>option').remove('.updateCom');
            $('#communityid').val("");
            //清空栋幢
            $("#buildingnoes").empty();
            //隐藏栋/幢
            $('#buildingnoesDiv').addClass('hidden');
            //隐藏删除按钮
            $('#deleteBtn').addClass('hidden');
        }
    }

    //删除片区信息
    function deleteUserCommunityInfo(userComId, userId){
        var communityid = $('#queryCommunityid').val();
        var username = $('#queryUsername').val();
        var name = $('#queryName').val();
        var topAccount = $('#queryTopAccount').val();
        if(confirm("确定删除?")){
            //确定
            window.location.href = "<%=request.getContextPath()%>/admin/usermanage/deleteUserCommunity?userId="+userId+"&userComId="+userComId+"&queryCommunityid="+communityid+"&queryUsername="+username+"&queryName="+name+"&queryTopAccount="+topAccount;
        }
    }
</script>

</body>
</html>