package menu;

public class MenuVO {
	private String title, sub_title;

	public MenuVO() {
		super();
	}

	public MenuVO(String title, String sub_title) {
		super();
		this.title = title;
		this.sub_title = sub_title;
	}

	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @return the sub_title
	 */
	public String getSub_title() {
		return sub_title;
	}

	/**
	 * @param sub_title the sub_title to set
	 */
	public void setSub_title(String sub_title) {
		this.sub_title = sub_title;
	}

	@Override
	public String toString() {
		return "menuVO [title=" + title + ", sub_title=" + sub_title + "]";
	}
	
	
}
