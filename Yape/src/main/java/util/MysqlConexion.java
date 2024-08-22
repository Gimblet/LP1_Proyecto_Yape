package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MysqlConexion {
	public static Connection getConexion() {
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
			String url = "jdbc:mysql://Mysql-DB:3306/dbYape";
			String usr = "root";
			String psw = "Nenti182912";
			con = DriverManager.getConnection(url, usr, psw);
		} catch(ClassNotFoundException e) {
			System.out.println("Error con el Driver de Base de Datos" + e.getMessage());
		} catch(SQLException e){
			System.out.println("Error con la base de datos" + e.getMessage());
		} catch(Exception e) {
			System.out.println("Error General" + e.getMessage());
		}
		return con;
	}
	
	public static void closeConnection(Connection con) {
		try {
			con.close();
		} catch(SQLException e) {
			System.out.println("Problemas al cerrar la conexion");
			e.printStackTrace();
		}
	}
}
