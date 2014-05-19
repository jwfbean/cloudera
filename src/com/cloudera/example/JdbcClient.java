package com.cloudera.example;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.sql.DriverManager;
 
public class JdbcClient {
  private static String driverName = "org.apache.hive.jdbc.HiveDriver";
  
  /**
   * Method from Apache example to create a table and load it. 
   * Kept the method in case you want to call it in your example.
   *
   * @param args
   * @throws SQLException
   */
  
  public static void createSampleTable(String url, String username, String password) throws SQLException {
    Connection con = DriverManager.getConnection(url, username, password);
    Statement stmt = con.createStatement();
    String tableName = "testHiveDriverTable";
    stmt.execute("drop table if exists " + tableName);
    stmt.execute("create table " + tableName + " (key int, value string) row format delimited fields terminated by '\t'");
    // show tables
    String sql = "show tables '" + tableName + "'";
    System.out.println("Running: " + sql);
    ResultSet res = stmt.executeQuery(sql);
    if (res.next()) {
      System.out.println(res.getString(1));
    }	  
    sql = "describe testHiveDriverTable";
    System.out.println("Running: " + sql);
    res = stmt.executeQuery(sql);
    while (res.next()) {
      System.out.println(res.getString(1) + "\t" + res.getString(2));
    }
 
    // load data into table
    // NOTE: filepath has to be in HDFS
    // NOTE: /tmp/a.txt is a ctrl-A separated file with two fields per line
    String filepath = "/user/ec2-user/a.txt";
    sql = "load data inpath '" + filepath + "' into table " + tableName;
    System.out.println("Running: " + sql);
    stmt.execute(sql);
  }
 
/**
 * Return 20 rows from sample_07. Count rows from sample_07.
 */

  public static void sampleQueries(String url, String user, String pw) throws SQLException {
	    Connection con = DriverManager.getConnection(url, user, pw);
	    Statement stmt = con.createStatement();
	    String tableName = "sample_07";
	    String sql = "select * from " + tableName + " limit 20";
	    System.out.println("Running: " + sql);
	    ResultSet res = stmt.executeQuery(sql);
	    while (res.next()) {
	      System.out.println(res.getString(1) + "\t" + res.getString(2) + "\t" + String.valueOf(res.getInt(3)) + "\t" + String.valueOf(res.getInt(4)));
	    }
	 
	    sql = "select count(1) from " + tableName;
	    System.out.println("Running: " + sql);
	    res = stmt.executeQuery(sql);
	    while (res.next()) {
	      System.out.println(res.getString(1));
	    }
	  }
 
/**
 * This issues an "invalidate metadata" command to Impala.
 */
 
  public static void invalidateMetadata(String impala_url) throws SQLException {
	    Connection con = DriverManager.getConnection(impala_url);
	    Statement stmt = con.createStatement();
	    stmt.execute("invalidate metadata");
  }
  
  public static void main(String[] args) throws SQLException {
	  if ((args.length) != 3) {
		  System.out.println("Usage: JdbcClient jdbc-url username password");
		  System.out.println("Impala uses any instance of impalad, port 21050");
		  System.out.println("Hive uses instance of HiveServer2, port 10000");
                  System.out.println();
                  System.out.println("Hive example:");
                  System.out.println("JdbcClient hiveserver-2-url:10000 ec2-user ec2");
                  System.out.println();
                  System.out.println("Impala example:");
                  System.out.println("JdbcClient impala-url:21050 ec2-user ec2");
 
		  System.exit(1);
	  }
      try {
      Class.forName(driverName);
    } catch (ClassNotFoundException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
      System.exit(1);
    }
    String url = args[0];
    String username = args[1];
    String password = args[2];
//    createSampleTable(url, username, password);
    sampleQueries(url, username, password);
}
}
