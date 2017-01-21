<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

    a {
        color: #1a9b9b;
        text-decoration: none;
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
    }

</style>

<html>
<head>
    <title>MyPhoto - image hosting</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<link rel="icon" type="image/x-icon" href="/resources/fav16x16.png">
<body>
<c:if test="${param.logout ne null}">
    <body background="<c:url value="/resources/bye-layers-v5.png"/>"
          style="background-repeat:no-repeat center center fixed;
-webkit-background-size:cover;
-moz-background-size:cover;
-o-background-size:cover;
background-size:cover;
background-position:center"/>
</c:if>
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
                #myphoto</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="<c:url value="/browse/albums/latest/1" />"><spring:message code="browse"/></a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
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

<div class="col-md-12" align="center">
    <c:if test="${param.registered ne null}">
        <h2 style="color: #1a9b9b; font-weight: 100;"><spring:message code="success_register"/></h2></p>
        <p><h6 style="color: #cecece; font-weight: 100;"><spring:message code="enter_login_and_pasword"/></h6>
    </c:if>
</div>

<div class="col-md-12" align="center">
    <c:if test="${param.logout ne null}">
        <h1 style="color: #1a9b9b; font-weight: 100;"><spring:message code="see_you_next_time"/></h1></p>
    </c:if>
</div>

<div class="col-md-12" align="center">
    <c:if test="${param.error ne null}">
        <h3 style="color: #1a9b9b; font-weight: 100;"><spring:message code="wrong_login"/></h3>
    </c:if>
</div>

<c:url value="/j_spring_security_check" var="loginUrl"/>

<div style="margin-left: 1em; margin-right: 1em;">
    <form class="form-horizontal col-md-2 col-md-offset-5" action="${loginUrl}" method="POST">
        <div class="form-group"><input type="text" class="form-control input-md" name="j_login"
                                       placeholder="<spring:message code="login"/>"></div>
        <div class="form-group"><input type="password" class="form-control input col-md-2" name="j_password"
                                       placeholder="<spring:message code="password"/>"></div>
        <div class="form-group"><input class="btn btn-active btn-block" type="submit"
                                       value="<spring:message code="log_in"/>"/></div>
        <p style="color: #8f8f8f; font-weight: 100;" align="center"><spring:message code="not_registered"/></p>
        <div class="form-group" align="center"><a href="/register"
                                                  style="text-transform: uppercase;">
            <spring:message code="create_account"/></a>
        </div>
    </form>
</div>
<div id="footer">
    &copy 2016 #myphoto
</div>
</body>
</html>
