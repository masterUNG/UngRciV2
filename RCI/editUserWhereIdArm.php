<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 'student1', 'Abc12345', "rci");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}


if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
			
		$id = $_GET['id'];		
		$CreateDate = $_GET['CreateDate'];
		$Address = $_GET['Address'];
		$Phone = $_GET['Phone'];
		$Gendel = $_GET['Gendel'];
		$Education = $_GET['Education'];
		
							
		$sql = "UPDATE `userung` SET `CreateDate` = '$CreateDate',`Address` = '$Address',`Phone` = '$Phone',
		`Gendel` = '$Gendel',`Education` = '$Education'  WHERE id = '$id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}

	mysqli_close($link);
?>