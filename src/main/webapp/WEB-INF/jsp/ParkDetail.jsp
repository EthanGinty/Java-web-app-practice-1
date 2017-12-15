<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="/WEB-INF/jsp/common/Header.jsp" />

<c:url value="/img/parks/${park.parkCode.toLowerCase()}.jpg"
	var="parkImg" />
<div class="detailInfo">
	<img id="detailImage" src="${parkImg}" alt="Park Image" />
	<h2>${park.parkName}</h2>
	<h3>${park.state}</h3>
	<p>Climate: ${park.climate}</p>
	<p>${park.acreage}Square Acres | ${park.elevationInFeet} Feet in Elevation | ${park.milesOfTrail} Miles of Trail | ${park.numberOfCampsites} Campsites</p>
	<p>Visitors per year: ${park.annualVisitorCount} | Entry Fee: $${park.entryFee}</p>
	<p>Number of Species in Park: ${park.numberOfAnimalSpecies}</p>
	<p>${park.inspirationalQuote}</p>
	<p>${park.inspirationalQuoteSource}</p>
	<p>Founded in ${park.yearFounded}
	<p>${park.parkDescription}</p>
	<c:url value="/ParkDetail" var="formAction" />
	<form action="${formAction}" method="GET">
		<input type="submit" name="tempChoice" value="Fahrenheit"> <input
			type="submit" name="tempChoice" value="Celcius"> <input
			type="hidden" value="${park.parkCode}" name="parkCode">
	</form>
</div>
<div id="weather">
	<h4 id="weatherHeader">5 Day Weather Forecast</h4>
	<c:forEach var="dailyWeather" items="${weatherList}"
		varStatus="dayNumber">
		<div id="weatherDay">
			<c:choose>
				<c:when test="${dailyWeather.fiveDayForecastValue == 1}">
					<div>
						<p id="todayHeader">Today</p>
						<c:url value="/img/weather/${dailyWeather.forecast}.png"
							var="weatherImg" />
						<img src="${weatherImg}" alt="Weather Image" />
					</div>
				</c:when>
				<c:otherwise>
					<div id="fourDay">
						<p id="dayHeader">Day ${dayNumber.count}</p>
						<c:url value="/img/weather/${dailyWeather.forecast}.png"
							var="weatherImg" />
						<img src="${weatherImg}" alt="Weather Image" />
					</div>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${tempChoice != null && tempChoice.equals('Celcius')}">
					<p>High: ${dailyWeather.high}ºC Low: ${dailyWeather.low}ºC</p>
					<c:if test="${dailyWeather.high>23.9}">
						<p>Bring an Extra Gallon of Water!</p>
					</c:if>
					<c:if test="${dailyWeather.high-dailyWeather.low>6.7}">
						<p>Wear Breathable Layers!</p>
					</c:if>
					<c:if test="${dailyWeather.low<-6.7}">
						<p>Danger! Don't Expose Yourself to Frigid Temperatures!</p>
					</c:if>
				</c:when>
				<c:otherwise>
					<p>High: ${dailyWeather.high}ºF Low: ${dailyWeather.low}ºF</p>
					<c:if test="${dailyWeather.high>75}">
						<p>Bring an Extra Gallon of Water!</p>
					</c:if>
					<c:if test="${dailyWeather.high-dailyWeather.low>20}">
						<p>Wear Breathable Layers!</p>
					</c:if>
					<c:if test="${dailyWeather.low<20}">
						<p>Danger! Don't Expose Yourself to Frigid Temperatures!</p>
					</c:if>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${dailyWeather.forecast == 'snow'}">
					<p>Pack Snowshoes!</p>
				</c:when>
				<c:when test="${dailyWeather.forecast =='rain'}">
					<p>Pack Rain Gear and Wear Waterproof Shoes!</p>
				</c:when>
				<c:when test="${dailyWeather.forecast == 'thunderstorms'}">
					<p>Seek Shelter and Avoid Hiking on Exposed Ridges!</p>
				</c:when>
				<c:when test="${dailyWeather.forecast == 'sunny'}">
					<p>Pack Sun-block!</p>
				</c:when>
				<c:otherwise>
					<p>Have a Wonderful Day!</p>
				</c:otherwise>
			</c:choose>
		</div>
	</c:forEach>
</div>

<c:import url="/WEB-INF/jsp/common/Footer.jsp" />