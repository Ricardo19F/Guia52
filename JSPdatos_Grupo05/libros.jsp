<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
 <html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Actualizar, Eliminar, Crear registros.</title>
 </head>
 <body>

<H1>MANTENIMIENTO DE LIBROS</H1>
<form action="matto.jsp" method="post" name="Actualizar">
 <table>
 <tr>
 <td>ISBN<input type="text" name="isbn" value="
 <%
	int dato1 = 3;
	int dato2 = 5;
	if(dato2 > dato1){
		request.getParameter("isbn")
	}
%>" size="40"/>
</td>
  </tr>
 <tr>
 <td>T�tulo<input type="text" name="titulo" value="" size="50"/></td>
 
 </tr>
 <tr><td> Action <input type="radio" name="Action" value="Actualizar"  /> Actualizar
 <input type="radio" name="Action" value="Eliminar" /> Eliminar
 <input type="radio" name="Action" value="Crear" checked /> Crear
  </td>
 <td><input type="SUBMIT" value="ACEPTAR" />
</td>
 </tr>
 </form>
 </tr>
 </table>
 </form>
<br><br>
<%!
public Connection getConnection(String path) throws SQLException {
String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
String filePath= path+"\\datos.mdb";
String userName="",password="";
String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

    Connection conn = null;
try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
 conn = DriverManager.getConnection(fullConnectionString,userName,password);

}
 catch (Exception e) {
System.out.println("Error: " + e);
 }
    return conn;
}
%>
<%
ServletContext context = request.getServletContext();
String path = context.getRealPath("/data");
Connection conexion = getConnection(path);
   if (!conexion.isClosed()){
out.write("OK");
 
      Statement st = conexion.createStatement();
      ResultSet rs = st.executeQuery("select * from libros" );

      // Ponemos los resultados en un table de html
      out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td>Titulo</td><td>Acci�n</td></tr>");
      int i=1;
      while (rs.next())
      {
         String isbn = rs.getString("isbn");
         out.println("<tr>");
         out.println("<td>"+ i +"</td>");
         out.println("<td>"+isbn+"</td>");
         out.println("<td>"+rs.getString("titulo")+"</td>");
         out.println("<td>"+"<a href='libros.jsp?isbn=" + isbn + "&Action=Actualizar'>Actualizar</a><br>");
         out.println("<a href='matto.jsp?isbn=" + isbn + "&Action=Eliminar'>Eliminar</a>"+"</td>");
         out.println("</tr>");
         i++;
      }
      out.println("</table>");

      // cierre de la conexion
      conexion.close();
}

%>
 </body>