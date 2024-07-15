package day0425;


public class TestVO {
	private int deptno;
	private String dname, loc;
	
	public TestVO() {
		System.out.println("TestVO의 기본생성자");
	}

	public TestVO(int deptno, String dname, String loc) {
		this.deptno = deptno;
		this.dname = dname;
		this.loc = loc;
		System.out.println("TestVO의 매개변수 있는 생성자");
	}

	/**
	 * @return the deptno
	 */
	public int getDeptno() {
		System.out.println("부서번호 얻기");
		return deptno;
	}

	/**
	 * @param deptno the deptno to set
	 */
	public void setDeptno(int deptno) {
		System.out.println("부서번호 설정");
		this.deptno = deptno;
	}

	/**
	 * @return the dname
	 */
	public String getDname() {
		return dname;
	}

	/**
	 * @param dname the dname to set
	 */
	public void setDname(String dname) {
		this.dname = dname;
	}

	/**
	 * @return the loc
	 */
	public String getLoc() {
		return loc;
	}

	/**
	 * @param loc the loc to set
	 */
	public void setLoc(String loc) {
		this.loc = loc;
	}
	
	
	
	
}
