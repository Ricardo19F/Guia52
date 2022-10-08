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
 <td>ISBN<input type="text" name="isbn" id="isbn" value="<%
	if(request.getParameter("isbn")!=null){
		out.write(request.getParameter("isbn"));
	}
%>" size="40"/>
</td>
  </tr>
 <tr>
 <td>T&iacute;tulo<input type="text" name="titulo" id="titulo" value="<%
	if(request.getParameter("titulo")!=null){
		out.write(request.getParameter("titulo"));
	}
%>" size="50"/></td>
 </tr>
 <tr>
 <td>Autor<input type="text" name="autor" id="autor" value="<%
	if(request.getParameter("autor")!=null){
		out.write(request.getParameter("autor"));
	}
%>" size="50"/></td>
 
 </tr>
 <tr>
  <td> Acciones disponibles: <input type="radio" name="Action" value="Actualizar" <% 
 if (request.getParameter("Action")!=null){
 if(request.getParameter("Action").equals("Actualizar")){
   out.write("checked");
 }} %> /> Actualizar
 <input type="radio" name="Action" value="Eliminar" /> Eliminar
 <input type="radio" name="Action" value="Crear" <% 
 if (request.getParameter("Action")==null){
   out.write("checked");
 } %>/> Crear
 <input type="radio" name="Action" value="Buscar" <% 
 if (request.getParameter("Action")!=null){
 if(request.getParameter("Action").equals("Buscar")){
   out.write("checked");
 }} %> /> Buscar
  </td>
 <td><input id="aceptar" type="SUBMIT" value="ACEPTAR" disabled onclick=""/></td>
 </tr>
 <script>
  function validar(){
    var titulo = document.getElementById('titulo').value;
    var autor = document.getElementById('autor').value;

  if(titulo == '' || autor == ''){
     document.getElementById('aceptar').disabled = true;
  }
  if (titulo != '' && autor != ''){
     document.getElementById('aceptar').disabled = false;
  }
  }
  document.getElementById("autor").addEventListener("keyup",validar);
  document.getElementById("titulo").addEventListener("keyup",validar);
</script>
 </form>
 </tr>
 </table>
 </form>
<h3>Buscar libro por su ISBN</h3>
<form name="FormBuscar" action="libros.jsp" method="post">ISBN a buscar: <input type="text" name="isbn-buscar" placeholder="ingrese un isbn"><input type="submit" name="buscar" value="BUSCAR">
</form>
<h3>Buscar libro por su Titulo</h3>
<form name="FormBuscar" action="libros.jsp" method="post">Titulo a buscar: <input type="text" name="titulo-buscar" placeholder="ingrese un titulo"><input type="submit" name="buscar" value="BUSCAR">
</form>
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
   if (!conexion.isClosed()){
       Statement st = conexion.createStatement();
     
     // Consulta para encontrar el ISBN
     String texto = request.getParameter("isbn-buscar");
     String isbn_enc = "";
     String resul_busqueda = "";
     if(texto != null &&  texto != ""){
  ResultSet rs2 = st.executeQuery("select * from libros where isbn = '" + request.getParameter("isbn-buscar") + "'");
     if(rs2.next()){
       isbn_enc = rs2.getString("isbn");
       resul_busqueda += "ISBN Encontrado";
     }
     else
        resul_busqueda += "ISBN No encontrado";
        out.println(resul_busqueda);
        rs2.close();
     }

   //Consulta para encontrar el TITULO
      String texto2 = request.getParameter("titulo-buscar");
     String titulo_enc = "";
     String resul_busqueda2 = "";
     if(texto2 != null &&  texto2 != ""){
  ResultSet rs3 = st.executeQuery("select * from libros where titulo = '" + request.getParameter("titulo-buscar") + "'");
     if(rs3.next()){
       titulo_enc = rs3.getString("titulo");
       resul_busqueda2 += "Titulo Encontrado";
     }
     else
        resul_busqueda2 += "Titulo No encontrado";
        out.println(resul_busqueda2);
        rs3.close();
     }

      ResultSet rs = st.executeQuery("select * from libros");

      // Ponemos los resultados en un table de html
      out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td>Titulo</td><td>Autor</td><td>Acci&oacute;n</td></tr>");
      int i=1;
      while (rs.next())
      {
         String isbn = rs.getString("isbn");
         String titulo = rs.getString("titulo");
         String autor = rs.getString("autor");
         if(isbn_enc.equals(isbn) || titulo_enc.equals(titulo))
          out.println("<tr style=\"background-color: rgb(83, 251, 111);\">");
          else
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
</html>