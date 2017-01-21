<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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

    .mythumbnail {
        position: relative;
        width: 200px;
        height: 200px;
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

    .mythumbnail img.portrait {
        width: 100%;
        height: auto;
    }

    .textcare {
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
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

</style>
<html>
<head>
    <title>MyPhotos - view album</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<link rel="icon" type="image/x-icon" href="/resources/fav16x16.png">
<body>
<c:url var="firstUrl" value="/albums/view/${album.albumUID}/1"/>
<c:url var="lastUrl" value="/albums/view/${album.albumUID}/${page.totalPages}"/>
<c:url var="prevUrl" value="/albums/view/${album.albumUID}/${currentIndex - 1}"/>
<c:url var="nextUrl" value="/albums/view/${album.albumUID}/${currentIndex + 1}"/>

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

<c:if test="${param.itemLimit ne null}">
    <div class="container col-md-12">
        <div class="alert alert-warning alert-dismissible" align="center" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button>
                <%--<spring:message code="notsupportedformat"/>--%>
            <spring:message code="image_limit"/>
        </div>
    </div>
</c:if>

<c:if test="${param.emptyUpload ne null}">
    <div class="container col-md-12">
        <div class="alert alert-warning alert-dismissible" align="center" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button>
            <spring:message code="select_file_to_upload"/>
        </div>
    </div>
</c:if>

<c:if test="${param.nonimageSkipped ne null}">
    <div class="container col-md-12">
        <div class="alert alert-warning alert-dismissible" align="center" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                    aria-hidden="true">&times;</span></button>
            <spring:message code="non_image_skipped"/>
        </div>
    </div>
</c:if>

<div class="container" align="center">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <h1 class="textcare" style="color: #1a9b9b;">${fn:toUpperCase(album.albumName)}</h1>
    </div>
</div>
<c:if test="${album.albumDescr ne null}">
    <div class="container" align="center">
        <h6 style="color: #a0a0a0; font-weight: 100;">${fn:toUpperCase(album.albumDescr)}</h6>
    </div>
</c:if>

<%--load files--%>
<sec:authorize var="loggedIn" access="isAuthenticated()">
    <c:if test="${album.user.login == pageContext.request.userPrincipal.name}">
        <div class="container" align="center">
            <form action="/album/${albumUid}/add-multiple-pics" enctype="multipart/form-data" method="POST">

                <div class="col-lg-4 col-le-offset-4 col-md-4 col-md-offset-4 col-sm-4 col-sm-offset-4"
                     style="margin-bottom: .5em;">
                    <div class="input-group">
                        <label class="input-group-btn">
                    <span class="btn btn-default">
                        <spring:message code="browse"/>&hellip;
                        <input type="file" style="display: none;" name="photo" id="photo"
                               accept="image/gif, image/jpeg, image/png" class="inputfile inputfile-1"
                               data-multiple-caption="{count} files selected" multiple
                               onchange="javascript:FileDetails(this)">
                    </span>
                        </label>
                        <input type="text" class="form-control" readonly>
                    </div>
                </div>
                <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-6">
                    <input type="submit" class="btn btn-active" value="<spring:message code="upload"/>"
                           onclick="javascript:showMessage()">
                </div>
            </form>
        </div>
        <div id="fileList" align="center"></div>
    </c:if>
</sec:authorize>


<c:if test="${album.user.login != pageContext.request.userPrincipal.name}">
    <div class="container" align="center">
        <h6 style="color: #cecece; font-weight: 100;">
            <spring:message code="uploader"/>: <a
                href="/user/${album.user.login}">${fn:toUpperCase(album.user.login)}</a></h6>
        <h6 style="color: #cecece; font-weight: 100;"><spring:message code="go_to"/>
            <a href="/${album.user.login}/albums/page/1"><spring:message code="to_albums"/></a></h6>
    </div>
</c:if>

<%--Header--%>
<div class="container" align="center" style=" margin-top: .5em; margin-bottom: 1em;">
    <c:choose>
        <c:when test="${fn:length(album.albumItems) gt 1}">
            <sec:authorize var="loggedIn" access="isAuthenticated()">
                <button class="btn btn-active" onclick="window.location='/albums/page/1';">
                    <spring:message code="back_to_my_albums"/></button>
            </sec:authorize>
            <button class="btn btn-active" data-toggle="modal" data-target=".bs-example-modal-lg">
                <spring:message code="view_slideshow"/></button>
        </c:when>
        <c:otherwise>
            <button class="btn btn-active" onclick="window.location='/albums/page/1';">
                <spring:message code="back_to_my_albums"/></button>
        </c:otherwise>
    </c:choose>
</div>

<%--pagination--%>
<c:if test="${fn:length(album.albumItems) gt 12}">
    <div class="container" align="center">
            <%--<div class="pagination">--%>
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
                <c:url var="pageUrl" value="/albums/view/${album.albumUID}/${i}"/>
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
            <%--</div>--%>
    </div>
</c:if>
<%--pagination--%>

<%--images grid--%>
<div class="container" align="center" style="margin-bottom: 2em;">

    <div class="row">
        <c:forEach items="${page.content}" var="row">

            <div class="col-lg-3 col-md-3 col-sm-4 col-xs-6">
                <div class="mythumbnail">
                    <a href="/view-album-item/${row.uId}/${currentIndex}"><img src="/view-item/${row.uId}"></a>
                </div>
                <div class="caption">
                    <c:set var="itemName" value="${row.name}"/>
                    <c:set var="lenght" value="${fn:length(itemName)}"/>

                    <c:choose>
                        <c:when test="${itemName.length() > 28}">
                            <c:set var="cutted"
                                   value="${fn:substring(itemName, 0, 15)}${'...'}${fn:substring(itemName, lenght - 10, lenght)}"/>
                            <small>${cutted}</small>
                        </c:when>

                        <c:otherwise>
                            <small>${itemName}</small>
                        </c:otherwise>
                    </c:choose>
                    <br>
                    <span class="glyphicon glyphicon-eye-open">&nbsp;${row.views}</span>&nbsp;&nbsp;
                    <span class="glyphicon glyphicon-star">&nbsp;${row.rating}</span>&nbsp;&nbsp;
                    <span class="glyphicon glyphicon-comment">&nbsp;${fn:length(row.comments)}</span>
                    <p>
                        <c:if test="${pageContext.request.userPrincipal.name == row.user.login ||
                            pageContext.request.isUserInRole('ADMIN')}">
                            <a href="/delete-item/${row.album.albumUID}/${row.uId}/${currentIndex}"
                               id="${row.uId}" class="btn btn-danger btn-sm" role="button"><spring:message
                                    code="delete"/></a>
                        </c:if>
                    </p>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<%--images grid--%>

<%--pagination--%>
<c:if test="${fn:length(album.albumItems) gt 12}">
    <div class="container" align="center" style="margin-bottom: 1.5em;">
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
                <c:url var="pageUrl" value="/albums/view/${album.albumUID}/${i}"/>
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
            <%--</div>--%>
    </div>
</c:if>
<%--pagination--%>

<%--carousel--%>
<div class="container text-center">
    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">

                    <!-- Wrapper for slides -->
                    <div class="carousel-inner">
                        <c:forEach items="${album.albumItems}" var="item" varStatus="stat">
                            <!-- only the first element in the set is visible: -->
                            <c:if test="${stat.first}">
                                <div class="item active">
                                    <img class="img-responsive" src="/view-item/${item.uId}">
                                    <div class="carousel-caption">
                                            ${item.name}
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${!stat.first}">
                                <div class="item">
                                    <img class="img-responsive" src="/view-item/${item.uId}">
                                    <div class="carousel-caption">
                                            ${item.name}
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>

                    <!-- Controls -->
                    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left"></span>
                    </a>
                    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right"></span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<%--carousel--%>
<div id="footer">
    &copy 2016 #myphotos
</div>
<script>
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

    showMessage = function () {
        var inp = document.getElementById('fileList');
        inp.innerHTML = '';
        inp.innerHTML +=
                '<span style="color: #cecece; font-weight: 100;">' +
                'PLEASE WAIT...UPLOADING' + '</span>';
    }


    $(document).ready(function () {
        var maxHeight = 0;
        $(".equalize").each(function () {
            if ($(this).height() > maxHeight) {
                maxHeight = $(this).height();
            }
        });
        $(".equalize").height(maxHeight);
    });

    function goBack() {
        window.location.href = '/albums';
    }

    function FileDetails(input) {

        document.getElementById('fileList').innerHTML =
                '';

        // GET THE FILE INPUT.
        var fi = document.getElementById('photo');

        // VALIDATE OR CHECK IF ANY FILE IS SELECTED.
        if (fi.files.length > 0) {

            // RUN A LOOP TO CHECK EACH SELECTED FILE.
            for (var i = 0; i <= fi.files.length - 1; i++) {

                if (i > 9) {
                    alert("Max 10 files at once");
                    input.value = null;
                    document.getElementById('fileList').innerHTML =
                            '';
                    return;
                }

                var fname = fi.files.item(i).name;      // THE NAME OF THE FILE.
                var fsize = fi.files.item(i).size;      // THE SIZE OF THE FILE.
                if (fi.files.item(i).size > 2 * 1024 * 1024) {

                    alert("File too large. Max 2MB allowed.");
                    input.value = null;
                    document.getElementById('fileList').innerHTML =
                            '';
                    return;
                }

                // SHOW THE EXTRACTED DETAILS OF THE FILE.
                document.getElementById('fileList').innerHTML =
                        document.getElementById('fileList').innerHTML + '<br /> ' +
                        '<span style="text-transform: uppercase; color: #cecece; font-weight: 100;">' +
                        fname + ' (' + getReadableFileSizeString(fsize) + ')</span>';
            }
        }
        else {
            alert('Please select a file.')
        }
    }

    function getReadableFileSizeString(fileSizeInBytes) {

        var i = -1;
        var byteUnits = [' kB', ' MB', ' GB', ' TB', 'PB', 'EB', 'ZB', 'YB'];
        do {
            fileSizeInBytes = fileSizeInBytes / 1024;
            i++;
        } while (fileSizeInBytes > 1024);

        return Math.max(fileSizeInBytes, 0.1).toFixed(1) + byteUnits[i];
    }
    ;

</script>
</body>
</html>
