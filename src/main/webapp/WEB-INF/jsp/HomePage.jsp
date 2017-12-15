<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/WEB-INF/jsp/common/Header.jsp" />

<html>
<head>

<title>National Park Geek</title>
</head>
<body>
	<c:forEach var="park" items="${allParks}">
		<div class="homePageParks">
			<c:url value="/img/parks/${park.parkCode.toLowerCase()}.jpg"
				var="parkImg" />
			<img src="${parkImg}" alt="Park Image" />
			<div class="parkInfo">
			<c:url value = "/ParkDetail" var = "detailpage">
			<c:param name= "parkCode" value = "${park.parkCode}"/>
			<c:if test="${tempChoice != null}">
				<c:param name="tempChoice" value = "${tempChoice}"/>
			</c:if>
			</c:url>
				<a href = "${detailpage}">
					<h3>${park.parkName}</h3>
				</a>
				<p>${park.state}</p>
				<p>${park.parkDescription}</p>
			</div>
		</div>
	</c:forEach>


<c:import url="/WEB-INF/jsp/common/Footer.jsp" />