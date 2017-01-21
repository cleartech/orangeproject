<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
    body {
        padding-top: 70px;
        background-color: #ffffff;
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

    img {
        max-width: 100%;
        height: auto;
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

    * {
        border-radius: 0 !important;
    }

    .btn-default {
        color: #ffffff;
        background-color: #1a9b9b;
        border-color: #1a9b9b;
    }

    .btn-default:hover, .btn-default:focus, .btn-default:active, .btn-default:active:focus {
        color: #ffffff;
        background-color: #136e6e;
        border-color: #136e6e;
        outline: none !important;
    }

</style>

<script>
    function copyToClipboard(text) {
        window.prompt("Copy to clipboard: Ctrl+C, Enter", text);
    }

    $(document).ready(function () {
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>

<html>
<head>
    <title>MyPhotos - image hosting</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <c:set var="req" value="${pageContext.request}"/>
    <c:set var="url">${req.requestURL}</c:set>
    <c:set var="uri" value="${req.requestURI}"/>

</head>
<link rel="icon" type="image/x-icon" href="/resources/fav16x16.png">
<body>

<!--Navbar-->
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
                #myphoto</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="<c:url value="/browse/albums/latest/1" />"><spring:message code="browse"/></a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <sec:authorize var="loggedIn" access="isAnonymous()">
                    <li><a href="<c:url value="/login" />"><spring:message code="log_in"/></a></li>
                    <li><a href="<c:url value="/register" />"><spring:message code="register"/></a></li>
                </sec:authorize>
                <li><a href="<c:url value="/register" />"><spring:message code="register"/></a></li>
                <c:choose>
                    <c:when test="${pageContext.response.locale == 'ua'}">
                        <li><a href="#" class="language">UA</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="#" class="language">EN</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</div>
<!--Navbar-->

<!--Header-->
<div class="container col-md-12" align="center">
    <h1 style="color: #1a9b9b; font-weight: 100;"><spring:message code="grab_your_link"/></h1>
</div><!--Header-->

<!--Link-->
<div class="container col-md-6 col-md-offset-3" align="center" style="margin-bottom: .5em;">
    <div class="input-group input-group-sm">
        <input type="text" readonly class="form-control text-center" aria-label="..." id="link"
               value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/view-item/${item.uId}">
        <span class="input-group-btn">
            <button class="btn btn-default" type="button" data-toggle="tooltip"
                    title="<spring:message code="copy_link_to_clipboard"/>"
                    onclick="copyToClipboard(document.getElementById('link').value)">
                <span class="glyphicon glyphicon-duplicate"></span>
            </button>
      </span>
    </div>
</div><!--Header-->

<!--Info-->
<div class="container col-md-12" align="center">
    <div class="row" style="margin-bottom: 1.5em;">
        <small class="form-text text-muted"><spring:message code="copy_link"/></small>
    </div>
</div><!--Info-->

<!--Buttons-->
<div class="container col-md-12" align="center" style="margin-bottom: 1em;">
    <div class="col-md-12" align="center">
        <input class="btn btn-danger" type="submit" value="<spring:message code="delete_photo"/>"
               onclick="window.location='/delete-photo/${item.uId}';"/>
        <input class="btn btn-active" type="submit" value="<spring:message code="upload_new"/>"
               onclick="window.location='/';"/>
    </div>
</div><!--Buttons-->

<!--Photo-->
<div class="container col-md-12" style="margin-bottom: 3em;">
    <div class="row">
        <div class="col-md-10">
            <img src="/view-item/${item.uId}"/>
        </div>
        <div class="col-md-2"><!--Photo info-->

            <small style="color: #8a8a8a; font-weight: 100;">
                <span class="glyphicon glyphicon-picture"></span> ${fn:toUpperCase(name)}</small>
            <small style="color: #8a8a8a; font-weight: 100;"><br/>
                <span class="glyphicon glyphicon-paperclip"></span> ${type}</small>
            <small style="color: #8a8a8a; font-weight: 100;"><br/>
                <span class="glyphicon glyphicon-tag"></span> ${size}</small>
            <small style="color: #8a8a8a; font-weight: 100;"><br/>
                <span class="glyphicon glyphicon-fullscreen"></span> ${dimension}</small>
        </div>
    </div><!--Photo info-->
</div><!--Photo-->
<div id="footer">
    &copy 2016 #myphotos
</div>
</body>
</html>
