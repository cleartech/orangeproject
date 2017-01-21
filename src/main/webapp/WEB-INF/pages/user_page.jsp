<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
    body {
        padding-top: 70px;
        background-color: #ffffff;

    }

    .glyphicon.glyphicon-user {
        font-size: 2.5em;
    }

    .navbar-custom {
        background-color: #1a9b9b;
        color: #ffffff;
        border-radius: 0;
        border-color: #1a9b9b;
    }

    .navbar-custom .navbar-nav > li > a {
        color: #ffffff;
    }

    .navbar-custom .navbar-nav > li > a:hover {
        background-color: #136e6e;
    }

    .navbar-custom .navbar-nav > .active > a, .navbar-nav > .active > a:hover, .navbar-nav > .active > a:focus {
        color: #ffffff;
        background-color: #136e6e;
    }

    .navbar-custom .navbar-nav > .active > a:hover {
        background-color: #136e6e;
    }

    .navbar-custom .navbar-brand {
        color: #ffffff;
    }

    .navbar-custom .navbar-brand:hover {
        color: #e4e4e4;
    }

    .navbar-nav > li > .dropdown-menu {
        background-color: #1a9b9b;
    }

    .navbar-nav > li > .dropdown-menu a {
        color: #ffffff;
    }

    .navbar-nav > li > .dropdown-menu a:hover {
        background-color: #136e6e;
    }

    .navbar .nav > li.dropdown.open.active > a:hover,
    .navbar .nav > li.dropdown.open > a {
        color: #fff;
        background-color: #136e6e;
        border-color: #fff;
    }

    .navbar-inverse .navbar-toggle:hover {
        background-color: #136e6e;
    }

    .navbar-inverse .navbar-toggle {
        border-color: #1a9b9b;
    }

    .navbar-inverse .navbar-toggle:focus {
        background-color: #136e6e;
    }

    .btn-active {
        color: #ffffff;
        background-color: #1a9b9b;
        border-color: #1a9b9b;
        margin-top: .1em;
        margin-bottom: .1em;
        min-width: 10em;
    }

    .btn-active:hover, .btn-active:focus, .btn-active:active, .btn-active:active:focus, .btn-active.active, .open > .dropdown-toggle.btn-active {
        color: #ffffff;
        background-color: #136e6e;
        border-color: #136e6e;
        outline: none !important;
    }

    * {
        border-radius: 0 !important;
    }

    #footer {
        position: fixed;
        width: 100%;
        text-align: center;
        bottom: 0;
        background-color: #1a9b9b;
        height: 2em;
        left: 50%;
        transform: translateX(-50%);
        padding-top: .2em;
        color: #ffffff;
        z-index: 2;
    }

    .h4special {
        color: #1a9b9b;
        font-weight: 100;
        text-transform: uppercase;
    }

    .panel-default {
        -moz-box-shadow: 0 0 10px #ccc;
        -webkit-box-shadow: 0 0 10px #ccc;
        box-shadow: 0 0 10px #ccc;
    }

    .green-heading {
        background: #5cb85c;
        height: .2em;
    }

    .avatar {
        text-align: center;
        margin: 1em;
    }

</style>

<html>
<head>
    <title>MyPhotos - profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<link rel="icon" type="image/x-icon" href="/resources/fav16x16.png">
<body>
<%--Navbar--%>
<div class="navbar navbar-custom navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/">
                <sec:authorize var="loggedIn" access="isAuthenticated()">
                    ${pageContext.request.userPrincipal.name} @
                </sec:authorize>
                #myphotos</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <sec:authorize var="loggedIn" access="isAuthenticated()">
                    <li><a href="<c:url value="/albums/page/1" />"><spring:message code="albums"/></a></li>
                    <li><a href="<c:url value="/messages/inbox/page/1" />"><spring:message code="messages"/></a></li>
                    <li><a href="<c:url value="/comments/1" />"><spring:message code="comments"/></a></li>
                    <li><a href="<c:url value="/favorites/page/1" />"><spring:message code="favorites"/></a></li>
                </sec:authorize>
                <li><a href="<c:url value="/browse/albums/latest/1" />"><spring:message code="browse"/></a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <sec:authorize var="loggedIn" access="isAuthenticated()">
                    <li>
                        <c:url value="/logout" var="logoutUrl"/>
                        <a href="${logoutUrl}"><spring:message code="log_out"/></a>
                    </li>
                </sec:authorize>
                <sec:authorize var="loggedIn" access="isAnonymous()">
                    <li><a href="<c:url value="/login" />"><spring:message code="log_in"/></a></li>
                    <li><a href="<c:url value="/register" />"><spring:message code="register"/></a></li>
                </sec:authorize>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"
                       role="button" aria-expanded="false">${fn:toUpperCase(pageContext.response.locale)}
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu inverse-dropdown" role="menu">
                        <c:choose>
                            <c:when test="${pageContext.response.locale == 'ua'}">
                                <li><a href="?lang=en" class="language"><spring:message code="english"/></a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="?lang=ua" class="language"><spring:message code="ukrainian"/></a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</div>
<%--Navbar--%>

<div class="container" align="center">
    <div class="col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 1em;">
        <h1 style="color: #1a9b9b; font-weight: 100;"><spring:message code="profile_page"/></h1>
    </div>
</div>

<c:if test="${param.emptyMessage ne null}">
    <div align="center">
        <div class="container">
            <div class="alert alert-danger alert-dismissible col-md-12" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <spring:message code="fail_sent_empty_message"/>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${param.sent ne null}">
    <div align="center">
        <div class="container">
            <div class="alert alert-success alert-dismissible col-md-12" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <spring:message code="message_sent"/>
            </div>
        </div>
    </div>
</c:if>

<div class="col-md-6 col-md-offset-3" style="margin-top: 1em; margin-bottom: 3em;">
    <div class="panel panel-default">
        <div class="green-heading"></div>
        <div class="avatar col-md-3">
            <span class="glyphicon glyphicon-user" style="margin-top: 0.5em;"></span>
            <c:set var="login" value="${targetLogin}"/>
            <c:choose>
                <c:when test="${fn:length(login) gt 2}">
                    <c:set var="login" value="${fn:toUpperCase(fn:substring(login, 0, 2))}"/>
                </c:when>
                <c:otherwise>
                    <c:set var="login" value="${fn:toUpperCase(login)}"/>
                </c:otherwise>
            </c:choose>
            <h3>${login}</h3>
            <hr/>
            <h6 style="color: #1a9b9b;">#MYPHOTO <span style="color: #8f8f8f;"> CITIZEN</span></h6>
        </div>
        <div class="h4special" style="margin: 1.5em"><h4><spring:message code="profile_card"/></h4>
            <h5 style="font-size: 1em; color: #a8a8a8; line-height: 1.25em;">
                <spring:message code="login_name"/>: ${targetLogin}<br/>
                <fmt:formatDate value="${registrationDate}"
                                type="date"
                                pattern="dd.MM.yyyy"
                                var="registrationDate"/>
                <spring:message code="citizen_since"/>: ${registrationDate}<br/>
                <spring:message code="albums"/>: ${fn:length(albums)}<br/>
                <spring:message code="photos"/>: ${fn:length(items)}
            </h5>
            <div class="panel-body" align="right" style="margin-bottom: -1.5em; margin-right: -.5em;">
                <a href="#" class="btn btn-active" onclick="window.location='/${targetLogin}/albums/page/1';">
                    <spring:message code="view_albums"/></a>
                <sec:authorize var="loggedIn" access="isAuthenticated()">
                    <c:if test="${targetLogin ne pageContext.request.userPrincipal.name}">
                        <a href="#" class="btn btn-active" onclick="window.location='/messages/new/${targetLogin}';">
                            <spring:message code="send_message"/></a>
                    </c:if>
                </sec:authorize>
            </div>
        </div>
    </div>
</div>

<div id="footer">
    &copy 2016 #myphotos
</div>

</body>
</html>
