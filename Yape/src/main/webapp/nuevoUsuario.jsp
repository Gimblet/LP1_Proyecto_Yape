<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link href="Resources/bootstrap.min.css" rel="stylesheet">
	<style>
	</style>
	<title>Editar Yape</title>
</head>
<body>
	<form action="Servlet" method="post">
		<div class="form-group">
			<label>Tipo de Usuario</label>
			<select name="cboTipoUsuario" onchange="updateSaldo()">
				<option>Seleccionar Tipo de Usuario</option>
				<option>Admin</option>
				<option>Cliente</option>
			</select>
		</div>
		<div class="form-group">
			<label class="text-secondary">Nombres y Apellidos</label>
			<br>
			<input type="text" name="txtNombreApe" required>
		</div>
		<div class="form-group" id="saldoField">
		</div>
		
			<script>
    			function updateSaldo() {
        			var selectedOption = document.getElementsByName("cboTipoUsuario")[0].value;
        			var saldoField = document.getElementById("saldoField");
        	
        			if(selectedOption === "Cliente"){
            			saldoField.innerHTML = '<label class="text-secondary">Saldo</label><br><input required name="txtSaldo" type="text">';
        			} else {
            			saldoField.innerHTML = '';
        			}
    			}
			</script>
		
		<div class="form-group">
			<label class="text-secondary">Numero</label>
			<br>
			<input required name="txtNumero" type="text">
		</div>
		<div class="form-group">
			<label class="text-secondary">Clave</label>
			<br>
			<input required type="text" name="txtClave">
		</div>
		
		<input type="submit" name="type" value="Registrar Usuario" >
		<a href="Servlet?type=Volver" class="btn btn-primary">Regresar</a>
	</form>
</body>
</html>