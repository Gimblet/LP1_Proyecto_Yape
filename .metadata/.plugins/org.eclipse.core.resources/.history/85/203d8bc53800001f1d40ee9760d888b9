<%@page import="data.ClaseUtilitaria"%>
<%@page import="gestion.Metodos"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%  //Obtener Numero 
	Metodos obtenerNumero = new Metodos();
	int numero = 0;
	if(obtenerNumero.obtenerUsuario() != 0)
		numero = obtenerNumero.obtenerUsuario();
%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="ISO-8859-1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Nuevo Yapeo</title>
        <style>
            .container {
                display: flex;
                flex-direction: column;
            }

            .form-container {
                align-self: center;
                border: 4px solid blue;
                padding: 45px 60px 45px 60px;
            }

            input:hover {
                cursor: pointer;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <h3>Yapeando desde : <%= numero %></h3>
            <div class="form-container">
                <form action="Servlet" method="post">
                <%
                  String respuesta = "Esperando Verificacion";
                  if(request.getAttribute("ValidacionYape") != null){
                	  ClaseUtilitaria item = (ClaseUtilitaria) request.getAttribute("ValidacionYape");
                	  if(item.getRespuesta().equals("Datos Conformes")){
                		  respuesta = item.getRespuesta() + "<br>" + 
                          "Estas Yapeando a " + item.getNombreRecipiente() + "<br>" +
                          "El monto de : " + "S/" + item.getMontoRecipiente();
                	  }
                	  else{
                		  respuesta = item.getRespuesta();
                	  }
                  }    	
                %>
                    <h2>Yapear</h2>
                    <label>Numero</label><br><br>
                    <input required type="text" name="txtNumero"
                    <%
                		if(request.getAttribute("ValidacionYape") != null){
                  	  		ClaseUtilitaria item = (ClaseUtilitaria) request.getAttribute("ValidacionYape");
							if(item.getRespuesta().equals("Datos Conformes")){
                	%>
                     value=<%= item.getNumeroRecipiente() %> <%}} %>><br><br>
                    <label>Monto</label><br><br>
                    <input required type="text" name="txtMonto"
                    <%
                		if(request.getAttribute("ValidacionYape") != null){
                  	  		ClaseUtilitaria item = (ClaseUtilitaria) request.getAttribute("ValidacionYape");
							if(item.getRespuesta().equals("Datos Conformes")){
                	%>
                     value=<%= item.getMontoRecipiente() %><%}} %>><br><br>
                    <input type="submit" name="type" value="Verificar">
                    <h3><%= respuesta %></h3>
                    <input type="submit" name="type" value="Yapear">
                    <a href="Servlet?type=Volver Cliente" class="btn btn-primary">Regresar</a>
                </form>
            </div>
        </div>
    </body>

    </html>