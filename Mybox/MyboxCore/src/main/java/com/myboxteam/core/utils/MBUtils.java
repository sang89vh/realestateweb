package com.myboxteam.core.utils;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.ocpsoft.prettytime.PrettyTime;
import org.parse4j.ParseObject;
import org.springframework.util.StringUtils;

import com.fasterxml.jackson.databind.ObjectMapper;

public class MBUtils {
	private static final Logger logger = LogManager.getLogger(MBUtils.class);
	private static final SimpleDateFormat YYYYMMDD_DATE_FORMAT = new SimpleDateFormat(
			"yyyyMMdd");
	private static final SimpleDateFormat DDMMYYYY_DATE_FORMAT = new SimpleDateFormat(
			"ddMMyyyy");
	private static final SimpleDateFormat DDMMYYYY_DOT_DATE_FORMAT = new SimpleDateFormat(
			"dd.MM.yyyy");

	private static final SimpleDateFormat DD_MM_YYYY_DATE_FORMAT = new SimpleDateFormat(
			"dd/MM/yyyy");
	private static final SimpleDateFormat YYYY_MM_DD_DATE_FORMAT = new SimpleDateFormat(
			"yyyy-MM-dd");

	public static PrettyTime prettyTime = new PrettyTime();
	// public static PrettyTime prettyTime = new PrettyTime(new Locale("vi"));
	public static ObjectMapper mapperJackson = new ObjectMapper();
	private static char[] SPECIAL_CHARACTERS = {
			// ' ',
			'!',
			'"',
			'#',
			'$',
			'%',
			'*',
			'+',
			// ',',
			':', '<', '=', '>', '?', '@', '[', '\\', ']', '^', '`', '|', '~',
			'À', 'Á', 'Â', 'Ã', 'È', 'É', 'Ê', 'Ì', 'Í', 'Ò', 'Ó', 'Ô', 'Õ',
			'Ù', 'Ú', 'Ý', 'à', 'á', 'â', 'ã', 'è', 'é', 'ê', 'ì', 'í', 'ò',
			'ó', 'ô', 'õ', 'ù', 'ú', 'ý', 'Ă', 'ă', 'Đ', 'đ', 'Ĩ', 'ĩ', 'Ũ',
			'ũ', 'Ơ', 'ơ', 'Ư', 'ư', 'Ạ', 'ạ', 'Ả', 'ả', 'Ấ', 'ấ', 'Ầ', 'ầ',
			'Ẩ', 'ẩ', 'Ẫ', 'ẫ', 'Ậ', 'ậ', 'Ắ', 'ắ', 'Ằ', 'ằ', 'Ẳ', 'ẳ', 'Ẵ',
			'ẵ', 'Ặ', 'ặ', 'Ẹ', 'ẹ', 'Ẻ', 'ẻ', 'Ẽ', 'ẽ', 'Ế', 'ế', 'Ề', 'ề',
			'Ể', 'ể', 'Ễ', 'ễ', 'Ệ', 'ệ', 'Ỉ', 'ỉ', 'Ị', 'ị', 'Ọ', 'ọ', 'Ỏ',
			'ỏ', 'Ố', 'ố', 'Ồ', 'ồ', 'Ổ', 'ổ', 'Ỗ', 'ỗ', 'Ộ', 'ộ', 'Ớ', 'ớ',
			'Ờ', 'ờ', 'Ở', 'ở', 'Ỡ', 'ỡ', 'Ợ', 'ợ', 'Ụ', 'ụ', 'Ủ', 'ủ', 'Ứ',
			'ứ', 'Ừ', 'ừ', 'Ử', 'ử', 'Ữ', 'ữ', 'Ự', 'ự', };

	private static char[] REPLACEMENTS = {
			// '-',
			'\0',
			'\0',
			'\0',
			'\0',
			'\0',
			'\0',
			'_',
			// '\0',
			'_', '\0', '\0', '\0', '\0', '\0', '\0', '_', '\0', '\0', '\0',
			'\0', '\0', 'A', 'A', 'A', 'A', 'E', 'E', 'E', 'I', 'I', 'O', 'O',
			'O', 'O', 'U', 'U', 'Y', 'a', 'a', 'a', 'a', 'e', 'e', 'e', 'i',
			'i', 'o', 'o', 'o', 'o', 'u', 'u', 'y', 'A', 'a', 'D', 'd', 'I',
			'i', 'U', 'u', 'O', 'o', 'U', 'u', 'A', 'a', 'A', 'a', 'A', 'a',
			'A', 'a', 'A', 'a', 'A', 'a', 'A', 'a', 'A', 'a', 'A', 'a', 'A',
			'a', 'A', 'a', 'A', 'a', 'E', 'e', 'E', 'e', 'E', 'e', 'E', 'e',
			'E', 'e', 'E', 'e', 'E', 'e', 'E', 'e', 'I', 'i', 'I', 'i', 'O',
			'o', 'O', 'o', 'O', 'o', 'O', 'o', 'O', 'o', 'O', 'o', 'O', 'o',
			'O', 'o', 'O', 'o', 'O', 'o', 'O', 'o', 'O', 'o', 'U', 'u', 'U',
			'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', };

	public static String toUrlFriendly(String s) {
		int maxLength = Math.min(s.length(), 236);
		char[] buffer = new char[maxLength];
		int n = 0;
		for (int i = 0; i < maxLength; i++) {
			char ch = s.charAt(i);
			buffer[n] = removeAccent(ch);
			// skip not printable characters
			if (buffer[n] > 31) {
				n++;
			}
		}
		// skip trailing slashes
		while (n > 0 && buffer[n - 1] == '/') {
			n--;
		}
		return String.valueOf(buffer, 0, n);
	}

	public static char removeAccent(char ch) {
		int index = Arrays.binarySearch(SPECIAL_CHARACTERS, ch);
		if (index >= 0) {
			ch = REPLACEMENTS[index];
		}
		return ch;
	}

	public static String removeAccent(String s) {
		if (s != null) {
			StringBuilder sb = new StringBuilder(s);
			for (int i = 0; i < sb.length(); i++) {
				sb.setCharAt(i, removeAccent(sb.charAt(i)));
			}
			return sb.toString();
		} else {
			return null;
		}
	}


	public static String getXmlFromUrl(String url) throws IOException {
		StringBuffer xmlSource = new StringBuffer();
		// System.out.println("url:" + url);
		// url=java.net.URLEncoder.encode(url, "UTF-8");
		URL urlXmlContent = new URL(url);
		BufferedReader in = new BufferedReader(new InputStreamReader(
				urlXmlContent.openStream()));

		String inputLine;
		while ((inputLine = in.readLine()) != null) {
			xmlSource.append(inputLine);
		}
		in.close();
		String strXmlSource = xmlSource.toString().replace("<![CDATA[", "")
				.replace("]]>", "");
		// System.out.println("xmlSource:"+strXmlSource);
		return strXmlSource;
	}

	public static void downloadFromUrl(final String filename,
			final String urlString, final String path)
			throws MalformedURLException, IOException {
		BufferedInputStream in = null;
		FileOutputStream fout = null;
		try {
			File pathFile = new File(path);
			if (!pathFile.exists()) {
				pathFile.mkdirs();
			}
			try {
				in = new BufferedInputStream(new URL(urlString).openStream());
			} catch (MalformedURLException e) {
				logger.error(urlString, e);
				throw e;

			} catch (IOException e) {
				logger.error(urlString, e);
				throw e;

			}
			fout = new FileOutputStream(path + "/" + filename);

			IOUtils.copy(in, fout);
		} finally {
			if (in != null) {
				in.close();
			}
			if (fout != null) {
				fout.close();
			}
		}
	}

	public static void writeLog(Log logger, String headerLog,
			LinkedHashMap<String, String> mapMessage) {
		logger.debug("\n");
		logger.debug("============================= starting log " + headerLog
				+ "=============================");
		for (Map.Entry<String, String> entry : mapMessage.entrySet()) {
			logger.debug(entry.getKey() + " : ==>" + entry.getValue() + "<==");
		}
		logger.debug("============================= end log " + headerLog
				+ "==================================");
		logger.debug("\n");
	}

	public static String convertNumberToPretty(Integer num) {

		if (num > 1000000000) {
			return "1B+";
		} else if (num > 1000000) {
			return "1M+";
		} else if (num > 1000) {
			return "1K+";
		} else {
			return num + "";
		}
	}

	public static String decodeBase64(String s) {
		return org.apache.commons.codec.binary.StringUtils.newStringUtf8(Base64
				.decodeBase64(s));
	}

	public static String encodeBase64(String s) {
		return Base64
				.encodeBase64String(org.apache.commons.codec.binary.StringUtils
						.getBytesUtf8(s));
	}

	public static Long convertInputStringToLong(String input) {
		if (StringUtils.isEmpty(input)) {
			return null;

		} else {
			return Long.parseLong(input);
		}
	}

	public static Date getCurrentDate() {
		Calendar cl = Calendar.getInstance();
		Date currentDate = cl.getTime();
		String strCurrentDate = DDMMYYYY_DATE_FORMAT.format(currentDate);
		Date d = null;
		try {
			d = DDMMYYYY_DATE_FORMAT.parse(strCurrentDate);
		} catch (ParseException e) {
			logger.error(e.getMessage(), e);
		}
		return d;
	}

	public static String getCurrentDateStr() {
		Calendar cl = Calendar.getInstance();
		Date currentDate = cl.getTime();
		String strCurrentDate = YYYY_MM_DD_DATE_FORMAT.format(currentDate);
		return strCurrentDate;
	}

	public static List<String> convertStringToInSQLPrm(String input) {

		List<String> output = null;
		if (!StringUtils.isEmpty(input)) {
			input = input.trim();
			output = new ArrayList<String>();
			String[] stra = input.split(",");
			for (String str : stra) {

				str = str.trim();
				if (!StringUtils.isEmpty(str) && !"null".equals(str)) {
					output.add(str);
				}
			}

		}

		return output;
	}

	public static void convertStringToInSQLPrm(Map<String, Object> parameter) {
		String listStringId = (String) parameter.get("LIST_OBJECT_ID");
		List<String> listObjectId = convertStringToInSQLPrm(listStringId);
		parameter.put("LIST_OBJECT_ID", listObjectId);

	}

	public static Date convertDDMMYYToDate(String str_right_date)
			throws ParseException {
		if (StringUtils.isEmpty(str_right_date)) {
			return null;
		} else if (str_right_date.contains("/")) {
			return DD_MM_YYYY_DATE_FORMAT.parse(str_right_date);
		} else {
			return DDMMYYYY_DATE_FORMAT.parse(str_right_date);
		}

	}

	public static Date convertYYYYMMDDToDate(String str_right_date)
			throws ParseException {
		if (StringUtils.isEmpty(str_right_date)) {
			return null;
		} else {
			return YYYYMMDD_DATE_FORMAT.parse(str_right_date);
		}

	}

	/**
	 * 
	 * @param str_right_date
	 *            2016-09-26
	 * @return
	 * @throws ParseException
	 */
	public static Date convertYYYY_MM_DDToDate(String str_right_date)
			throws ParseException {
		if (StringUtils.isEmpty(str_right_date)) {
			return null;
		} else {
			return YYYY_MM_DD_DATE_FORMAT.parse(str_right_date);
		}

	}

	public static String getCurrentDateYYYYMMDD() {
		Calendar cl = Calendar.getInstance();
		Date currentDate = cl.getTime();
		String strCurrentDate = YYYYMMDD_DATE_FORMAT.format(currentDate);
		return strCurrentDate;
	}

	public static String getCurrentDateDDMMYYYY() {
		Calendar cl = Calendar.getInstance();
		Date currentDate = cl.getTime();
		String strCurrentDate = DDMMYYYY_DATE_FORMAT.format(currentDate);
		return strCurrentDate;
	}

	public static String getCurrentDateDDDotMMDotYYYY() {
		Calendar cl = Calendar.getInstance();
		Date currentDate = cl.getTime();
		String strCurrentDate = DDMMYYYY_DOT_DATE_FORMAT.format(currentDate);
		return strCurrentDate;
	}

	public static String convertDateToStrSlashDDMMYYY(Date myDate) {
		return DD_MM_YYYY_DATE_FORMAT.format(myDate);
	}

	public static String convertDateToStrYYYYMMDD(Date myDate) {
		return YYYYMMDD_DATE_FORMAT.format(myDate);
	}

	public static List<Map<String, Object>> convertListParseToMap(
			List<ParseObject> data) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		if (null == data) {
			return list;
		}
		for (ParseObject parseObject : data) {
			Map<String, Object> map = parseObject.getData();
			map.put("objectId", parseObject.getObjectId());
			list.add(map);
		}

		return list;
	}

}
