<%@page import="java.sql.*, java.io.*" pageEncoding="iso-8859-1" contentType="application/json" %>
<%
response.setStatus(200);
response.setHeader("content-type","application/json");
response.setHeader("content-disposition","attachment;filename=libros.json");
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
String ls_query = "SELECT editoriales.editorial as edit, libros.* FROM libros INNER JOIN editoriales ON libros.editorial = editoriales.id";

if (!l_dbconn.isClosed()){
    Statement l_stat = l_dbconn.createStatement();
    ResultSet l_rs = l_stat.executeQuery(ls_query);
    String impresion = "";
        
    while(l_rs.next()){
        impresion += "{ \"isbn\":\"";
        impresion += l_rs.getString("isbn") ;
        impresion += "\", \"autor\":\"";
        impresion += l_rs.getString("autor");
        impresion += "\", \"titulo\":\"";
        impresion += l_rs.getString("titulo") ;
        impresion += "\", \"año_publicacion\":\"";
        impresion += l_rs.getString("anio") ;
        impresion += "\", \"editorial\":\"";
        impresion += l_rs.getString("edit") ;
        impresion += "\"},";
    }
    out.write("["+ impresion.substring(0,impresion.length()-1)+ "]");
    l_dbconn.close();
}

%>