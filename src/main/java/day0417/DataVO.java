package day0417;

public class DataVO {
private String name,url,img;

	public DataVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}



	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
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



	public DataVO(String name, String url) {
		super();
		this.name = name;
		this.url = url;
	}



	public DataVO(String name, String url, String img) {
		super();
		this.name = name;
		this.url = url;
		this.img = img;
	}



	/**
	 * @return the img
	 */
	public String getImg() {
		return img;
	}



	/**
	 * @param img the img to set
	 */
	public void setImg(String img) {
		this.img = img;
	}



	@Override
	public String toString() {
		return "DataVO [getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}

	
	
	

}
