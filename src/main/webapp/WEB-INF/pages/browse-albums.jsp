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

<style type="text/css">
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
        background: rgba(0, 0, 0, .7);
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

    .mythumbnail img.portrait {
        width: 100%;
        height: auto;
    }

    .mycontainer {
        position: relative;
        width: 200px;
        height: 200px;
        overflow: hidden;
    }

    .overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        color: #FFF;
        background: rgba(0, 0, 0, .75);
        transition: background 0.5s ease;
    }

    .mycontainer:hover .overlay {
        display: block;
        background: rgba(0, 0, 0, .95);
    }

    .glyphicon {
        font-size: .8em;
        font-weight: 100;
    }

    .mycontainer img {
        position: absolute;
        left: 50%;
        top: 50%;
        height: 100%;
        width: auto;
        -webkit-transform: translate(-50%, -50%);
        -ms-transform: translate(-50%, -50%);
        transform: translate(-50%, -50%);
    }

    .title {
        position: absolute;
        width: 200px;
        left: 0;
        top: 60px;
        font-weight: 100;
        font-size: 10px;
        text-align: center;
        text-transform: uppercase;
        color: white;
        z-index: 1;
        transition: top .5s ease;
    }

    .mycontainer:hover .title {
        top: 40px;
    }

    #textcare {
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
        font-size: 1.5em;
        margin-left: .5em;
        margin-right: .5em;
    }

    .mybutton {
        position: absolute;
        left: 0;
        right: 0;
        top: 130px;
        text-align: center;
        opacity: 0;
        transition: opacity .35s ease;
    }

    .mybutton a {
        width: 200px;
        padding: 12px 48px;
        text-align: center;
        color: white;
        border: solid 2px white;
        z-index: 1;
        text-decoration: none;
    }

    .mycontainer:hover .mybutton {
        opacity: 1;
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
<c:url var="firstUrl" value="/browse/albums/${currentCategory}/1"/>
<c:url var="lastUrl" value="/browse/albums/${currentCategory}/${latestAlbums.totalPages}"/>
<c:url var="prevUrl" value="/browse/albums/${currentCategory}/${currentIndex - 1}"/>
<c:url var="nextUrl" value="/browse/albums/${currentCategory}/${currentIndex + 1}"/>
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
        <button class="btn btn-active" onclick="window.location='#';"><spring:message code="albums"/></button>
        <button class="btn btn-inactive" onclick="window.location='/browse/photos/recent/1';">
            <spring:message code="photos"/></button>
    </div>

    <div>
        <h6 style="color: #cecece; font-weight: 100; margin-bottom: -1em;">
            <spring:message code="by_category_or_latest"/></h6>
    </div>
</div>
<%--Header--%>

<div class="container">
    <div class="container col-md-12" align="center"><%--Tags buttons--%>
        <c:forEach items="${categories}" var="category">
            <c:choose>
                <c:when test="${currentCategory == fn:toLowerCase(category.name)}">
                    <button class="btn btn-active" onclick="window.location='#';">
                        <span class="glyphicon glyphicon-ok">&nbsp</span>${fn:toUpperCase(category.name)}
                    </button>
                </c:when>
                <c:otherwise>
                    <button class="btn btn-inactive"
                            onclick="window.location='/browse/albums/${fn:toLowerCase(category.name)}/1';">
                        <span class="glyphicon glyphicon-tags">&nbsp</span>${fn:toUpperCase(category.name)}
                    </button>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</div>
<%--Tags buttons--%>

<div class="container" align="center"><%--pagination--%>
    <div class="pagination">
        <ul class="pagination pagination-sm">
            <c:choose>
                <c:when test="${currentIndex == 1}">
                    <li class="disabled"><a href="#">&lt;&lt;</a></li>
                    <li class="disabled"><a href="#">&lt;</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${firstUrl}">&lt;&lt;</a></li>
                    <li><a href="${prevUrl}">&lt;</a></li>
                </c:otherwise>
            </c:choose>
            <c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
                <c:url var="pageUrl" value="/browse/albums/${currentCategory}/${i}"/>
                <c:choose>
                    <c:when test="${i == currentIndex}">
                        <li class="active"><a href="${pageUrl}"><c:out value="${i}"/></a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${pageUrl}"><c:out value="${i}"/></a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:choose>
                <c:when test="${currentIndex == latestAlbums.totalPages}">
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
        max-width: 100%;" align="center"><%--Photos layouts--%>

    <c:forEach items="${latestAlbums.content}" var="album">
        <div class="row">
            <c:forEach items="${album.albumItems}" var="currentAlbumItem"
                       varStatus="currentAlbumItemIndex"><%--Go througth albums item--%>

                <c:if test="${currentAlbumItemIndex.index lt 6}">

                    <c:choose>
                        <c:when test="${currentAlbumItemIndex.index eq 5 || currentAlbumItemIndex.last}"><%--If current photo is 6-th or last - place button to album view--%>

                            <div class="col-sm-2 col-md-2">
                                <div class="mycontainer" style="margin: .1em;">
                                    <img src="/view-item/${currentAlbumItem.uId}">
                                    <div class="title">
                                        <p id="textcare">${album.albumName}</p>
                                        Uploaded by: ${album.user.login}<br/>
                                        Category: ${album.category.name}<br/>
                                        Photos: ${fn:length(album.albumItems)}
                                    </div>
                                    <div class="overlay"></div>
                                    <div class="mybutton"><a href="/albums/view/${album.albumUID}/1">
                                        <spring:message code="view_album"/> </a></div>
                                </div>
                            </div>
                        </c:when><%--If current photo is 6-th or last - place button to album view--%>
                        <c:otherwise><%--Place in a row clickable thumbnail from 1st to 5th photo--%>
                            <div class="col-sm-2 col-md-2">
                                <div class="mythumbnail" style="margin: .1em;">
                                    <a href="/view-album-item/${currentAlbumItem.uId}/1"><img
                                            src="/view-item/${currentAlbumItem.uId}" <%--class="portrait"--%>></a>
                                    <div class="after">
                                        <span class="glyphicon glyphicon-eye-open"></span>&nbsp${currentAlbumItem.views}&nbsp&nbsp
                                        <span class="glyphicon glyphicon-comment"></span>&nbsp${fn:length(currentAlbumItem.comments)}&nbsp&nbsp
                                        <span class="glyphicon glyphicon-star"></span>&nbsp${fn:length(currentAlbumItem.addedUsers)}
                                    </div>
                                </div>
                            </div>
                        </c:otherwise><%--Place in a row clickable thumbnail from 1st to 5th photo--%>
                    </c:choose>
                </c:if>
            </c:forEach>
        </div>
    </c:forEach><%--Go througth albums item--%>

</div>
<%--Photos layouts--%>

<div class="container" align="center"><%--pagination--%>
    <div class="pagination">
        <ul class="pagination pagination-sm">
            <c:choose>
                <c:when test="${currentIndex == 1}">
                    <li class="disabled"><a href="#">&lt;&lt;</a></li>
                    <li class="disabled"><a href="#">&lt;</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${firstUrl}">&lt;&lt;</a></li>
                    <li><a href="${prevUrl}">&lt;</a></li>
                </c:otherwise>
            </c:choose>
            <c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
                <c:url var="pageUrl" value="/browse/albums/${currentCategory}/${i}"/>
                <c:choose>
                    <c:when test="${i == currentIndex}">
                        <li class="active"><a href="${pageUrl}"><c:out value="${i}"/></a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${pageUrl}"><c:out value="${i}"/></a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:choose>
                <c:when test="${currentIndex == latestAlbums.totalPages}">
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
