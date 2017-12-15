package com.techelevator.npgeek;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.techelevator.Dao.ParkDao;
import com.techelevator.model.Park;
import com.techelevator.model.Survey;
import com.techelevator.model.Weather;

@Controller
@SessionAttributes("tempChoice")
public class NationalParksController {
	
	private ParkDao parkDao;
	
	@Autowired
	public NationalParksController(ParkDao parkDao) {
		this.parkDao = parkDao;
	}
	
	@RequestMapping (path = {"/", "/HomePage"}, method = RequestMethod.GET)
	public String showParkList(ModelMap model) {
		model.addAttribute("allParks", parkDao.getAllParks());
		return "HomePage";
	}
	
	@RequestMapping (path = "/ParkDetail", method = RequestMethod.GET)
	public String showParkDetail(ModelMap model, HttpServletRequest request) {
		String tempChoice = "Fahrenheit";
		if(request.getParameter("tempChoice") != null) {
			tempChoice = request.getParameter("tempChoice");
		}
		model.addAttribute("tempChoice", tempChoice);
		
		Park park = new Park();
		park.setParkCode(request.getParameter("parkCode"));
		model.addAttribute("park", parkDao.getPark(park.getParkCode()));
		List<Weather> weatherList = new ArrayList<Weather>();
		weatherList = parkDao.getWeekForecast(park.getParkCode(), tempChoice);
		model.addAttribute("weatherList", weatherList);
		
	return "ParkDetail";
	}
	
	@RequestMapping (path = "/SurveyPage", method = RequestMethod.GET)
	public String showSurveyPage(ModelMap model) {
		model.addAttribute("allParks", parkDao.getAllParks());
		return "SurveyPage";
	}
	
	@RequestMapping (path="/FavoriteParks", method= RequestMethod.POST)
	public String postSurveyResults(Survey survey) {
		parkDao.createSurveyResult(survey.getParkCode(), survey.getEmail(), survey.getState(), survey.getActivityLevel());
		return "redirect:/FavoriteParks";
	}
	
	@RequestMapping(path="/FavoriteParks", method= RequestMethod.GET)
	public String getFavoriteParks(ModelMap model) {
		model.addAttribute("favoriteParks", parkDao.getFavoriteParks());
		return "FavoriteParks";
	}
}
