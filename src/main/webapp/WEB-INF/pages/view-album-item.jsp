<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
    body {
        padding-top: 70px;
        background-color: #ffffff;
    }

    img {
        width: auto;
        height: auto;
        max-height: 100%;
        max-width: 100%;
    }

    /* Testimonials */
    .testimonials blockquote {
        background: #f0f0f0 none repeat scroll 0 0;
        border: medium none;
        color: #ababab;
        display: block;
        font-size: 14px;
        line-height: 20px;
        padding: 15px;
        position: relative;
    }

    .testimonials blockquote::before {
        width: 0;
        height: 0;
        right: 0;
        bottom: 0;
        content: " ";
        display: block;
        position: absolute;
        border-bottom: 20px solid #fff;
        border-right: 0 solid transparent;
        border-left: 15px solid transparent;
        border-left-style: inset; /*FF fixes*/
        border-bottom-style: inset; /*FF fixes*/
    }

    .testimonials blockquote::after {
        width: 0;
        height: 0;
        right: 0;
        bottom: 0;
        content: " ";
        display: block;
        position: absolute;
        border-style: solid;
        border-width: 20px 20px 0 0;
        border-color: #1a9b9b transparent transparent transparent;
    }

    .textcare {
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
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
        margin-top: .1em;
        margin-bottom: .1em;
    }

    .btn-inactive:hover, .btn-inactive:focus, .btn-inactive:active, .btn-inactive:active:focus, .btn-inactive.active, .open > .dropdown-toggle.btn-inactive {
        color: #484848;
        background-color: #cecece;
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
        background-color: #136e6e;
        border-color: #136e6e;
        outline: none !important;
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

    a {
        color: #1a9b9b;
        text-decoration: none;
        /*font-weight: 600;*/
    }

    a:hover {
        color: #136e6e;
        text-decoration: none;
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

    .mythumbnail {
        position: relative;
        width: 100px;
        height: 60px;
        overflow: hidden;
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

</style>

<script>
    function goBack() {
        window.location.href = '/albums/view/${item.album.albumUID}/${currentIndex}';
    }

    function copyToClipboard(text) {
        window.prompt("Copy to clipboard: Ctrl+C, Enter", text);
    }

    $(document).ready(function () {
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>

<c:set var="req" value="${pageContext.request}"/>
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}"/>

<html>
<head>
    <title>MyPhotos- view item</title>
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

<div class="container" align="center">
    <div class="col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 10px;">
        <h1 style="color: #1a9b9b;" class="textcare">${item.name}</h1>
    </div>
</div>

<div class="container" align="center">
    <button class="btn btn-active"
            style="margin-bottom: 1em;"
            onclick="javascript:goBack()"><spring:message code="back_to_album"/></button>
</div>

<div class="container">

    <%--center image view--%>
    <div class="col-md-8" style="padding-bottom: 15px">
        <a href="/full-size/${item.uId}"><img src="/view-item/${item.uId}" class="img-fluid"></a>
    </div>
    <%--center image view--%>

    <%--toolbar & info--%>
    <div class="col-md-4" style="padding-bottom: 2.5em;">
        <div class="btn-group btn-group-justified" role="group" style="padding-bottom: 5px">

            <c:if test="${pageContext.request.userPrincipal.name == item.user.login || pageContext.request.isUserInRole('ADMIN')}">
                <div class="btn-group" role=group>
                    <button type="button" class="btn btn-danger" data-toggle="tooltip"
                            title="<spring:message code="delete_photo"/>"
                    ><span class="glyphicon glyphicon-remove"></span></button>
                </div>
            </c:if>
            <sec:authorize var="loggedIn" access="isAuthenticated()">
                <c:if test="${pageContext.request.userPrincipal.name != item.user.login && !pageContext.request.isUserInRole('ANONYMOUS')}">
                    <%--favorites--%>
                    <c:choose>
                        <c:when test="${favorited == true}">
                            <div class="btn-group" role=group>
                                <button type="button" class="btn btn-primary" data-toggle="tooltip"
                                        title="<spring:message code="remove_from_favorites"/>"
                                        data-toggle="button" aria-pressed="true"
                                        autocomplete="off"
                                        onclick="window.location='/remove-from-favorites/${item.uId}/${currentIndex}';">
                                    <span class="glyphicon glyphicon-star"></span>
                                </button>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="btn-group" role=group>
                                <button type="button" class="btn btn-inactive" data-toggle="tooltip"
                                        title="<spring:message code="add_to_favorite"/>"
                                        data-toggle="button" aria-pressed="false"
                                        autocomplete="off"
                                        onclick="window.location='/add-to-favorite/${item.uId}/${currentIndex}';">
                                    <span class="glyphicon glyphicon-star-empty"></span>
                                </button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <%--favorites--%>
                </c:if>
            </sec:authorize>
            <div class="btn-group" role=group>
                <button type="button" class="btn btn-inactive" data-toggle="tooltip"
                        title="<spring:message code="download_photo"/>"
                        onclick="window.location='/download/${item.uId}';">
                    <span class="glyphicon glyphicon-download"></span>
                </button>
            </div>
            <div class="btn-group" role=group>
                <button type="button" class="btn btn-inactive" data-toggle="tooltip"
                        title="<spring:message code="view_full_size"/>"
                        onclick="window.location='/full-size/${item.uId}';">
                    <span class="glyphicon glyphicon-fullscreen"></span>
                </button>
            </div>
        </div>

        <h6 style="color: #8a8a8a; font-weight: 100;"><spring:message
                code="album"/>: ${fn:toUpperCase(item.album.albumName)}</h6>
        <small style="color: #8a8a8a; font-weight: 100;"><span
                class="glyphicon glyphicon-picture"></span> ${fn:toUpperCase(item.name)}</small>
        <br>
        <fmt:formatDate value="${item.uploadDate}"
                        type="date"
                        pattern="dd.MM.yyyy"
                        var="uploadDate"/>
        <small style="color: #8a8a8a; font-weight: 100;"><span
                class="glyphicon glyphicon-calendar"></span> ${uploadDate}</small>
        <br>
        <small style="color: #8a8a8a; font-weight: 100;"><span
                class="glyphicon glyphicon-fullscreen"></span> ${item.width}x${item.height}px
        </small>
        <br>
        <small style="color: #8a8a8a; font-weight: 100;"><span
                class="glyphicon glyphicon-eye-open"></span>&nbsp;${item.views} &nbsp; &nbsp; </small>
        <small style="color: #8a8a8a; font-weight: 100;"><span
                class="glyphicon glyphicon-star"></span>&nbsp;${item.rating} &nbsp; &nbsp; </small>
        <small style="color: #8a8a8a; font-weight: 100;"><span
                class="glyphicon glyphicon-comment"></span>&nbsp;${fn:length(item.comments)}</small>
        <br>

        <div class="input-group input-group-sm" style="padding-top: 5px; padding-bottom: 5px;">
            <span class="input-group-addon" id="sizing-addon3"><span class="glyphicon glyphicon-link"></span></span>
            <input type="text" readonly class="form-control" id="link"
                   value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/view-item/${item.uId}"
                   aria-describedby="sizing-addon3">
      <span class="input-group-btn">
        <button class="btn btn-default" data-toggle="tooltip"
                title="<spring:message code="copy_link_to_clipboard"/>"
                onclick="copyToClipboard(document.getElementById('link').value)" type="button">
            <span class="glyphicon glyphicon-duplicate"></span></button>
      </span>
        </div>

        <c:if test="${favorited == true}">
            <h6 style="color: #ababab; font-weight: 100;"><spring:message code="photo_in"/>
                <a href="/favorites/page/1" favorites><spring:message code="your_favorite"/></a></h6>
        </c:if>

        <c:if test="${pageContext.request.userPrincipal.name != item.user.login}">
            <h6 style="color: #ababab; font-weight: 100;"><spring:message code="uploaded_by"/> <span
                    class="glyphicon glyphicon-user"></span>
                <a href="/user/${item.user.login}">${fn:toUpperCase(item.user.login)}</a></h6>
        </c:if>
    </div>
    <%--toolbar--%>

    <%--album thumbnail--%>
    <c:if test="${moreFromAlbum ne null}">
    <div style="margin-bottom: 3em;">
        <h6 align="center" style="color: #cecece; font-weight: 100;">
            <spring:message code="more_from_album"/>
        </h6>
        <div class="container" align="center">
            <c:forEach items="${moreFromAlbum.content}" var="moreItem">
                <div class="col-lg-1 col-md-1 col-sm-2 col-xs-4">
                    <div class="mythumbnail">
                        <a href="/view-album-item/${moreItem.uId}/1">
                            <img src="/view-item/${moreItem.uId}"></a>
                    </div>
                </div>
            </c:forEach>
        </div>
        </c:if>
    </div>
    <%--album thumbnail--%>

    <%--comments--%>
    <div class="col-md-12" style="margin-bottom: 3em;">
        <sec:authorize var="loggedIn" access="isAuthenticated()">
            <c:if test="${pageContext.request.userPrincipal.name != item.user.login}">
                <div class="form-group">
                    <form action="/post-comment/${currentIndex}" method="post">
                        <input type="hidden" name="itemUid" value="${item.uId}">
                        <label for="commentText"><h5 style="color: #ababab; font-weight: 100;">
                            <spring:message code="leave_comment"/></h5></label>
                        <textarea class="form-control" id="commentText" name="comment_text" rows="3"></textarea><br>
                        <input type="submit" class="btn btn-default" value="<spring:message code="post_comment"/>">
                    </form>
                </div>
            </c:if>
        </sec:authorize>
        <c:if test="${fn:length(item.comments) != 0}">
            <h5 style="color: #ababab; font-weight: 100;"><spring:message code="recent_comments"/>:</h5>
            <c:forEach items="${lastComments}" var="comment">

                <div class="row">
                    <div class="col-md-12">
                        <div class="testimonials">
                            <div>
                                <blockquote>
                                    <fmt:formatDate value="${comment.commentDate}"
                                                    type="date"
                                                    pattern="dd.MM.yyyy HH:mm"
                                                    var="formattedDate"/>
                                    <p style="color: #ababab; font-weight: 100;"><spring:message code="by"/>
                                        <a href="/user/${comment.authorLogin}"> ${fn:toUpperCase(comment.authorLogin)}</a>
                                        <spring:message code="at"/> ${formattedDate}</p>
                                    <p style="color: #707070">${comment.commentText}</p>
                                </blockquote>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${fn:length(item.comments) gt 5}">
                <div style="margin-bottom: 4em;">
                    <button class="btn btn-active"
                            onclick="window.location='/view-album-item/${item.uId}/${currentIndex}/all-comments/page/1';">
                        <spring:message code="view_all_comments"/>
                    </button>
                    <button class="btn btn-active"
                            onclick="javascript:goBack()"><spring:message code="back_to_album"/></button>
                </div>
            </c:if>
        </c:if>
    </div>
    <%--comments--%>
</div>
<div id="footer">
    &copy 2016 #myphotos
</div>

</body>
</html>
