package urination;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.Vector;


public class Yearly {
	static Vector<String> attributes= new Vector<String>();
	
	static Vector<String> usuarios=new Vector<String>();
	protected static final String DB = "citclops",
		    HOST = "jdbc:mysql://localhost:3306/",
		    ACCOUNT = "root", 
		    PASSWORD = "root",
		    DRIVER = "com.mysql.jdbc.Driver",
		    FILENAME = "records.txt";
	public static void main(String args[]){
		
			attributes.add("m");
			try {	 
			Properties props = new Properties();
		    props.setProperty("user", ACCOUNT);
		    props.setProperty("password", PASSWORD);
			Class.forName(DRIVER).newInstance();
		    Connection con = DriverManager.getConnection(HOST + DB, props);
		    Statement s = con.createStatement();
		    //String query="";
		    String query="select distinct lake from citclops.transparency;";
		   // System.out.println(query);
		    ResultSet resultado=s.executeQuery(query);
		    while(resultado.next()){
		    	convertUser(resultado.getString(1));
		    } 
		}catch(Exception e){
			System.out.println("Error truncate "+e);
		}
	}
	private static void convertUser(String string) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		Vector<String> lake2symbol=new Vector<String>();
		Object[][] lake = null;
		try {	 
			Properties props = new Properties();
		    props.setProperty("user", ACCOUNT);
		    props.setProperty("password", PASSWORD);
			Class.forName(DRIVER).newInstance();
		    Connection con = DriverManager.getConnection(HOST + DB, props);
		    Statement s = con.createStatement();	
		    String query="select m from citclops.transparency where lake like \""+string+"\" order by year;";		    ResultSet resultado=s.executeQuery(query);
		    resultado=s.executeQuery(query);
		    System.out.println(query);
		    lake=ResultSetToArray(resultado);
		    }catch(Exception e){
			System.out.println("Error truncate "+e);
		    }
		System.out.println("Length: "+lake.length);
		int continuar=0;
		String variable = "",aString=" ",anterior="";
		if (lake.length>1){
				for (int j=0;j<1;j++){
					variable="";aString="";
					int variableAnterior=-1;
					int primer=-1;
					for (int i=1;i<=lake.length-2;i++){
						if (primer==-1&&lake[i-1][j]!=null)primer=Integer.parseInt(""+lake[i-1][j]);
						if (lake[i-1][j]!=null && lake[i][j]!=null){
							
							variable=Convert2symbol(Integer.parseInt(""+lake[i-1][j]),(Integer.parseInt(""+lake[i][j])));
						}else if (lake[i][j]==null&&lake[i-1][j]!=null){
							System.out.println("VAriableanterior i,j"+lake[i-1][j]);
							variableAnterior=Integer.parseInt(""+lake[i-1][j]);
						}else if (lake[i-1][j]==null && variableAnterior!=-1 &&lake[i][j]!=null){
							System.out.println("VAriableanterior"+variableAnterior);
							variable=Convert2symbol(variableAnterior,(Integer.parseInt(""+lake[i][j])));
							variableAnterior=-1;
						}
						aString+=variable;
					}
				
					if (primer==-1)lake2symbol.add(j,aString);
					else lake2symbol.add(j,""+primer+aString);
				}
				int i=lake.length-1;
				
				
				lake2symbol.add(lake[0].length,""+lake[i][0]);
				migrate2DB(lake2symbol,string);
			}	
	}
	
	private static String Convert2symbol(int a, int b){
		String smallLetter="";
		String bigLetter="";
		Double aa=(double)a;Double bb=(double)b;
		if (Math.abs(aa-bb)==1.0)smallLetter="+";
		else if (Math.abs(aa-bb)==2.0)smallLetter="++";
		else if (Math.abs(aa-bb)==3.0)smallLetter="+++";
		else if (Math.abs(aa-bb)==4.0)smallLetter="++++";
		
		if (aa-bb>0)bigLetter="D";
		else if (aa-bb<0)bigLetter="I";
		else if (aa-bb==0)bigLetter="S";
		else bigLetter="M";
		return bigLetter.concat(smallLetter);
	}
	private static void migrate2DB(Vector<String> lake2symbol, String user) {
		try {	 
	         Properties props = new Properties();
	         props.setProperty("user", ACCOUNT);
	         props.setProperty("password", PASSWORD);
			 Class.forName(DRIVER).newInstance();
	         Connection con = DriverManager.getConnection(HOST + DB, props);
	         Statement s = con.createStatement();	
	         String query="INSERT INTO citclops.yearly(lake,m,solution) VALUES(\""+user+"\"";
	         query+=",\""+lake2symbol.get(0)+"\"";
	         query+=",\""+lake2symbol.get(1)+"\"";
	         query+=");";
	         System.out.println("Query" +query);
	         int resultado = s.executeUpdate(query);
	         con.close();
	         
		}catch(Exception e){
			System.out.println("Excepci�n inserci�n taubla D: "+e);
		}
	}
	private static Object[][] ResultSetToArray(ResultSet rs){
	        Object obj[][]=null;
	        try {
	        rs.last();
	        ResultSetMetaData rsmd = rs.getMetaData();
	        int numCols = rsmd.getColumnCount();
	        int numFils =rs.getRow();
	        obj=new Object[numFils][numCols];
	        int j = 0;
	        rs.beforeFirst();
	        while (rs.next()) {
	            for (int i=0;i<numCols;i++) {
	            	if (rs.getObject(i+1)!=null)obj[j][i]=rs.getObject(i+1);
	            }
	            j++;
	        }
	        }
	        catch(Exception e) { }
	        return obj;
	 }
}
