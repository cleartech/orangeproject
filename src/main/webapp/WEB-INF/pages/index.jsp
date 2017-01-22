<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
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

    * {
        border-radius: 0 !important;
    }

    h2 {
        font-size: 5em;
        font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
        font-style: italic;
    }

    h5, h6 {
        color: #cecece;
        font-weight: 100;
        text-transform: uppercase;
    }

    h4 {
        color: #d5d5d5;
        font-weight: 100;
        text-transform: uppercase;
    }

    .panel-default {
        -moz-box-shadow: 0 0 10px #ccc;
        -webkit-box-shadow: 0 0 10px #ccc;
        box-shadow: 0 0 10px #ccc;
    }

    .albums-heading {
        background: #5cb85c;
        height: .2em;
    }

    .message-heading {
        background: #337ab7;
        height: .2em;
    }

    .comments-heading {
        background: #d9534f;
        height: .2em;
    }

    .favorites-heading {
        background: #f0ad4e;
        height: .2em;
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

    function checkSize(input) {
        if (input.files && input.files[0].size > 2 * 1024 * 1024) {
            alert("File too large. Max 2MB allowed.");
            input.value = null;
        } else {
            $(function () {

                // We can attach the `fileselect` event to all file inputs on the page
                $(document).on('change', ':file', function () {
                    var input = $(this),
                            numFiles = input.get(0).files ? input.get(0).files.length : 1,
                            label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                    input.trigger('fileselect', [numFiles, label]);
                });

                // We can watch for our custom `fileselect` event like this
                $(document).ready(function () {
                    $(':file').on('fileselect', function (event, numFiles, label) {

                        var input = $(this).parents('.input-group').find(':text'),
                                log = numFiles > 1 ? numFiles + ' files selected' : label;

                        if (input.length) {
                            input.val(log);
                        } else {
                            if (log) alert(log);
                        }
                    });
                });
            });
        }
    }

</script>

<html>
<head>
    <title>MyPhotos - image hosting</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<link rel="icon" type="image/x-icon" href="/resources/fav16x16.png">
<sec:authorize var="loggedIn" access="isAnonymous()">
    <body background="<c:url value="/resources/indexbackground.png"/>"
          style="background-repeat:no-repeat center center fixed;
-webkit-background-size:cover;
-moz-background-size:cover;
-o-background-size:cover;
background-size:cover;"/>
<%--background-position:center"/>--%>
</sec:authorize>
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
<div align="center">

    <%--Error message while anonymous uploads =empty upload=--%>
    <c:if test="${param.emptyPic ne null}">
        <div class="alert alert-warning alert-dismissible" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button>
            <spring:message code="select_file_to_upload"/>
        </div>
    </c:if>
    <%--Empty upload--%>

    <%--Not supported format error--%>
    <c:if test="${param.notSupported ne null}">
        <div class="col-md-12" align="center">
            <div class="alert alert-warning alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <spring:message code="not_supported_format"/>
            </div>
        </div>
    </c:if>
    <%--Not supported foramt error--%>

    <%--File size overhead error--%>
    <c:if test="${param.sizeLimit ne null}">
        <div class="col-md-12" align="center">
            <div class="alert alert-warning alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <spring:message code="size_limit"/>
            </div>
        </div>
    </c:if>
    <%--File size overhead error--%>

    <%--Home for logged in user--%>
    <%--header--%>
    <sec:authorize var="loggedIn" access="isAuthenticated()">
        <div class="container">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <h1 style="color: #1a9b9b; text-transform: uppercase; font-weight: 100;"><spring:message
                        code="your_home_page"/></h1>
            </div>
        </div>

        <div class="container" style="margin-bottom: 1em;">
            <button class="btn btn-active"
                    onclick="window.location='/user/${login}';"
            ><spring:message code="profile_page"/>
            </button>
        </div>
        <%--header--%>

        <%--Available user pages--%>
        <div class="container" style="margin-bottom: 2em;">
            <div class="row">
                    <%--Albums--%>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="albums-heading"></div>
                        <div style="margin-top: .5em;">
                            <h4 style="text-transform: uppercase; color: #9f9f9f;"><spring:message
                                    code="albums_label"/></h4></div>
                        <div class="panel-body">
                            <h6><spring:message code="manage_albums"/></h6>
                            <p></p>
                            <h6>
                                <spring:message code="albums_label"/>&nbsp<span
                                    class="badge">${albums}</span>
                            </h6>
                            <br>
                            <a href="/albums/page/1" class="btn btn-active"><spring:message code="go_to_albums"/></a>
                        </div>
                    </div>
                </div>
                    <%--Albums--%>

                    <%--Messages--%>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="message-heading"></div>
                        <div style="margin-top: .5em;">
                            <h4 style="text-transform: uppercase; color: #9f9f9f;"><spring:message
                                    code="messages"/></h4></div>
                        <div class="panel-body">
                            <h6><spring:message code="exchange_messages"/></h6>
                            <p></p>
                            <h6><spring:message code="messages"/>&nbsp<span class="badge">${inbox}</span>
                                <c:if test="${inboxUnread gt 0}">
                                    <span class="label label-success">new</span>
                                </c:if>
                            </h6>
                            <br>
                            <a href="/messages/inbox/page/1" class="btn btn-active"><spring:message
                                    code="go_to_messages"/></a>
                        </div>
                    </div>
                </div>
                    <%--Messages--%>

                    <%--Comments--%>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="comments-heading"></div>
                        <div style="margin-top: .5em">
                            <h4 style="text-transform: uppercase; color: #9f9f9f;"><spring:message
                                    code="comments"/></h4></div>
                        <div class="panel-body">
                            <h6><spring:message code="read_comments"/></h6>
                            <p></p>
                            <h6><spring:message code="comments"/>&nbsp<span class="badge">${commentsTotal}</span>
                            </h6>
                            <br>
                            <a href="/comments/1" class="btn btn-active"><spring:message code="go_to_comments"/></a>
                        </div>
                    </div>
                </div>
                    <%--Comments--%>

                    <%--Favorites--%>
                <div class="col-md-6">
                    <div class="panel panel-default">
                        <div class="favorites-heading"></div>
                        <div style="margin-top: .5em">
                            <h4 style="text-transform: uppercase; color: #9f9f9f;"><spring:message
                                    code="favorites"/></h4></div>
                        <div class="panel-body">
                            <h6><spring:message code="your_favorites"/></h6>
                            <p></p>
                            <h6><spring:message code="favorites"/>&nbsp<span
                                    class="badge">${favorites}</span></h6>
                            <br>
                            <a href="/favorites/page/1" class="btn btn-active"><spring:message
                                    code="go_to_favorites"/></a>
                        </div>
                    </div>
                </div>
                    <%--Favorites--%>
            </div>
        </div>
        <%--Available user pages--%>
    </sec:authorize>

    <%--Anonymous upload form--%>
    <sec:authorize var="loggedIn" access="isAnonymous()">
    <div align="center">
        <h4><spring:message code="select_file_to_upload"/></h4>
    </div>
    <div class="col-md-12" align="center">
        <form action="/add_photo" enctype="multipart/form-data" method="POST">

            <div class="col-lg-4 col-le-offset-4 col-md-4 col-md-offset-4 col-sm-4 col-sm-offset-4">
                <div class="input-group">
                    <label class="input-group-btn">
                    <span class="btn btn-default">
                        <spring:message code="browse"/>&hellip;
                        <input type="file" style="display: none;" name="photo" id="photo"
                               accept="image/gif, image/jpeg, image/png" onchange="checkSize(this)">
                    </span>
                    </label>
                    <input type="text" class="form-control" readonly>
                </div>
                    <%--<span class="help-block">--%>
                    <%--Try selecting one or more files and watch the feedback--%>
                    <%--</span>--%>
            </div>

                <%--<input type="file" name="photo" id="photo" accept="image/gif, image/jpeg, image/png"--%>
                <%--onchange="checkSize(this)">--%>
            <div class="col-lg-12 col-md-12 col-sm-12">
                <h6><spring:message code="supported_format_and_size"/></h6>
                <button type="submit" class="btn btn-active" id="btn2" name="btn2"><spring:message
                        code="upload"/></button>
            </div>
        </form>
    </div>
        <%--Logo--%>
    <div class="container col-md-6 col-md-offset-3">
        <h2>#myphotos</h2>
        <div class="col-md-6 col-md-offset-5">
            <h5 class="pull-right" style="margin-top: -1.75em;">ONE CLICK AWAY. ALWAYS</h5>
        </div>
            <%--Logo--%>
        </sec:authorize>
        <%--Anonymous upload form--%>
    </div>
</div>
<div id="footer">
    &copy 2016 #myphotos
</div>
</body>
</html>
