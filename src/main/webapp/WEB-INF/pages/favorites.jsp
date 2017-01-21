<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    body {
        padding-top: 70px;
        background-color: #ffffff;
    }

    img {
        height: 100px;
        width: auto;
        display: block;
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

    .table {
        font-size: 1em;
        font-weight: 100;
        text-transform: uppercase;
    }

    .table > tbody > tr > td {
        vertical-align: middle;
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
<html>
<head>
    <title>MyPhotos - favorites</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<link rel="icon" type="image/x-icon" href="/resources/fav16x16.png">
<body>
<c:url var="firstUrl" value="/favorites/page/1"/>
<c:url var="lastUrl" value="/favorites/page/${page.totalPages}"/>
<c:url var="prevUrl" value="/favorites/page/${currentIndex - 1}"/>
<c:url var="nextUrl" value="/favorites/page/${currentIndex + 1}"/>

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
                    <li class="active"><a href="<c:url value="/favorites/page/1" />"><spring:message code="favorites"/></a></li>
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
    <div class="col-md-12 col-sm-12 col-xs-12">
        <h1 style="color: #1a9b9b; font-weight: 100;"><spring:message code="favorites"/></h1>
    </div>
</div>

<div class="container" align="center">
    <div style="margin-bottom: 1em;">
        <c:if test="${currentCase == 'myFavorites'}">
            <h3 style="color: #1a9b9b; font-weight: 100;"><spring:message code="favorites_list"/></h3>
            <button class="btn btn-active"
                    onclick="window.location='/favorited/page/1';">
                <spring:message code="go_to_your_favorites_in_others"/>
            </button>
        </c:if>

        <c:if test="${currentCase == 'othersFavorited'}">
            <h3 style="color: #1a9b9b; font-weight: 100;"><spring:message code="your_photos_other_favorites"/></h3>
            <button class="btn btn-active"
                    onclick="window.location='/favorites/page/1';">
                <spring:message code="go_to_your_favorite"/>
            </button>
        </c:if>
    </div>

    <%--pagination--%>
    <c:if test="${totalPages gt 20}">
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
                        <c:url var="pageUrl" value="/favorites/page/${i}"/>
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

    <div style="margin-bottom: 3em;">
        <table class="table table-hover table-condensed">
            <thead>
            <tr>
                <%--<c:choose>--%>
                <c:if test="${currentCase == 'myFavorites'}">

                    <th style="color: #afafaf; font-size: .9em; font-weight: 100;"><spring:message code="photo"/></th>
                    <th style="color: #afafaf; font-size: .9em; font-weight: 100;"><spring:message
                            code="uploader"/></th>
                    <th style="color: #afafaf; font-size: .9em; font-weight: 100;"><spring:message
                            code="photo_info"/></th>
                </c:if>
                <c:if test="${currentCase == 'othersFavorited'}">
                    <th style="color: #afafaf; font-size: .9em; font-weight: 100;"><spring:message code="photo"/></th>
                    <th style="color: #afafaf; font-size: .9em; font-weight: 100;"><spring:message
                            code="users_added"/></th>
                    <th></th>
                </c:if>
            </tr>
            </thead>
            <tbody>
            <c:if test="${currentCase == 'myFavorites'}">
                <c:forEach items="${favoriteList.content}" var="item">
                    <tr>
                        <td><a href="/view-album-item/${item.uId}/${currentIndex}"><img src="/view-item/${item.uId}"
                                                                                        width="200" height="100"></a>
                        </td>
                        <td><a href="/user/${item.user.login}">${fn:toUpperCase(item.user.login)}</a></td>
                        <td>
                            <p style="color: #136e6e;"><span style="font-size: small;"><span
                                    class="glyphicon glyphicon-eye-open"></span> ${item.views}</span></p>
                            <p style="color: #136e6e;"><span style="font-size: small;"><span
                                    class="glyphicon glyphicon-star"></span> ${fn:length(item.addedUsers)}</span></p>
                            <p style="color: #136e6e;"><span style="font-size: small;"><span
                                    class="glyphicon glyphicon-comment"></span> ${fn:length(item.comments)}</span></p>
                        </td>
                        <td>
                            <button type="button" class="btn btn-danger"
                                    onclick="window.location='/manage-favorites/${currentIndex}/${item.uId}';">
                                <spring:message code="remove"/>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${currentCase == 'othersFavorited'}">
                <c:forEach items="${favoritedList.content}" var="item">
                    <tr>
                        <td><img src="/view-item/${item.uId}" width="200" height="100"></td>
                        <td>
                            <p style="color: #136e6e;"><spring:message code="total"/>
                                : ${fn:length(item.addedUsers)}</p>
                            <c:forEach items="${item.addedUsers}" var="user" varStatus="iteration">
                                <c:if test="${iteration.index lt 5}">
                                    <a href="/user/${user.login}">${user.login}</a>&nbsp
                                </c:if>
                                <c:if test="${iteration.index gt 4}">
                                    and ${fn:length(item.addedUsers) - 5} more user(s)
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <button type="button" class="btn btn-active"
                                    onclick="window.location='/view-album-item/${item.uId}/${currentIndex}';">
                                <spring:message
                                        code="view_photo"/></button>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
            </tbody>
        </table>
    </div>
    <%--pagination--%>
    <c:if test="${totalPages gt 20}">
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
                        <c:url var="pageUrl" value="/favorites/page/${i}"/>
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
    &copy 2016 #myphotos
</div>

<script>
    $('#delete_favorites').click(function () {
        var data = {'toDelete[]': []};
        $(":checked").each(function () {
            data['toDelete[]'].push($(this).val());
        });
        $.post("/favorites/delete", data, function (data, status) {
            window.location.reload();
        });
    });
</script>

</body>
</html>
