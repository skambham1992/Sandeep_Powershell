
<?php 
$employeeId=$firstName=$middleName=$mailId=$lastName=$deptName=$inputValue=$title=$manager="";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
	
	$employeeId=trim($_POST["eid"]);
	$firstName=trim($_POST["fname"]);
	$middleName=trim($_POST["mname"]);
	$lastName=trim($_POST["lname"]);
	$mailId=trim($_POST["email"]);
	$deptName=trim($_POST["deptname"]);
	$title=trim($_POST["title"]);
	$manager=trim($_POST["manager"]);
	$inputValue=trim($_POST["input"]);

}
if($inputValue==1){	

	if(empty($middleName)){
		$middleName="";
	}

	//generating .csv file from PHP 
	try{
	$list=array('employeeId,firstname,middlename,lastname,mailid,deptame,title,manager',
				$employeeId.",".$firstName .",".$middleName .",". $lastName .",".$mailId .",". $deptName .",". $title.",". $manager);
				
	$file = fopen("C:/Users/Administrator/Desktop/Test/ADEmployee.csv","w");

	foreach ($list as $line)
	  {
	  fputcsv($file,explode(',',$line));
	  }
	fclose($file);
	
	// executing the .ps1 file from PHP code
	
	$output=shell_exec('powershell C:\Users\Administrator\Desktop\Test\SAndeep_USER_creation.ps1');
	
	
	}catch(Exception $e) {
		echo 'Message: Employee creation Failed please Try Again ';
	}
	
?>
	
<html>
<head>
<title>Innominds</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

</head>

<body class="bodybackground">
<h4 align="center">User Creation Details</h4>
<div class="container" >
    <div class="row" style="
    padding-top: 50px;
">
       <?php echo "<pre>",$output ?>
    </div>
	<br/><br/>
	<div class="row">
		<div class="col-md-2 col-md-offset-5">
			<button  class="user-btn"><a  href="home.php">Home Page</a></button>
		</div>
	</div>
</div>

 
</body>

</html>
	
<?php
	
}else{
?>
<html>
<head>
<title>Innominds</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">

</head>

<body class="bodybackground">
<div class="container page-starts">
	<div class="row">
		<nav class="navbar navbar-default header-nav">
		  <div class="container-fluid">
			<div class="navbar-header">
			  <a class="navbar-brand" href="home.php"><img class="logo" src="images/logo.png"></a>
			</div>
			<ul class="nav navbar-nav logout-text">
			  <li class="active"><a href="#">Logout</a></li>
			</ul>
		  </div>
		</nav>
	</div>
	<div class="innominds-head">
		<h2>INNOMINDS USER ACCOUNT MANAGEMENT</h2>
	</div>
	<div class="col-md-2"></div>
	<div class="col-sm-6 col-md-8 ldapusers-main">
		<h3 class="login-title">Please Enter Details</h3><br>
		<div class="row">
			<div class="col-md-12">
				<form class="form-signin" action="createuserpage.php" method="post">
					<div class="col-md-6">
						<div class="form-group">
							<label for="name" class="cols-sm-2 control-label">First Name</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="fname" id="name" required placeholder="Enter First Name"/>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="name" class="cols-sm-2 control-label">Middle Name</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="mname" id="name"   placeholder="Enter Middle Name"/>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="name" class="cols-sm-2 control-label">Last Name</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="lname" id="name"  required placeholder="Enter Last Name"/>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="name" class="cols-sm-2 control-label">Title</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="title" id="name"  required placeholder="Enter Title"/>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label for="name" class="cols-sm-2 control-label">Employee ID</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="eid" id="name" required placeholder="Enter Employee ID"/>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="name" class="cols-sm-2 control-label">Email ID</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
									<input type="email" class="form-control" name="email" id="name" required placeholder="Enter Personal Email ID"/>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="name" class="cols-sm-2 control-label">Select Dept</label>
							<div class="cols-sm-10">
								<select class="form-control" id="name" name="deptname" required>
									<option selected>Select Department</option>
									<option>Finance</option>
									<option>HR</option>
									<option>IT</option>
									<option>Mobility</option>
									<option>Security</option>
									<option>DevOps</option>
									<option>QA</option>
									<option>UI</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="name" class="cols-sm-2 control-label">Manager</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="manager" id="name" required placeholder="Enter Manager Name"/>
								</div>
							</div>
						</div>
						<div class="submitbtn">
							<button class="btn btn-primary" type="submit" >Submit</button>
						</div>
					</div>
					<input type="hidden" value="1" name="input"/>
				</form>
			</div>		
		</div>
	</div>
	<div class="col-md-2"></div>
	<div class="row">
		<footer>
			<div class="col-md-6 copyright">
				<p>Copyright &copy; 2017 All Right Reserved</p>
			</div>
			<div class="col-md-6 designedby">
				<p>Designed by<a href="www.innominds.com" target="_blank"> Innominds</a></p>
			</div>
		</footer>
	</div>
</div>


</body>

</html>

<?php	
}

?>
