package adminMgr.dataCharts.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import adminMgr.dataCharts.dao.IDataChartsDao;
import adminMgr.dataCharts.service.IDataChartsService;

@Service
@Transactional
public class DataChartsServiceImpl implements IDataChartsService {

	@Autowired
	private IDataChartsDao dataChartsDao;
	
}
