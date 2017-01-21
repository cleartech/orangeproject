<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<style>
    body {
        /*padding-top: 70px;*/
        /*background-position: left top;*/
        /*background-repeat: no-repeat;*/
        background-color: #1a9b9b;
    }

    h1 {
        font-size: 6.5em;
    }

    #errorMessage {
        font-size: 0.8em;
    }

    .btn-inactive {
        color: #484848;
        background-color: #f2f2f2;
        border-color: #f2f2f2;
        margin-top: .1em;
        margin-bottom: .1em;
        min-width: 10em;
    }
    .btn-inactive:hover, .btn-inactive:focus, .btn-inactive:active, .btn-inactive:active:focus, .btn-inactive.active, .open>.dropdown-toggle.btn-inactive {
        color: #484848;
        background-color: #cecece;
        border-color: #cecece;
        outline: none !important;
    }
    * {
        border-radius: 0 !important;
    }
</style>
<html>
<head>
    <title>MyPhotos - Error page</title>
</head>
<link rel="icon" type="image/x-icon" href="/resources/fav16x16.png">
<body>

<!--Header-->
<div class="container col-md-12" align="center">
    <h1 style="color: #ececec;">YOU SHOULD NEVER HAVE TO SEE THIS PAGE</h1>
    <h2 style="color: #bfbfbf;">WE ARE SO SORRY BUT %#^@# HAPPENS SOMETIMES</h2>
    <span class="help-block" style="color: #efefef;">PLEASE SEND US ERROR INFORMATION BELOW:</span>
</div><!--Header-->

<!--Error info-->
<div class="container col-md-8 col-md-offset-2">
    <table class="table table-bordered table-condensed" id="errorMessage">
        <tbody style="color: #333333;">
        <tr>
            <td>DATE</td>
            <td>${datetime}</td>
        </tr>
        <tr>
            <td>EXCEPTION</td>
            <td>${exception}</td>
        </tr>
        <tr>
            <td>EXCEPTION MESSAGE</td>
            <td>${exceptionMessage}</td>
        </tr>
        <tr>
            <td>URL</td>
            <td>${url}</td>
        </tr>
        <tr>
            <td>URI</td>
            <td>${uri}</td>
        </tr>
        <tr>
            <td>STACK TRACE</td>
            <td>
                <c:forEach items="${exception.stackTrace}" var="ste">
                    ${ste}
                </c:forEach>
            </td>
        </tr>
        </tbody>
    </table>
</div><!--Error info-->

<!--Back link-->
<div class="container col-md-12" align="center" style="margin-bottom: 2em;">
    <button class="btn btn-inactive"
            onclick="window.location='/';">MAIN PAGE
    </button>
</div><!--Back link-->
</body>
</html>
