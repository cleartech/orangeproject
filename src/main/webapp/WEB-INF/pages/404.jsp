<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<style>
    body {
        background-color: #1a9b9b;
    }
    #container {
        position: relative;
        margin-top: 5em;
    }
    #background {
        position: absolute;
        top: 0;
        left: 10%;
        bottom: 0;
        right: 0;
        z-index: -1;
        font-size: 20em;
        font-weight: 100;
        color: #1aa1a1;
    }
    .h2error {
        font-size: 4.5em;
        font-weight: 100;
        color: #bfbfbf;
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
    <title>MyPhotos - not found</title>
</head>
<link rel="icon" type="image/x-icon" href="/resources/fav16x16.png">
<body>
<div id="container">

    <div id="background">
        404
    </div>
    <div class="container col-md-12" align="left">
    <h2 class="h2error"><spring:message code="album_not_found"/></h2>
    </div>
</div>

<!--Back link-->
<div class="container col-md-12" align="center" style="margin-bottom: 2em;">
    <button class="btn btn-inactive"
            onclick="window.location='#';">GO BACK
    </button>
    <button class="btn btn-inactive"
            onclick="window.location='/';">MAIN PAGE
    </button>
</div><!--Back link-->
</body>
</html>
