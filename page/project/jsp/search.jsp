<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@ page import="net.sf.json.JSONArray"%>
<%@ page import="java.sql.*" %>
<%
  //连接数据库
  String url="jdbc:mysql://127.0.0.1/manager?user=root&password=root";
  Class.forName("com.mysql.jdbc.Driver").newInstance();
  Connection connection=DriverManager.getConnection(url);
  Statement statement = connection.createStatement();

  //获取页面参数
  String name = request.getParameter("name");

  JSONObject resultObj = new JSONObject();
  JSONObject row = new JSONObject();
  JSONArray data = new JSONArray();

  String sql="select * from uf_task where belong LIKE '%"+name+"%'";
  ResultSet rs = statement.executeQuery(sql);
  while(rs.next()) {
    row.put("task",rs.getString("task"));
    row.put("fzr",rs.getString("fzr"));
    row.put("state",rs.getString("state"));
    row.put("planefinish",rs.getString("planefinish"));
    row.put("createtime",rs.getString("createtime"));
    row.put("dsc",rs.getString("dsc"));
    data.add(row);
  }

  resultObj.put("sql",sql);
  resultObj.put("code",0);
  resultObj.put("data",data);
  out.print(resultObj);

  rs.close();
  statement.close();
  connection.close();
%>
