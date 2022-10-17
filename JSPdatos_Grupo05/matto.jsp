<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>

<%
/* Paso 1) Obtener los datos del formulario */
String ls_isbn = request.getParameter("isbn").trim();
String ls_titulo = request.getParameter("titulo");
String ls_autor = request.getParameter("autor");
String ls_editorial = request.getParameter("editorial"); 
String ls_anio = request.getParameter("anio"); 
String ls_action = request.getParameter("Action");

/* Paso 2) Inicializar variables */
String ls_result = "Base de datos actualizada...";
String ls_query = "";
ServletContext context = request.getServletContext();
String path = context.getRealPath("/JSPdatos_Grupo05/data");
String filePath= path+"\\datos.mdb";
String ls_dburl = "jdbc:odbc:Driver={MicroSoft Access Driver (*.mdb)};DBQ="+filePath;
String ls_usuario = "";
String ls_password = "";
String ls_dbdriver = "sun.jdbc.odbc.JdbcOdbcDriver";

/* Paso 3) Crear query&nbsp; */
if (ls_action.equals("Crear")) {
	ls_query = " insert into libros (isbn, titulo, autor, anio, editorial)";
	ls_query += " values (";
	ls_query += "'" + ls_isbn + "',";
	ls_query += "'" + ls_titulo + "',";
	ls_query += "'" + ls_autor + "',";
	ls_query += "'" + ls_anio + "',"; 
	ls_query += "'" + ls_editorial + "')"; 
}

if (ls_action.equals("Eliminar")) {
	ls_query = " delete from libros where isbn = ";
	ls_query += "'" + ls_isbn + "'";
}

if (ls_action.equals("Actualizar")) {
	ls_query = " update libros";
	ls_query += " set titulo = " + "'" + ls_titulo + "',";
	ls_query += " autor = " + "'" + ls_autor + "',";
	ls_query += " editorial = " + "'" + ls_editorial + "',";
	ls_query += " anio = " + "'" + ls_anio + "'"; 
	ls_query += " where isbn = " + "'" + ls_isbn + "'";
}

//Metodo hecho por Cristian.
if (ls_action.equals("Buscar")) {
    ls_query = " select * from libros";
    ls_query += " where autor = " + "'" + ls_autor + "'" +" or " +"'"+" titulo ="+ls_titulo+ "'";
    
}
/* Paso4) Conexi�n a la base de datos */
Connection l_dbconn = null;

try {
	Class.forName(ls_dbdriver);
	/*&nbsp; getConnection(URL,User,Pw) */
	l_dbconn = DriverManager.getConnection(ls_dburl,ls_usuario,ls_password);

	/*Creacion de SQL Statement */
	Statement l_statement = l_dbconn.createStatement();
	/* Ejecucion de SQL Statement */
	l_statement.execute(ls_query);

} catch (ClassNotFoundException e) {
	ls_result = " Error creando el driver!";
	ls_result += " <br/>" + e.toString();
	} catch (SQLException e) {
	ls_result = " Error procesando el SQL!";
	ls_result += " <br/>" + e.toString();
} finally {
	/* Cerramos */
	try {
		if (l_dbconn != null) {
			l_dbconn.close();
		}
} catch (SQLException e) {
	ls_result = "Error al cerrar la conexión.";
	ls_result += " <br/>" + e.toString();
}
}
%>
<html>
<head>
	<link rel="stylesheet" href="./style-matto.css" type="text/css">
	<title>Updating a Database</title>
</head>
<body>
	<text>La siguiente instrucción fue ejecutada: </text>
	<br/>
	<span class="query"><%=ls_query%></span>
	<br/><br/>

	<text>El resultado fue: </text>
	<br/>
	<span class="result"><%=ls_result%></span>
	<br/><br/>

	<a href="libros.jsp">Regresar</a>
</body>
</html>