<%@page import="java.sql.*, java.io.*" pageEncoding="iso-8859-1" %>
<%
response.setStatus(200);
response.setHeader("content-type","application/html");
response.setHeader("content-disposition:","filename=libros.html");
%>
<%
try{
    ServletContext context = request.getServletContext();
    String path = context.getRealPath("/JSPdatos_Grupo05/data");
    String filePath= path + "\\datos.mdb";
    String ls_dburl = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;
    String ls_usuario = "",ls_password = "";
    String ls_dbdriver = "sun.jdbc.odbc.JdbcOdbcDriver";
    String ls_query = "select * from libros";
    Connection l_dbconn = null;
    Class.forName(ls_dbdriver);
    l_dbconn = DriverManager.getConnection(ls_dburl, ls_usuario, ls_password);
    Statement l_stat = l_dbconn.createStatement();
    ResultSet l_rs = l_stat.executeQuery(ls_query);
    String impresion = "";
    while(l_rs.next()){
        impresion += l_rs.getString("isbn") ;
        impresion += l_rs.getString("titulo") ;
        impresion += l_rs.getString("autor") ;
        impresion += l_rs.getString("nombre");
        out.write(impresion); 
    }
    l_dbconn.close();
}catch(Exception e){
    e.printStackTrace();
}
%>