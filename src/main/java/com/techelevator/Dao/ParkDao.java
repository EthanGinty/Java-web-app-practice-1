package com.techelevator.Dao;

import java.util.List;

import org.springframework.context.annotation.Configuration;

import com.techelevator.model.FavoriteParks;
import com.techelevator.model.Park;
import com.techelevator.model.Weather;

@Configuration
public interface ParkDao {
	
	List<Park> getAllParks();
	Park getPark(String parkCode);
	List<Weather> getWeekForecast(String parkCode, String tempChoice);
	void createSurveyResult(String parkCode, String emailAddress, String state, String activityLevel);
	List<FavoriteParks> getFavoriteParks();
}
