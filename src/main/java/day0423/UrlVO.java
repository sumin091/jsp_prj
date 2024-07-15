package day0423;

//import lombok.AllArgsConstructor;
//import lombok.Getter;
//import lombok.Setter;
//import lombok.ToString;
//
//@Getter
//@Setter
//@AllArgsConstructor
//@ToString

public class UrlVO {
	
	private String code,url,info ;

	/**
	 * @return the code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @param code the code to set
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * @return the url
	 */
	public String getUrl() {
		return url;
	}

	/**
	 * @param url the url to set
	 */
	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * @return the info
	 */
	public String getInfo() {
		return info;
	}

	/**
	 * @param info the info to set
	 */
	public void setInfo(String info) {
		this.info = info;
	}

	public UrlVO(String code, String url, String info) {
		super();
		this.code = code;
		this.url = url;
		this.info = info;
	}

	public UrlVO() {
		super();
	}

	@Override
	public String toString() {
		return "UrlVO [code=" + code + ", url=" + url + ", info=" + info + "]";
	}
	
	
}
