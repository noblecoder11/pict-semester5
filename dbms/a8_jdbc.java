import java.sql.*;
import java.util.Scanner;
import java.io.*;

public class Hello {
	public static void main(String arg[])
	{
		Connection connection = null;
		try {
			// below two lines are used for connectivity.
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(
				"jdbc:mysql://10.10.12.108/t31132db",
				"t31132", "t31132");


			Statement statement;
			statement = connection.createStatement();
			ResultSet resultSet;
			
			Scanner sc = new Scanner(System.in);
//			System.out.println("Enter the name of table you want to create");
//			String tableName = sc.nextLine();
//			String createTable1 = "create table "+tableName+" (rollno int, name varchar(20));";
//			statement.executeUpdate(createTable1);
			
			
//			resultSet = statement.executeQuery(createTable1);
//			int code;
//			String title;
//			while (resultSet.next()) {
//				code = resultSet.getInt("Bookid");
//				title = resultSet.getString("Name").trim();
//				System.out.println("Code : " + code
//								+ " Title : " + title);
//			}
			
			// create table -> tableName, noOfFields, fields and their datatypes
			// read -> tableName
			// update -> tablename, show table ask for id, values to change
			// delete -> tableName, show table and ask for id, delete id;
			while(true) {
				System.out.println("Main Menu\n1. Create table\n2. Read table\n3. Update\n4. Delete\n5. Exit\n");
				System.out.println("Enter the choice: ");
				int choice = sc.nextInt();
				
				if(choice==1) { // create table
					System.out.println("Enter the name of table to create: ");
					String tableName = sc.next();
					System.out.println("Enter number of fields in table");
					int nFields = sc.nextInt();
					String createTableQuery = "CREATE TABLE "+ tableName +" (";
					String cols[] = new String[nFields];
					
					for(int i=0; i<nFields; i++) {
						System.out.println("Enter the name of column " + i + ": ");
						cols[i] = sc.next();
						System.out.println("Enter the datatype for column " + cols[i] + ": ");
						String dataType = sc.next();
						if(i!=nFields-1) createTableQuery+= cols[i]+" "+dataType+", ";
						else createTableQuery+= cols[i]+" "+dataType;
					}
					
					createTableQuery+=");";
					System.out.println(createTableQuery);
					statement.executeUpdate(createTableQuery);
				} else if(choice==2) { // read
					System.out.println("Enter the name of table to read: ");
					String tableName = sc.next();
					String readTableQuery = "SELECT * FROM " + tableName + ";";
					resultSet = statement.executeQuery(readTableQuery);
					ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
					while(resultSet.next()) {
						for(int i=0; i<resultSetMetaData.getColumnCount(); i++) {
							System.out.print(resultSetMetaData.getColumnName(i)+"\t"); 
						}
						for(int i=0; i<resultSetMetaData.getColumnCount(); i++) {
							System.out.println(resultSet.getString(i)+"\t");
							
						}
					}
					
					
				} else if(choice==3) {
//					ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
					
				} else if(choice==4) {
					
				} else if(choice==5) {
					System.out.println("Exiting...");
					break;
				}
			}
			
			
//			resultSet.close();
			statement.close();
			connection.close();
		}
		catch (Exception exception) {
			System.out.println(exception);
		}
	} // function ends
} // class ends
