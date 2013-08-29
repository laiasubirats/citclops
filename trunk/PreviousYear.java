package urination;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.Vector;


public class PreviousYear {
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
		    String query="select distinct lake from citclops.transparency where id>=7874;";
			System.out.println(query);
		    ResultSet resultado=s.executeQuery(query);
		    while(resultado.next()){
		    	convertUser(resultado.getString(1));
		    	con.close();
		    } 
		}catch(Exception e){
			System.out.println("Error truncate "+e);
		}
	}
	private static void convertUser(String string) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		Vector<String> paciente2symbol=new Vector<String>();
		Object[][] paciente = null;
		try {	 
			Properties props = new Properties();
		    props.setProperty("user", ACCOUNT);
		    props.setProperty("password", PASSWORD);
			Class.forName(DRIVER).newInstance();
		    Connection con = DriverManager.getConnection(HOST + DB, props);
		    Statement s = con.createStatement();	
			String query="select m from citclops.transparency where lake like \""+string+"\" order by year;";
			System.out.println(query);
		    ResultSet resultado=s.executeQuery(query);
		    paciente=ResultSetToArray(resultado);
		    con.close();
		    }catch(Exception e){
			System.out.println("Error truncate "+e);
		    }
		System.out.println("paciente.length: "+paciente.length+" paciente[0].length: "+paciente[0].length);

		if (paciente.length>1){
			for (int i=1;i<paciente.length;i++){
				for (int j=0;j<paciente[0].length;j++){
					if (paciente[i-1][j]!=null)paciente2symbol.add(j,paciente[i-1][j]+"");
					else paciente2symbol.add("-1");
				}
				paciente2symbol.add(paciente[0].length,""+paciente[i][0]);
				migrate2DB(paciente2symbol,string);
			paciente2symbol.removeAllElements();
			}
		}
		
	}
	
	private static void migrate2DB(Vector<String> paciente2symbol, String user) {
		System.out.println("Longitud: "+paciente2symbol.size());
		try {	 
	         Properties props = new Properties();
	         props.setProperty("user", ACCOUNT);
	         props.setProperty("password", PASSWORD);
			 Class.forName(DRIVER).newInstance();
	         Connection con = DriverManager.getConnection(HOST + DB, props);
	         Statement s = con.createStatement();	
	         String query="INSERT INTO citclops.previous(lake,m,solution) VALUES(\""+user+"\"";
	         for (int k=0;k<paciente2symbol.size();k++){
	        	 query+=","+paciente2symbol.get(k)+"";
	         }    	 
	         query+=");";
	         System.out.println("Query" +query);
	         int resultado = s.executeUpdate(query);
	         con.close();
	         
		}catch(Exception e){
			System.out.println("Excepción inserción taubla D: "+e);
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
