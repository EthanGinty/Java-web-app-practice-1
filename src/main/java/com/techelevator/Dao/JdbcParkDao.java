package com.techelevator.Dao;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import com.techelevator.model.FavoriteParks;
import com.techelevator.model.Park;
import com.techelevator.model.Weather;

@Component
public class JdbcParkDao implements ParkDao{
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public JdbcParkDao(DataSource datasource) {
		this.jdbcTemplate =  new JdbcTemplate(datasource);
	}
	@Override
	public List<Park> getAllParks(){
		ArrayList<Park> allParks = new ArrayList<>();
		String sqlGetAllParks = "SELECT * FROM park";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetAllParks);
		while(results.next()) {
			allParks.add(mapRowToPark(results));
		}
		return allParks;
	}
	@Override
	public Park getPark(String parkCode) {
		Park thePark = new Park();
		String sqlGetPark = "SELECT * FROM park WHERE parkcode = '"+parkCode+"'";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetPark);
		results.next();
		thePark = mapRowToPark(results);
		return thePark;
	}
	@Override
	public List<Weather> getWeekForecast(String parkCode, String tempChoice) {
		List<Weather> weeklyForecast = new ArrayList<>();
		String sqlGetWeeklyForecast = "SELECT * FROM weather WHERE parkcode = '"+parkCode+"'";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetWeeklyForecast);
		while(results.next()) {
			Weather weather = mapRowToWeather(results);
			if(tempChoice.equals("Celcius")){
				weather = convertTempToCelcius(weather);
			}
			weeklyForecast.add(weather);
		}
		return weeklyForecast;
	}
	
	@Override
	public void createSurveyResult(String parkCode, String emailAddress, String state, String activityLevel) {
		String sqlCreateSurveyResult = "INSERT INTO survey_result (parkcode, emailaddress, state, activitylevel) VALUES (?,?,?,?)";
		jdbcTemplate.update(sqlCreateSurveyResult, parkCode, emailAddress, state, activityLevel);
	}
	
	@Override
	public List<FavoriteParks> getFavoriteParks() {
		List<FavoriteParks> favoriteParks = new ArrayList<>();
		String sqlGetFavoriteParks = "SELECT parkname, count(park.parkcode) FROM park "
				+ "INNER JOIN survey_result ON survey_result.parkcode = park.parkcode "
				+ "WHERE park.parkcode IN ("
				+ "SELECT parkcode FROM survey_result "
				+ "GROUP BY parkcode "
				+ "ORDER BY count(parkcode)) "
				+ "GROUP BY parkname "
				+ "ORDER BY count(park.parkcode) DESC, parkname";
		SqlRowSet results = jdbcTemplate.queryForRowSet(sqlGetFavoriteParks);
		while(results.next()) {
			favoriteParks.add(mapRowToFavoriteParks(results));
		}
		return favoriteParks;
	}
	
	private Weather convertTempToCelcius(Weather weather) {
		weather.setLow((int)((weather.getLow()-32)*0.5556));
		weather.setHigh((int)((weather.getHigh()-32)*0.5556));
		return weather;
	}
	
	private FavoriteParks mapRowToFavoriteParks(SqlRowSet results) {
		FavoriteParks favParks = new FavoriteParks();
		favParks.setParkName(results.getString("parkname"));
		favParks.setCount(results.getInt("count"));
		return favParks;
	}
	
	private Park mapRowToPark(SqlRowSet results) {
		Park newPark = new Park();
		newPark.setParkCode(results.getString("parkcode"));
		newPark.setParkName(results.getString("parkname"));
		newPark.setState(results.getString("state"));
		newPark.setAcreage(results.getInt("acreage"));
		newPark.setElevationInFeet(results.getInt("elevationinfeet"));
		newPark.setMilesOfTrail(results.getDouble("milesoftrail"));
		newPark.setNumberOfCampsites(results.getInt("numberofcampsites"));
		newPark.setClimate(results.getString("climate"));
		newPark.setYearFounded(results.getInt("yearfounded"));
		newPark.setAnnualVisitorCount(results.getInt("annualvisitorcount"));
		newPark.setInspirationalQuote(results.getString("inspirationalquote"));
		newPark.setInspirationalQuoteSource(results.getString("inspirationalquotesource"));
		newPark.setParkDescription(results.getString("parkdescription"));
		newPark.setEntryFee(results.getInt("entryfee"));
		newPark.setNumberOfAnimalSpecies(results.getInt("numberofanimalspecies")); 

		return newPark;
	}
	
	private Weather mapRowToWeather(SqlRowSet results) {
		Weather theWeather = new Weather();
		theWeather.setParkCode(results.getString("parkcode"));
		theWeather.setFiveDayForecastValue(results.getInt("fiveDayForecastValue"));
		theWeather.setForecast(results.getString("forecast"));
		theWeather.setHigh(results.getInt("high"));
		theWeather.setLow(results.getInt("low"));
		return theWeather;
			
	}
	
}
