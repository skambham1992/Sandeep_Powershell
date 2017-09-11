
<html>
<head>
<title>Innominds</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="styles.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">

</head>
<body>
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
	<h2 align="center">Innominds User Account Mananagement </h2>
	<div class="col-md-2"></div>
	<div class="col-sm-6 col-md-8 ldapusers-main">
		<h3 class="login-title">Reset Password</h3><br>
		<div class="row">
			<div class="col-md-12">
				<form class="form-signin" action="createuserpage.php" method="post">
					<div class="col-md-6">
						<div class="form-group">
							<label for="name" class="cols-sm-2 control-label">Employee ID</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="eid" id="name" required placeholder="Employee ID" readonly/>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="name" class="cols-sm-2 control-label">Create Password</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-keyboard-o fa" aria-hidden="true"></i></span>
									<input type="password" class="form-control" name="mname" id="name"   placeholder="Create Password"/>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label for="name" class="cols-sm-2 control-label">Email ID</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
									<input type="email" class="form-control" name="email" id="name" required placeholder="Email ID" readonly/>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="name" class="cols-sm-2 control-label">Confirm Password</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-keyboard-o fa" aria-hidden="true"></i></span>
									<input type="password" class="form-control" name="mname" id="name"   placeholder="Confirm Password"/>
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
