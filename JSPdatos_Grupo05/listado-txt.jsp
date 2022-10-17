<%@page import="java.util.*, java.sql.*,net.ucanaccess.jdbc.*"%><%

    response.setStatus(200);
    response.setHeader("Content-Type","application/xml");
    String nombreArchivo = "libros.txt";
    response.setHeader("Content-Disposition", "attachment;filename=" + nombreArchivo);
%><%!
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
%><%
ServletContext context = request.getServletContext();
String path = context.getRealPath("/JSPdatos_Grupo05/data");
Connection conexion = getConnection(path);

    if (!conexion.isClosed()){
        String isbn ="", titulo ="", autor= "",editorial= "",anio= "";
        Statement st = conexion.createStatement();
        ResultSet rs = st.executeQuery("SELECT editoriales.editorial as edit, libros.* FROM libros INNER JOIN editoriales ON libros.editorial = editoriales.id");

        int i=1;
        while (rs.next())
        { 
            isbn=rs.getString("isbn");
            titulo=rs.getString("titulo");
            autor=rs.getString("autor");
            editorial=rs.getString("edit");
            anio=rs.getString("anio");

            out.println("Numero: "+i);
            out.println("ISBN: "+isbn);
            out.println("Titulo: "+titulo);
            out.println("Autor: "+autor);
            out.println("Editorial: "+editorial);
            out.println("Año de Publicacion: : "+anio+"\n\n");
            i++;
        }
        // cierre de la conexion
        conexion.close();
    }
%>
