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
 <td>ISBN<input type="text" name="isbn" value="<%
	if(request.getParameter("isbn")!=null){
		out.write(request.getParameter("isbn"));
	}
%>" size="40" required/>
</td>
  </tr>
 <tr>
 <td>T&iacute;tulo<input type="text" name="titulo" value="<%
	if(request.getParameter("titulo")!=null){
		out.write(request.getParameter("titulo"));
	}
%>" size="50"/></td>
 
 </tr>
 <tr>
 <td>Autor<input type="text" name="autor" value="<%
	if(request.getParameter("autor")!=null){
		out.write(request.getParameter("autor"));
	}
%>" size="50"/></td>
 
 </tr>
 <tr><td> Action <input type="radio" name="Action" value="Actualizar" <% 
 if (request.getParameter("Action")!=null){
 if(request.getParameter("Action").equals("Actualizar")){
   out.write("checked");
 }} %> /> Actualizar
 <input type="radio" name="Action" value="Eliminar" /> Eliminar
 <input type="radio" name="Action" value="Crear" <% 
 if (request.getParameter("Action")==null){
   out.write("checked");
 } %>/> Crear
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
String path = context.getRealPath("/JSPdatos_Grupo05/data");
Connection conexion = getConnection(path);
String ls_order = "";
String order = ls_order;
if (request.getParameter("order")!=null && (request.getParameter("order").equals("asc") || request.getParameter("order").equals("desc"))){
  ls_order = request.getParameter("order");
  order = ls_order;
  ls_order = " order by titulo " + ls_order;
}
out.write(ls_order);
   if (!conexion.isClosed()){
      out.write("OK");


      Statement st = conexion.createStatement();
      ResultSet rs = st.executeQuery("select * from libros" + ls_order);

      // Ponemos los resultados en un table de html
      if(order.equals("") || order.equals("desc")){
      out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td><a href='libros.jsp?order=asc'>Titulo</a></td><td>Autor</td><td>Acci&oacute;n</td></tr>");
      }
      else if (order.equals("asc")){
        out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td><a href='libros.jsp?order=desc'>Titulo</a></td><td>Autor</td><td>Acci&oacute;n</td></tr>");
      }
      int i=1;
      while (rs.next())
      {
         String isbn = rs.getString("isbn");
         String titulo = rs.getString("titulo");
         String autor = rs.getString("autor");
         out.println("<tr>");
         out.println("<td>"+ i +"</td>");
         out.println("<td>"+isbn+"</td>");
         out.println("<td>"+titulo+"</td>");
         out.println("<td>"+autor+"</td>");
         out.println("<td>"+"<a href='libros.jsp?isbn=" + isbn + "&titulo="+titulo+"&autor="+autor+"&Action=Actualizar'>Actualizar</a><br>");
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