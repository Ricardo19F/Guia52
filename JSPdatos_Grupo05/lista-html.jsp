<%@page import="java.sql.*, java.io.*" pageEncoding="iso-8859-1" contentType="text/html" %>
<%
response.setStatus(200);
response.setHeader("content-type","application/html");
response.setHeader("content-disposition","attachment;filename=libros.html");
%>
<%!
public Connection getConnection(String path) throws SQLException{
    String ls_dbdriver = "sun.jdbc.odbc.JdbcOdbcDriver";
    String filePath= path + "\\datos.mdb";
    String ls_usuario = "",ls_password = "";
    String ls_dburl = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

    Connection l_dbconn = null;
    try{
        Class.forName(ls_dbdriver);
        l_dbconn = DriverManager.getConnection(ls_dburl, ls_usuario, ls_password);
    }
    catch (Exception e){
        System.out.println("Error: " + e);
    }
    return l_dbconn;
}
%>
<%
ServletContext context = request.getServletContext();
String path = context.getRealPath("/JSPdatos_Grupo05/data");
Connection l_dbconn = getConnection(path);
String ls_query = "select * from libros";

if (!l_dbconn.isClosed()){
    Statement l_stat = l_dbconn.createStatement();
    ResultSet l_rs = l_stat.executeQuery(ls_query);
    String impresion = "";
    String html = "<!DOCTYPE html><html lang='en'><head><meta charset='UTF-8'>    <meta http-equiv='X-UA-Compatible' content='IE=edge'>    <meta name='viewport' content='width=device-width, initial-scale=1.0'>    <title>Document</title></head><body>";
    while(l_rs.next()){
        impresion += l_rs.getString("isbn") ;
        impresion += l_rs.getString("titulo") ;
        impresion += l_rs.getString("autor") ;
    }
    out.write(html + impresion + "</body></html>");
    l_dbconn.close();
}

%>