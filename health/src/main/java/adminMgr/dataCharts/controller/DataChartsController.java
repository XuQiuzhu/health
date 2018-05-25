package adminMgr.dataCharts.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import adminMgr.dataCharts.service.IDataChartsService;

@Controller
@RequestMapping("/DataChartsController")
public class DataChartsController {

	@Autowired
	private IDataChartsService dataChartsService;
	
}
