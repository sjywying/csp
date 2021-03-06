package com.taobao.csp.depend.job.eagleeye;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.taobao.monitor.common.po.CspEagleeyeApiRequestDay;
import com.taobao.monitor.common.po.CspEagleeyeApiRequestPart;
import com.taobao.monitor.common.po.EagleeyeChildAppListPo;

public class EagleeyeFatherAppAnalyse extends EagleeyeAnalyse{
	private static EagleeyeFatherAppAnalyse po = new EagleeyeFatherAppAnalyse();
	
	public static EagleeyeAnalyse get() {
		return po;
	}
	
	@Override
	public CspEagleeyeApiRequestDay changePartToDay(String jsonContent,
			List<CspEagleeyeApiRequestPart> partList) {
//		if(partList.size() == 0 || partList == null) {
//			logger.error("partList= null or partList.size() = 0");
//			return null;
//		}
		
		EagleeyeChildAppListPo dayPo = JSONObject.parseObject(jsonContent, EagleeyeChildAppListPo.class);
		
		CspEagleeyeApiRequestPart part = partList.get(0);
		
		if(partList.size()>1) {
			for(int i=1; i<partList.size(); i++) {
				try {
					EagleeyeChildAppListPo partApiPo = JSONObject.parseObject(
							partList.get(i).getResponseContent(),
							EagleeyeChildAppListPo.class);
					addPartToDayPo(dayPo, partApiPo);
				} catch (Exception e) {
					logger.error("", e);
				}
			}
		}
		
		CspEagleeyeApiRequestDay day = new CspEagleeyeApiRequestDay();
		day.setAppName(part.getAppName());
		day.setApiType(part.getApiType());
		day.setCollectTime(part.getCollectTime());
		day.setSourcekey(part.getSourcekey());
		day.setVersion(part.getVersion());
		day.setResponseContent(JSONObject.toJSONString(dayPo));
		
		return day;
	}
	
	@Override
	protected void addPartToDayPo(Object dayObj, Object partPoObj) throws Exception {
		  
		  if(!(dayObj instanceof EagleeyeChildAppListPo) || !(partPoObj instanceof EagleeyeChildAppListPo)) {
			  throw new Exception("参数类型不符合预期");
		  }
		  
		  EagleeyeChildAppListPo day = (EagleeyeChildAppListPo)dayObj;
		  EagleeyeChildAppListPo partPo = (EagleeyeChildAppListPo)partPoObj;
		  
		  if(day == null || partPo == null || !(day.getAppName().equals(partPo.getAppName())))
			  return;
		  
		  day.setFaliRt(partPo.getFaliRt() + day.getFaliRt());
		  day.setFailCallNum(partPo.getFailCallNum() + day.getFailCallNum());
		  day.setSuccessCallNum(partPo.getSuccessCallNum() + day.getSuccessCallNum());
		  day.setSuccessRt(partPo.getSuccessRt() + day.getSuccessRt());
		  
		  List<EagleeyeChildAppListPo> dayNextStepList = day.getChildList();
		  List<EagleeyeChildAppListPo> partNextStepList = partPo.getChildList();
		  
		  for(EagleeyeChildAppListPo tmpPartPo : partNextStepList) {
			  boolean isPartInDay = false;
			  for(EagleeyeChildAppListPo tmpDayPo: dayNextStepList) {
				  if(tmpPartPo.getAppName().equals(tmpDayPo.getAppName())) {
					  isPartInDay = true;
					  addPartToDayPo(tmpDayPo, tmpPartPo);
					  break;
				  }
			  }
			  if(!isPartInDay) {
				  dayNextStepList.add(tmpPartPo);
			  }
		  }
	}

	@Override
	public void addApiDayToTopo(CspEagleeyeApiRequestDay dayObj) {
	}

	@Override
	public void addApiDayToEagleeyeAuto(CspEagleeyeApiRequestDay dayObj) {
	}
}
