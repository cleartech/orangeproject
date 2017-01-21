<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<style>
    body {
        padding-top: 70px;
        background-color: #ffffff;
    }

    #messageTable .marked {
        background: #22aeae;
        color: #ffffff;
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

    .table {
        font-size: 1em;
        /*color: #afafaf;*/
        font-weight: 100;
        text-transform: uppercase;
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
    <title>MyPhotos - messages ${box}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<link rel="icon" type="image/x-icon" href="/resources/fav16x16.png">
<body>
<c:url var="firstUrl" value="/messages/${box}/page/1"/>
<c:url var="lastUrl" value="/messages/${box}/page/${page.totalPages}"/>
<c:url var="prevUrl" value="/messages/${box}/page/${currentIndex - 1}"/>
<c:url var="nextUrl" value="/messages/${box}/page/${currentIndex + 1}"/>

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
                    <li class="active"><a href="<c:url value="/messages/inbox/page/1" />"><spring:message code="messages"/></a></li>
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
    <div class="col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 10px;">
        <h1 style="color: #1a9b9b; font-weight: 100;"><spring:message code="messages"/> - ${fn:toUpperCase(box)}</h1>
    </div>
</div>

<%--pagination--%>
<c:if test="${total gt 20}">
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
                    <c:url var="pageUrl" value="/messages/${box}/page/${i}"/>
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

<div class="container">
    <c:if test="${param.emptyMessage ne null}">
        <div class="alert alert-danger alert-dismissible" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span></button>
            <div style="text-align: center; color: #1a9b9b;">
                <h5><spring:message code="fail_sent_empty_message"/></h5></div>
        </div>
    </c:if>
    <%--inbox--%>
    <c:if test="${box == 'inbox'}">
        <c:if test="${param.sent ne null}">
            <div class="alert alert-success alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <div style="text-align: center; color: #1a9b9b;">
                    <h5><spring:message code="message_sent"/></h5></div>
            </div>
        </c:if>

        <div align="center" style="margin-bottom: 1em;">
            <button type="button" class="btn btn-active"
                    onclick="window.location='/messages/outbox/page/${currentIndex}';">
                <spring:message code="go_to_outbox"/>
            </button>
            <button type="button" class="btn btn-danger" id="inbox_delete">
                <spring:message code="delete_selected"/>
            </button>
        </div>

        <table class="table table-hover table-condensed" id="messageTable">
            <thead>
            <tr>
                <td></td>
                <th style="color: #afafaf; font-size: .9em; font-weight: 100;"><spring:message code="title"/></th>
                <th style="color: #afafaf; font-size: .9em; font-weight: 100;"><spring:message code="from"/></th>
                <th style="color: #afafaf; font-size: .9em; font-weight: 100;"><spring:message code="message"/></th>
                <th style="color: #afafaf; font-size: .9em; font-weight: 100;"><spring:message code="received"/></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${page.content}" var="item">
            <tr>
                <td><input type="checkbox" name="toDelete[]" id="${item.messageUID}" value="${item.messageUID}"></td>
                <c:set var="messageTitle" value="${item.messageTheme}"/>
                <c:if test="${fn:length(messageTitle) gt 35}">
                    <c:set var="messageTitle" value="${fn:substring(messageTitle, 0, 35)}${'...'}"/>
                </c:if>

                <c:choose>
                    <c:when test="${item.read == false}">
                        <td style="color: #484848;">${messageTitle}
                            <small><span class="label label-success">new</span></small>
                        </td>
                    </c:when>
                    <c:otherwise>
                        <td style="color: #484848;">${messageTitle}</td>
                    </c:otherwise>
                </c:choose>
                <td><a href="/user/${item.userFrom.login}">${item.userFrom.login}</a></td>
                <c:choose>
                    <c:when test="${fn:length(item.messageText) gt 40}">
                        <td>
                            <a href="/messages/${box}/page/${currentIndex}/${item.messageUID}">${fn:substring(item.messageText, 0, 37)}${'...'}</a>
                        </td>
                    </c:when>
                    <c:otherwise>
                        <td><a href="/messages/${box}/page/${currentIndex}/${item.messageUID}">${item.messageText}</a>
                        </td>
                    </c:otherwise>
                </c:choose>
                <fmt:formatDate value="${item.messageDate}"
                                type="date"
                                pattern="dd/MM/yyyy HH:mm"
                                var="messageDate"/>
                <td class="marked">${messageDate}</td>
            </tr>
            </c:forEach>
        </table>
    </c:if>
    <%--inbox--%>

    <%--outbox--%>
    <c:if test="${box == 'outbox'}">

        <div align="center" style="margin-bottom: 1em;">
            <button type="button" class="btn btn-active"
                    onclick="window.location='/messages/inbox/page/${currentIndex}';">
                <spring:message code="go_to_inbox"/>
            </button>
            <button type="button" class="btn btn-danger" id="outbox_delete">
                <spring:message code="delete_selected"/></button>
        </div>

        <table class="table table-hover table-condensed" id="messageTable">
            <thead>
            <tr>
                <td></td>
                <th style="color: #afafaf; font-size: .9em; font-weight: 100;"><spring:message code="title"/></th>
                <th style="color: #afafaf; font-size: .9em; font-weight: 100;"><spring:message code="to"/></th>
                <th style="color: #afafaf; font-size: .9em; font-weight: 100;"><spring:message code="message"/></th>
                <th style="color: #afafaf; font-size: .9em; font-weight: 100;"><spring:message code="sent"/></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${page.content}" var="outMessage">
            <tr>
                <td><input type="checkbox" name="toDelete[]" id="${outMessage.messageUID}"
                           value="${outMessage.messageUID}"></td>
                <c:set var="messageTitle" value="${outMessage.messageTheme}"/>
                <c:if test="${fn:length(messageTitle) gt 35}">
                    <c:set var="messageTitle" value="${fn:substring(messageTitle, 0, 35)}${'...'}"/>
                </c:if>
                <td>${messageTitle}</td>
                <td><a href="/user/${outMessage.userTo.login}">${outMessage.userTo.login}</a></td>
                <c:choose>
                    <c:when test="${fn:length(outMessage.messageText) gt 40}">
                        <td>
                            <a href="/messages/${box}/page/${currentIndex}/${outMessage.messageUID}">${fn:substring(outMessage.messageText, 0, 37)}${'...'}</a>
                        </td>
                    </c:when>
                    <c:otherwise>
                        <td>
                            <a href="/messages/${box}/page/${currentIndex}/${outMessage.messageUID}">${outMessage.messageText}</a>
                        </td>
                    </c:otherwise>
                </c:choose>
                <fmt:formatDate value="${outMessage.messageDate}"
                                type="date"
                                pattern="dd/MM/yyyy HH:mm"
                                var="messageDate"/>
                <td class="marked">${messageDate}</td>
            </tr>
            </c:forEach>
        </table>
    </c:if>
    <%--outbox--%>
</div>

<%--pagination--%>
<c:if test="${total gt 20}">
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
                    <c:url var="pageUrl" value="/messages/${box}/page/${i}"/>
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
<div id="footer">
    &copy 2016 #myphotos
</div>

<script>
    $('#inbox_delete').click(function () {
        var data = {'toDelete[]': []};
        $(":checked").each(function () {
            data['toDelete[]'].push($(this).val());
        });
        $.post("/inbox-delete", data, function (data, status) {
            window.location.reload();
        });
    });
    $('#outbox_delete').click(function () {
        var data = {'toDelete[]': []};
        $(":checked").each(function () {
            data['toDelete[]'].push($(this).val());
        });
        $.post("/outbox-delete", data, function (data, status) {
            window.location.reload();
        });
    });
</script>
</body>
</html>
