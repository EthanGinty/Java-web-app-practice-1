<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/WEB-INF/jsp/common/Header.jsp" />
	<table>
  <tr>
    <th>Favorite Parks</th>
    <th>Survey Results</th>
  </tr>
  <c:forEach var="park" items="${favoriteParks}">
	  <tr>
	    <td>${park.parkName}</td>
	    <td>${park.count}</td>
  </c:forEach>
</table>

<c:import url="/WEB-INF/jsp/common/Footer.jsp" />
