package day0520;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.jsp.JspWriter;

import org.jdom2.Attribute;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;

/**
 * @param type 0-콘솔출력 1-File출력, 2-web browser출력
 * @param out - type이 3일때 JSPWriter를 입력해 주어야 한다.
 * @throws SQLException
 */

public class CreateXML {
	public void createDept(int type, JspWriter out) throws SQLException, IOException{
		//1.XML 문서객체 생성
		Document doc= new Document();
		//2.최상위 부모노드 생성
		Element rootNode= new Element("depts"); //<depts>
		//3.자식노드들 생성(부서번호, 부서명, 위치를 가지는 노드 생성)
		Element deptNode= null;
		Element deptnoNode= null;
		Element dnameNode= null;
		Element locNode= null;
		
		DeptDAO dDAO= DeptDAO.getInstance();
		Attribute attrDeptno=null;
		
		List<DeptDomain> list= dDAO.selectAllDept();
		
		for(DeptDomain dd: list) {
			deptNode= new Element("dept");	//<dept/>
			deptnoNode=new Element("deptno");	//<deptno/>
			dnameNode= new Element("dname");	//<dname/>
			locNode= new Element("loc");	//<loc/>
			
			attrDeptno=new Attribute("deptno", String.valueOf(dd.getDeptno()));
			deptNode.setAttribute(attrDeptno);
			
			deptnoNode.setText(String.valueOf(dd.getDeptno()));	//<deptno>10</deptno>
			dnameNode.setText(dd.getDname());	//<dname>ACC</dname>
			locNode.setText(dd.getLoc());	//<dname>NEW</dname>
		//4.자식노드를 배치
			deptNode.addContent(deptnoNode);	//<dept><deptno>10</deptno></dept>
			deptNode.addContent(dnameNode);	//<dept><deptno>10</deptno><dname>A</dname></dept>
			deptNode.addContent(locNode);	//<dept><deptno>10</deptno><dname>A</dname><loc> </loc>
		//5.자식노드를 가진 노드를 최상위 부모노드에 배치
			rootNode.addContent(deptNode);//<depts><dept>...</depts>
		}//end for
		//6.최상위 부모노드를 xml문서객체에 배치
		doc.addContent(rootNode);
		//7.XML 출력객체 생성
		XMLOutputter xOut= new XMLOutputter(Format.getPrettyFormat());
		//8.출력
		switch(type) {
		case 1:
			FileOutputStream fos=null;
			try {
			 fos= new FileOutputStream("C:/dev/workspace/jsp_prj/src/main/webapp/day0520/dept.xml");
			 xOut.output(doc,  fos);
			}finally {
				if(fos != null) {fos.close();}
			}//end finally
			break;
			
		case 2:
			if(out != null) {
			xOut.output(doc, out);
			}//end if
			break;
			default:
				xOut.output(doc, System.out);
			}//end switch
	}//createDept
}//class
