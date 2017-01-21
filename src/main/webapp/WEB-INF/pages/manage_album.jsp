<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    body {
        padding-top: 70px;
        background-color: #ffffff;
    }

    #panel-title-header {
        padding-bottom: 10px;
        background-color: rgba(255, 255, 255, 0.4);
        -moz-box-shadow: 0 0 10px #ccc;
        -webkit-box-shadow: 0 0 10px #ccc;
        box-shadow: 0 0 10px #ccc;
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

    .btn-inactive {
        color: #484848;
        background-color: #f2f2f2;
        border-color: #f2f2f2;
        margin-top: .1em;
        margin-bottom: .1em;
        min-width: 10em;
    }

    .btn-inactive:hover, .btn-inactive:focus, .btn-inactive:active, .btn-inactive:active:focus, .btn-inactive.active, .open > .dropdown-toggle.btn-inactive {
        color: #484848;
        background-color: #cecece;
        border-color: #cecece;
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
    }

</style>

<html>
<head>
    <title>MyPhotos - albums</title>
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
                    <li class="active"><a href="<c:url value="/albums/page/1" />"><spring:message code="albums"/></a></li>
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
<%--<sec:authorize var="loggedIn" access="isAnonymous">--%>
<%--<jsp:forward page="/login.jsp"/>--%>
<%--</sec:authorize>--%>
<%--<sec:authorize var="loggedIn" access="isAuthenticated()">--%>
<div class="container" align="center">
    <div class="col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 10px;">
        <h1 style="color: #1a9b9b;"><spring:message code="managing_albums"/></h1>
    </div>
</div>

<div class="row">
    <div class="col-md-4 col-md-offset-4">
        <button class="btn btn-inactive btn-block"
                style="margin-bottom: 1em;"
                onclick="window.location='/albums/page/${currentPage}';"><spring:message code="back"/></button>
    </div>
</div>

<form action="/albums/album-add/${currentPage}" style="margin-left: 0.5em; margin-right: 0.5em;"
      class="form-horizontal" method="post">
    <fieldset>
        <div class="form-group">
            <label class="col-md-4 control-label" for="album_name"
                   style="color: #cecece; font-size: 1em; font-weight: 100;">
                <spring:message code="album_name"/></label>
            <div class="col-md-4">
                <input id="album_name" name="album_name" type="text" placeholder="<spring:message code="album_name"/>"
                       value="${album.albumName}" class="form-control input-md">
            </div>
        </div>

        <div class="form-group">
            <label class="col-md-4 control-label" for="descr"
                   style="color: #cecece; font-size: 1em; font-weight: 100;">
                <spring:message code="description"/></label>
            <div class="col-md-4">
                <c:set var="des" value="${album.albumDescr}"/>
                <c:if test="${empty des}">
                        <textarea class="form-control" id="descr" name="descr" rows="3"
                                  placeholder="<spring:message code="description"/>"></textarea>
                </c:if>
                <c:if test="${not empty des}">
                    <textarea class="form-control" id="descr" name="descr" rows="3"><c:out
                            value="${album.albumDescr}"/></textarea>
                </c:if>
            </div>
        </div>

        <div class="form-group">
            <label class="col-md-4 control-label" for="group-selection"
                   style="color: #cecece; font-size: 1em; font-weight: 100;">
                <spring:message code="category"/></label>
            <div class="col-md-4">
                <select id="group-selection" class="form-control" name="group-selection">
                    <c:forEach items="${categories}" var="category">
                        <option id="album_category" name="album_category"
                                value="${category.name}" ${category.name == album_category ? 'selected' : ''}>${category.name}</option>

                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-md-4 control-label" for="save"></label>
            <div class="col-md-4">
                <input type="hidden" value="${album.albumUID}" name="albumUid">
                <input type="submit" id="save" name="save"
                       class="btn btn-active btn-block" value="<spring:message code="save"/>">
            </div>
        </div>

    </fieldset>
</form>

<div id="footer">
    &copy 2016 #myphotos
</div>
<%--</sec:authorize>--%>
<script>
    $('.selectpicker').selectpicker();
</script>
</body>
</html>