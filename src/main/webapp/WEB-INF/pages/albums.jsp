<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    h5 {
        word-wrap: break-word;
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

    #textcare {
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
        font-size: 1.8em;
        margin-left: .5em;
        margin-right: .5em;
    }

    .mycontainer {
        position: relative;
        width: 300px;
        height: 250px;
        overflow: hidden;
    }

    .overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        color: #FFF;
        background: rgba(0, 0, 0, .65);
        transition: background 0.5s ease;
    }

    .mycontainer:hover .overlay {
        display: block;
        background: rgba(0, 0, 0, .85);
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
        width: 300px;
        left: 0;
        top: 70px;
        font-weight: 100;
        font-size: 10px;
        text-align: center;
        text-transform: uppercase;
        color: #1a9b9b;
        z-index: 1;
        transition: top .5s ease;
    }

    .mybutton {
        position: absolute;
        left: 0;
        right: 0;
        top: 180px;
        text-align: center;
        transition: opacity .35s ease;
    }

    .editmybutton {
        position: absolute;
        left: 85%;
        right: 0;
        top: 5px;
        background: none;
        border: none;
        box-shadow: none;
        color: #1a9b9b;
        outline: none;
    }

    .editmybutton:focus {
        outline: none;
    }

    .mycontainer:hover .editmybutton {
        background: none;
        border: none;
        box-shadow: none;
        outline: none;
    }

    .mycontainer:hover .editmybutton:hover {
        color: #136e6e;
    }

    .mybutton a {
        width: 200px;
        padding: 9px 48px;
        text-align: center;
        color: #ffffff;
        border: solid 1px #1a9b9b;
        z-index: 1;
        text-decoration: none;
        background-color: #1a9b9b;
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

    .dropdown-menu {
        color: #ffffff;
        background-color: #1a9b9b;
    }

    .dropdown-menu > li > a {
        color: #ffffff;
    }

    .dropdown-menu > li > a:hover {
        color: #ffffff;
        background-color: #136e6e;
    }

    a {
        color: #1a9b9b;
        text-decoration: none;
    }

    a:hover {
        color: #136e6e;
        text-decoration: none;
    }

</style>
<script>
    $(window).load(function () {

        boxes = $('.panel-body');
        maxHeight = Math.max.apply(
                Math, boxes.map(function () {
                    return $(this).height();
                }).get());
        boxes.height(maxHeight);
        $('.col-sm-12 .panel').height(maxHeight / 2 - 22);//22 = 20 (bottom-margin) + 2 *1 (border)
    });

</script>

<c:url var="firstUrl" value="/albums/page/1"/>
<c:url var="lastUrl" value="/albums/page/${albums.totalPages}"/>
<c:url var="prevUrl" value="/albums/page/${currentIndex - 1}"/>
<c:url var="nextUrl" value="/albums/page/${currentIndex + 1}"/>

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

<div align="center" style="margin-bottom: 2em;">
    <div class="container">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <h1 style="color: #1a9b9b; font-weight: 100;"><spring:message code="albums"/></h1>
        </div>
    </div>

    <c:if test="${login != pageContext.request.userPrincipal.name}">
        <div align="center">
            <h6 style="color: #cecece; font-weight: 100;">
                <spring:message code="uploader"/>: <a href="/user/${login}">${fn:toUpperCase(login)}</a></h6>
        </div>
    </c:if>

    <c:if test="${param.empty_name ne null}">
        <div class="container">
            <div class="alert alert-warning alert-dismissible col-md-12" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <spring:message code="specify_album_name"/>
            </div>
        </div>
    </c:if>

    <sec:authorize var="loggedIn" access="isAuthenticated()">
        <c:if test="${pageContext.request.userPrincipal.name == login}">

            <div class="container" style="margin-bottom: 1em;">
                <button type="button" class="btn btn-active"
                        onclick="window.location='/albums/manage-album/${currentIndex}';">
                    <spring:message code="new_album"/>
                </button>
            </div>
        </c:if>
    </sec:authorize>

    <%--pagination--%>
    <c:if test="${totalAlbums gt 12}">
        <div class="container" align="center">
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
                        <c:url var="pageUrl" value="/albums/page/${i}"/>
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
                        <c:when test="${currentIndex == page.totalPages}">
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
    </c:if>
    <%--pagination--%>

    <div class="container" align="center">
        <div class="row">

            <c:forEach items="${albums.content}" var="album">

                <div class="col-md-4">
                    <div class="mycontainer"
                         style="margin: .5em;">

                        <c:choose>
                            <c:when test="${fn:length(album.albumItems) gt 0}">
                                <img src="/view-item/${album.albumItems[0].uId}">
                            </c:when>
                            <c:otherwise>
                                <img src="http://placehold.it/300x250">
                            </c:otherwise>
                        </c:choose>
                        <div class="title">
                            <p id="textcare">${album.albumName}</p>
                            <spring:message code="category"/>: ${album.category.name}<br/>
                            <spring:message code="photos"/>: ${fn:length(album.albumItems)}<br/>
                            <fmt:formatDate value="${album.creationDate}"
                                            type="date"
                                            pattern="dd.MM.yyyy"
                                            var="creationDate"/>
                            <spring:message code="created"/>: ${creationDate}
                        </div>
                        <div class="overlay"></div>
                        <div class="mybutton"><a href="/albums/view/${album.albumUID}/1"><spring:message
                                code="open"/></a></div>
                        <sec:authorize var="loggedIn" access="isAuthenticated()">
                            <c:if test="${album.user.login == pageContext.request.userPrincipal.name ||
                        pageContext.request.isUserInRole('ADMIN')}">
                                <div class="dropdown">
                                    <button class="btn btn-default editmybutton dropdown-toggle" type="button"
                                            id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true"
                                            aria-expanded="true">
                                        <span class="glyphicon glyphicon-menu-hamburger"></span>
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenu1">
                                        <li><a href="/albums/manage-album/${album.albumUID}/${currentIndex}">
                                            <spring:message code="edit_album_name"/></a></li>
                                        <li role="separator" class="divider"></li>
                                        <li><a href="/delete-album/${album.albumUID}/${currentIndex}">
                                            <spring:message code="delete_album"/></a></li>
                                    </ul>
                                </div>
                            </c:if>
                        </sec:authorize>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <%--pagination--%>
    <c:if test="${totalAlbums gt 12}">
        <div class="container" align="center">
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
                        <c:url var="pageUrl" value="/albums/page/${i}"/>
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
                        <c:when test="${currentIndex == page.totalPages}">
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
    </c:if>
    <%--pagination--%>

</div>

<div id="footer">
    <h6 align="center">&copy 2016 OrangePic</h6>
</div>
</body>
</html>