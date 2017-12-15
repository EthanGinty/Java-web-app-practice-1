<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:import url="/WEB-INF/jsp/common/Header.jsp" />

<div style="margin:20px;">
<c:url var="formAction" value="/FavoriteParks"></c:url>
<form method="POST" action="${formAction}">
<div>
<label for="parkCode">Favorite National Park: </label>
<select name="parkCode" id="parkCode" required>
<option value="" disabled selected>Select a Park</option>
<c:forEach var="park" items="${allParks}">
<option value="${park.parkCode}">${park.parkName}</option>
</c:forEach>
</select>
</div>

    <div>
        <label for="email">Your email: </label>
        <input type="email" placeholder="Enter your email" name="email" id="email" required>
    </div>
    
    <div>
        <label for="state">State of Residence: </label>
        <select name="state" id="state" required>
            <option value="" disabled selected>Select a state</option>
            <option value="Alabama">Alabama</option>
            <option value="Alaska">Alaska</option>
            <option value="Arizona">Arizona</option>
            <option value="Arkansas">Arkansas</option>
            <option value="California">California</option>
            <option value="Colorado">Colorado</option>
            <option value="Connecticut">Connecticut</option>
            <option value="Delaware">Delaware</option>
            <option value="Florida">Florida</option>
            <option value="Georgia">Georgia</option>
            <option value="Hawaii">Hawaii</option>
            <option value="Idaho">Idaho</option>
            <option value="Illinois">Illinois</option>
            <option value="Indiana">Indiana</option>
            <option value="Iowa">Iowa</option>
            <option value="Kansas">Kansas</option>
            <option value="Kentucky">Kentucky</option>
            <option value="Louisiana">Louisiana</option>
            <option value="Maine">Maine</option>
            <option value="Maryland">Maryland</option>
            <option value="Massachusetts">Massachusetts</option>
            <option value="Michigan">Michigan</option>
            <option value="Minnesota">Minnesota</option>
            <option value="Mississippi">Mississippi</option>
            <option value="Missouri">Missouri</option>
            <option value="Montana">Montana</option>
            <option value="Nebraska">Nebraska</option>
            <option value="Nevada">Nevada</option>
            <option value="New Hampshire">New Hampshire</option>
            <option value="New Jersey">New Jersey</option>
            <option value="New Mexico">New Mexico</option>
            <option value="New York">New York</option>
            <option value="North Carolina">North Carolina</option>
            <option value="North Dakota">North Dakota</option>
            <option value="Ohio">Ohio</option>
            <option value="Oklahoma">Oklahoma</option>
            <option value="Oregon">Oregon</option>
            <option value="Pennsylvania">Pennsylvania</option>
            <option value="Rhode Island">Rhode Island</option>
            <option value="South Carolina">South Carolina</option>
            <option value="South Dakota">South Dakota</option>
            <option value="Tennessee">Tennessee</option>
            <option value="Texas">Texas</option>
            <option value="Utah">Utah</option>
            <option value="Vermont">Vermont</option>
            <option value="Virginia">Virginia</option>
            <option value="Washingto">Washington</option>
            <option value="West Virginia">West Virginia</option>
            <option value="Wisconsin">Wisconsin</option>
            <option value="Wyoming">Wyoming</option>
        </select>
    </div>
    
    <div>
        <span>Activity Level: </span>
        <label for="activityLevel">Inactive</label>
        <input type="radio" name="activityLevel" id="inactive" value="Inactive" checked="checked" required/>
        
        <label for="activityLevel">Sedentary</label>
        <input type="radio" name="activityLevel" id="sedentary" value="Sedentary"/>
        
        <label for="activityLevel">Active</label>
        <input type="radio" name="activityLevel" id="active" value="Active"/>
        
        <label for="activityLevel">Extremely Active</label>
        <input type="radio" name="activityLevel" id="extremelyActive" value="Extremely Active"/>
    </div>
    
    <div>
        <input type="submit" value="Submit"/>
    </div>

</form>
</div>

<c:import url="/WEB-INF/jsp/common/Footer.jsp" />