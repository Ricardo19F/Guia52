<%@page import="java.util.*, java.sql.*,net.ucanaccess.jdbc.*" contentType="text/csv"%><%

    response.setStatus(200);
    response.setHeader("Content-Type","application/vnd.ms-excel");
    String nombreArchivo = "libros.csv";
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
        ResultSet rs = st.executeQuery("select * from libros");
        out.println("Num.;ISBN;Titulo;Autor;Editorial;Año Publicacion");

        int i=1;
        while (rs.next())
        { 
            isbn=rs.getString("isbn");
            titulo=rs.getString("titulo");
            autor=rs.getString("autor");
            editorial=rs.getString("editorial");
            anio=rs.getString("año");
            out.println(i+";"+isbn+";"+titulo+";"+autor+";"+editorial+";"+anio);
            i++;
        }
        // cierre de la conexion
        conexion.close();
    }
%>
