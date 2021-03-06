package com.taobao.monitor.alarm.trade.realtime;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimerTask;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.log4j.Logger;

public class RealTimeTradeThirdTask extends TimerTask {
	private static final Logger logger = Logger.getLogger(RealTimeTradeTask.class);
	private static SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
	private static String URL = "http://tradereport.taobao.org/sharereport/sumRealTimeTrade.do?";
	//http://10.232.10.195:8080/sharereport/sumRealTimeTrade.do?start=2011-11-07T05:00:00&end=2011-11-07T05:01:00&interval=third;
	private HttpClient httpClient = new HttpClient();
	@Override
	public void run() {
		Date start = new Date();
		start.setTime(start.getTime()-21000);		//延迟21s，查询21s前的数据
		StringBuilder sbCreate = new StringBuilder(URL);
		sbCreate.append("start=").append(sdfTime.format(start)).append("&end=").append(sdfTime.format(start)).append("&interval=third&invalid=true");
		logger.warn("getReadlTimeTradeByTime,createUrl=" + sbCreate.toString());
		GetMethod getMethodCreate = new GetMethod(sbCreate.toString());
		List<Header> headers = new ArrayList<Header>();
		headers.add(new Header("Content-Type","application/x-www-form-urlencoded"));
		httpClient.getHostConfiguration().getParams().setParameter("http.default-headers", headers);
		httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(5000);
		httpClient.getHttpConnectionManager().getParams().setSoTimeout(5000);
		try {
			int statusCodeCreate = httpClient.executeMethod(getMethodCreate);
			if (statusCodeCreate != HttpStatus.SC_OK) {
				logger.warn("RealTimeTradeThirdTask get Time=" + sdfTime.format(start));
			}
		} catch (Exception e) {
			logger.warn("RealTimeTradeThirdTask exception,url=" + sbCreate.toString(), e);
		} finally {
			getMethodCreate.releaseConnection();
		}
		getMethodCreate = null;
	}
}
