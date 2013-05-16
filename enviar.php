<?php

    $to = "amytibia@hotmail.com";
    $assunto = "bluewifi On-Line » PRE-CADASTRO";

	$nome = $_POST["txnome"];
	$endereco = $_POST["txendereco"];
	$complemento = $_POST["txcomplemento"];
	$bairro = $_POST["txbairro"];
	$cep = $_POST["txcep"];
	$ddd = $_POST["txddd"];
	$telefone = $_POST["txtelefone"];
	$email = $_POST["txemail"];
	$plano = $_POST["txplano"];
	$situacao = $_POST["txsituacao"];
	$dia = $_POST["txdia"];
	$hora = $_POST["txhora"];
	
	

$texto = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<title>Untitled Document</title>
</head>

<body>
<p>TMC Telecomm » Fomulario de Contato</p>
<table width='588' border='0'>
  
  <tr>
    <td width='88'><div align='right'>Nome:</div></td>
    <td width='490'>$nome</td>
  </tr>
  <tr>
    <td><div align='right'>Endereco:</div></td>
    <td>$endereco</td>
  </tr>
  <tr>
    <td><div align='right'>Complemento:</div></td>
    <td>$complemento</td>
  </tr>
  <tr>
    <td><div align='right'>Bairro:</div></td>
    <td>$bairro</td>
  </tr>
  <tr>
    <td><div align='right'>CEP:</div></td>
    <td>$cep</td>
  </tr>
  <tr>
    <td><div align='right'>Telefone:</div></td>
    <td>($ddd) - $telefone</td>
  </tr>
  <tr>
    <td><div align='right'>E-mail:</div></td>
    <td>$email</td>
  </tr>
  <tr>
    <td><div align='right'>Plano</div></td>
    <td>$plano</td>
  </tr>
  <tr>
    <td><div align='right'>Situacao:</div></td>
    <td>$situacao</td>
  </tr>
  <tr>
    <td><div align='right'>Dia:</div></td>
    <td>$dia</td>
  </tr>
  <tr>
    <td><div align='right'>Hora:</div></td>
    <td>$hora</td>
  </tr>
</table>
</body>
</html>
";

$headers = "Content-type: text/html; charset=iso-8859-1\r\n";

if (mail($to, $assunto, $texto, $headers)) {
		echo "Pre-Cadastro realizado com sucesso!";
} else {
		echo "Ocorreu um erro durante o envio";
}?>