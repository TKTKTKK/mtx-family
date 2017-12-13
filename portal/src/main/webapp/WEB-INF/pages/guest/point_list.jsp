<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="x-dns-prefetch-control" content="on">
    <title>积分记录</title>
    <link rel="stylesheet" href="${ctx}/static/guest/css/common.css" type="text/css" />
    <style>
        .goal_total{height: 5rem;line-height: 5rem;padding-left: 1.25rem;border-bottom: 1px solid rgba(0,0,0,0.1);font-size: 1.6rem;color: #333;background-color: #fff}
        .goal_total span:nth-of-type(1){border-left: 4px solid #5bbc4e;padding-left: 1.25rem;}
        .goal_total span:nth-of-type(2){float: right;right: 1.25rem;position: relative;color: #faa83d}
        .list{background-color: #fff;color: #333;}
        .list li{border-bottom: 1px solid rgba(0,0,0,0.1);padding: 1.17rem 2rem;}
        .list li p:nth-of-type(1){font-size: 1.6rem;margin-bottom: 0.5rem;display: flex;display: -webkit-flex;justify-content: space-between;}
        .list li p:nth-of-type(2){font-size: 1.2rem;color: #999}
    </style>
</head>
<body>
<div class="head">
    <a href="" class="back"></a>
    <span>积分记录</span>
</div>
<div class="goal_total">
    <span>剩余积分：5000</span>
    <span>已用：670</span>
</div>
<ul class="list">
    <li>
        <p><span>购买2ZS-6K型手扶式插秧机</span><span>+1000</span></p>
        <p><span class="time">2017-12-5</span></p>
    </li>
    <li>
        <p><span>购买2ZS-6K型手扶式插秧机</span><span>+1000</span></p>
        <p><span class="time">2017-12-5</span></p>
    </li>
    <li>
        <p><span>购买2ZS-6K型手扶式插秧机</span><span>+1000</span></p>
        <p><span class="time">2017-12-5</span></p>
    </li>
    <li>
        <p><span>购买2ZS-6K型手扶式插秧机</span><span>+1000</span></p>
        <p><span class="time">2017-12-5</span></p>
    </li>
    <li>
        <p><span>购买2ZS-6K型手扶式插秧机</span><span>+1000</span></p>
        <p><span class="time">2017-12-5</span></p>
    </li>
    <li>
        <p><span>购买2ZS-6K型手扶式插秧机</span><span>+1000</span></p>
        <p><span class="time">2017-12-5</span></p>
    </li>
</ul>
</body>
</html>