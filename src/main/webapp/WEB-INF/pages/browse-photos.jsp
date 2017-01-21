<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<style>
    body {
        padding-top: 70px;
        background-color: #ffffff;
    }

    .mythumbnail {
        position: relative;
        width: 200px;
        height: 200px;
        overflow: hidden;
    }

    .mythumbnail .after {
        position: absolute;
        top: 80%;
        left: 0;
        width: 100%;
        height: 20%;
        display: none;
        color: #FFF;
        margin-top: .9em;
        font-weight: 100;
    }

    .mythumbnail:hover .after {
        display: block;
        background: rgba(0, 0, 0, .6);
    }

    .mythumbnail img {
        position: absolute;
        left: 50%;
        top: 50%;
        height: 100%;
        width: auto;
        -webkit-transform: translate(-50%, -50%);
        -ms-transform: translate(-50%, -50%);
        transform: translate(-50%, -50%);
    }

    h6 {
        position: absolute;
        top: 160px;
        left: 0;
        width: 100%;
        font-weight: 100;
    }

    h6 span.spacer {
        padding: 0 5px;
    }

    .glyphicon {
        font-size: .8em;
        font-weight: 100;
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
        background-color: #1a9b9b;
        border-color: #1a9b9b;
        outline: none !important;
    }

    .pagination > li.active > a {
        background: #1a9b9b;
        color: #fff;
    }

    .pagination > li.active > a:hover {
        background: #1a9b9b;
        color: #fff;
    }

    .pagination > li > a {
        color: #1a9b9b;
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
</style>
<%--Pagination links--%>
<c:url var="firstUrl" value="/browse/photos/${currentCategory}/1"/>
<c:url var="lastUrl" value="/browse/photos/${currentCategory}/${latestPhotos.totalPages}"/>
<c:url var="prevUrl" value="/browse/photos/${currentCategory}/${photosIndex - 1}"/>
<c:url var="nextUrl" value="/browse/photos/${currentCategory}/${photosIndex + 1}"/>
<%--Pagination links--%>
<html>
<head>
    <title>MyPhotos - browsing</title>
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
                <li class="active"><a href="<c:url value="/browse/albums/latest/1" />"><spring:message code="browse"/></a></li>
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
<div class="container" align="center" style="padding-bottom: 2em;"><%--Header--%>
    <div class="col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 1em;">
        <h1 style="color: #1a9b9b; font-weight: 100;"><spring:message code="browse"/></h1>
        <button class="btn btn-inactive"
                onclick="window.location='/browse/albums/latest/1';">
            <spring:message code="albums"/></button>
        <button class="btn btn-active" onclick="window.location='#';">
            <spring:message code="photos"/>
        </button>
    </div>

    <div>
        <h6 style="color: #cecece; font-weight: 100; margin-bottom: -1em; margin-top: 2.5em;">
            <spring:message code="by_recent_commented"/></h6>
    </div>
</div>
<%--Header--%>

<div class="container col-md-12" align="center"><%--Tags buttons--%>
    <c:forEach items="${categories}" var="category">
        <c:choose>
            <c:when test="${currentCategory == category}">
                <button class="btn btn-active" onclick="window.location='#';">
                    <span class="glyphicon glyphicon-ok">&nbsp</span>${fn:toUpperCase(category)}
                </button>
            </c:when>
            <c:otherwise>
                <button class="btn btn-inactive" onclick="window.location='/browse/photos/${category}/1';">
                    <span class="glyphicon glyphicon-tags">&nbsp</span>${fn:toUpperCase(category)}
                </button>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <%--</div>--%>
</div>
</div>
<%--Tags buttons--%>

<div class="container" align="center"><%--pagination--%>
    <div class="pagination">
        <ul class="pagination pagination-sm">
            <c:choose>
                <c:when test="${photosIndex == 1}">
                    <li class="disabled"><a href="#">&lt;&lt;</a></li>
                    <li class="disabled"><a href="#">&lt;</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${firstUrl}">&lt;&lt;</a></li>
                    <li><a href="${prevUrl}">&lt;</a></li>
                </c:otherwise>
            </c:choose>
            <c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
                <c:url var="pageUrl" value="/browse/photos/${currentCategory}/${i}"/>
                <c:choose>
                    <c:when test="${i == photosIndex}">
                        <li class="active"><a href="${pageUrl}"><c:out value="${i}"/></a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${pageUrl}"><c:out value="${i}"/></a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:choose>
                <c:when test="${photosIndex == latestPhotos.totalPages}">
                    <li class="disabled"><a href="#">&gt;</a></li>
                    <li class="disabled"><a href="#">&gt;&gt;</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${nextUrl}">&gt;</a></li>
                    <li><a href="${lastUrl}">&gt;&gt;</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</div>
<%--pagination--%>

<div class="container col-md-12"
     style="width: 100%;
        min-width: 100%;
        max-width: 100%;" align="center">

    <c:forEach items="${latestPhotos.content}" var="photo">
        <c:if test="${photo.user ne null}">
        <div class="col-sm-2 col-md-2">
            <div class="mythumbnail" style="margin: .1em;">
                <a href="/view-album-item/${photo.uId}/1"><img
                        src="/view-item/${photo.uId}"></a>
                <div class="after">
                    <span class="glyphicon glyphicon-eye-open"></span>&nbsp${photo.views}&nbsp
                    <span class="glyphicon glyphicon-comment"></span>&nbsp${fn:length(photo.comments)}&nbsp
                    <span class="glyphicon glyphicon-star"></span>&nbsp${fn:length(photo.addedUsers)}
                </div>
            </div>
        </div>
        </c:if>
    </c:forEach>

</div>

<div class="container" align="center"><%--pagination--%>
    <div class="pagination">
        <ul class="pagination pagination-sm">
            <c:choose>
                <c:when test="${photosIndex == 1}">
                    <li class="disabled"><a href="#">&lt;&lt;</a></li>
                    <li class="disabled"><a href="#">&lt;</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${firstUrl}">&lt;&lt;</a></li>
                    <li><a href="${prevUrl}">&lt;</a></li>
                </c:otherwise>
            </c:choose>
            <c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
                <c:url var="pageUrl" value="/browse/photos/${currentCategory}/${i}"/>
                <c:choose>
                    <c:when test="${i == photosIndex}">
                        <li class="active"><a href="${pageUrl}"><c:out value="${i}"/></a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${pageUrl}"><c:out value="${i}"/></a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:choose>
                <c:when test="${photosIndex == latestPhotos.totalPages}">
                    <li class="disabled"><a href="#">&gt;</a></li>
                    <li class="disabled"><a href="#">&gt;&gt;</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${nextUrl}">&gt;</a></li>
                    <li><a href="${lastUrl}">&gt;&gt;</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</div>
<%--pagination--%>

<div id="footer">
    &copy 2016 #myphotos
</div>

</body>
</html>
