<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en" class="app">
<head>

</head>
<body class="">

<section id="content" class="bg-white">
    <section class="vbox">
        <section class="scrollable">
            <header class="panel-heading bg-white text-md b-b">
                自动回复 / <span class="font-bold  text-shallowred">关键词自动回复</span>
            </header>
            <div class="col-sm-12 pos">
                <div>
                    <span class="text-success">${successMessage}</span>
                    <span class="text-danger">${errorMessage}</span>
                </div>
                <form class="form-horizontal form-bordered" data-validate="parsley" action="${ctx}/admin/autoRep/keywordRepTxt" method="POST" onsubmit="return addKeywordTxt()" style="margin-top: 20px">
                    <section class="panel panel-default m-n">
                        <header class="panel-heading mintgreen">
                            <i class="fa fa-gift"></i>
                            <span class="text-lg">关键词自动回复图片：</span>
                        </header>
                        <div class="panel-body p-0-15">
                            <div class="checkbox i-checks  form-group no-padder">
                                <label class="col-sm-3"></label>
                                <label class="col-sm-9 b-l bg-white">
                                    <c:if test="${respSetting.reqtype == 'CLICK'}">
                                        <input type="checkbox" name="reqClick" checked style="margin-left: 7px"><i></i> 自定义菜单回复？
                                    </c:if>
                                    <c:if test="${respSetting.reqtype != 'CLICK'}">
                                        <input type="checkbox" name="reqClick" style="margin-left: 7px"><i></i> 自定义菜单回复？
                                    </c:if>
                                </label>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>关键词：</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <textarea class="form-control" rows="6" name="keywords" data-required="true" id="keywords" data-maxlength="30" onblur="checkKeyword()">${respSetting.keywords}</textarea>
                                    <span id="keywordsError" class="text-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><span class="text-danger">*</span>图片:</label>
                                <div class="col-sm-9 b-l bg-white">
                                    <div class="col-sm-10 navbar-left" style="padding-left: 0px">
                                        <input type="text" name="mediaid" class="form-control" data-maxlength="255" id="mediaid"
                                               readonly="true" value="${respSetting.mediaid}" data-required="true"/>
                                    </div>
                                    <div class="col-sm-2 navbar-left" style="padding-left: 0px">
                                        <div class="bs-example">
                                            <a class="btn btn-default" data-toggle="modal" data-target=".bs-example-modal-lg">从图片库选择</a>
                                        </div>
                                    </div>
                                    <div style="clear: both;"></div>
                                    <div class="col-sm-12 top-five
                                    <c:if test="${empty respSetting.imgname}">
                                            hidden
                                    </c:if>
                                    " id="imgDiv">
                                        <c:if test="${not empty respSetting.imgname}">
                                            <img src="${respSetting.imgname}" width="100" height="100">
                                        </c:if>
                                        <c:if test="${empty respSetting.imgname}">
                                            <img width="100" height="100">
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <input type="hidden" name="uuid" value="${respSetting.uuid}">
                                <input type="hidden" name="versionno" value="${respSetting.versionno}">
                                <input type="hidden" name="resptype" value="image">
                            </div>
                        </div>
                        <div class="panel-footer text-left bg-light lter">
                            <button type="submit" class="btn btn-submit btn-s-xs"><i class="fa fa-check"></i>&nbsp;提&nbsp;交</button>
                            <c:if test="${empty respSetting.uuid}">
                                <a href="${ctx}/admin/autoRep/keywordNoMatchRepTxt" class="btn btn-default btn-s-xs">无匹配回复</a>
                                <a href="${ctx}/admin/autoRep/keywordRepTxt" class="btn btn-success btn-s-xs">切换到文本模式</a>
                                <a href="${ctx}/admin/autoRep/keywordRepArticle" class="btn btn-info btn-s-xs">切换到图文模式</a>
                            </c:if>
                        </div>
                    </section>
                </form>
            </div>

            <!-- /.modal -->
            <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">

                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" id="modelCloseBtn"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title" id="myLargeModalLabel">图片库</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <c:if test="${not empty respImageList}">
                                        <c:forEach items="${respImageList}" var="pictrue" varStatus="status">
                                            <div class="col-sm-3 text-center" style="border: 1px dashed #657789; margin-right: 30px; margin-bottom: 30px">
                                                <img src="${pictrue.imgname}" width="100%" height="100"/>
                                                <c:if test="${status.index == 0}">
                                                    <input type="radio" name="pic" checked>
                                                </c:if>
                                                <c:if test="${status.index != 0}">
                                                    <input type="radio" name="pic">
                                                </c:if>
                                                <input type="hidden" value="${pictrue.mediaid}" id="hidPic${status.index}">
                                                <input type="hidden" value="${pictrue.imgname}" id="hidPicUrl${status.index}">
                                            </div>
                                        </c:forEach>
                                        <div style="clear:both"></div>
                                        <div class="col-sm-12 text-right">
                                            <button type="button" class="btn btn-success" onclick="getSelectedPic()">保存</button>
                                        </div>
                                    </c:if>
                                    <c:if test="${empty respImageList}">
                                        抱歉，您还未创建图片库，请先去<a href="${ctx}/admin/autoRep/showPictureLib" class="text-info">创建图片库</a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
        </section>
    </section>
    <a href="#" class="hide nav-off-screen-block" data-toggle="class:nav-off-screen,open" data-target="#nav,html"></a>
</section>

<script type="text/javascript">

    //验证关键词合法性
    function checkKeyword(){
        //清空错误信息
        var keywordsErrorSpan = document.getElementById("keywordsError");
        keywordsErrorSpan.innerHTML = "";

        var keywords =  document.getElementById("keywords").value;
        document.getElementById("keywords").value =  keywords.trim();
        if(keywords !="" && keywords == 'DEFAULT_RESP'){
            keywordsErrorSpan.innerHTML = "该项不能为DEFAULT_RESP";
            return false;
        }
        return true;

    }

    //添加关键词自动回复文本
    function addKeywordTxt(){
        //验证关键词
        var keywordValid = checkKeyword();
        if(!keywordValid){
            return false;
        }
        return true;
    }

    //获取选择的图片
    function getSelectedPic(){
        var mediaid = document.getElementById("mediaid");
        var pics = document.getElementsByName("pic");
        for(var i=0; i<pics.length; i++){
            if(pics[i].checked){
                var hidMediaid = document.getElementById("hidPic"+i);
                var hidPicUrl = document.getElementById("hidPicUrl"+i);
                mediaid.value = hidMediaid.value;
                $('#imgDiv').removeClass('hidden');
                document.getElementById("imgDiv").getElementsByTagName("img")[0].src = "${ctx}/" + hidPicUrl.value;
                break;
            }
        }
        var modelCloseBtn = document.getElementById("modelCloseBtn");
        modelCloseBtn.click();
    }

</script>
</body>
</html>