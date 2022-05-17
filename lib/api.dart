 // First API
//
//
// <?php
//
// // $con = mysqli_connect("hostname","username","password","databasename");
// $con = mysqli_connect("localhost","id18930413_devani","Prashant@1234","id18930413_priya");
//
// $temp= array();
//
// if($con)
// {
// $temp['connection']=1;
// }
// else
// {
// $temp['connection']=0;
//
// }
//
// $name= $_POST['name'];
// $email=$_POST['email'];
// $contact=$_POST['contact'];
// $password=$_POST['password'];
// $imagedata=$_POST['imagedata'];
//
// $realimg = base64_decode($imagedata);
//
// $imagname = "Userdp/".$name.rand(0,10000).rand(0,10000).".jpg";
//
// file_put_contents($imagname,$realimg);
//
//
// $qry="insert into Register (name,email,contact,password,imagename) values('$name','$email','$contact',
// '$password','$imagname')";
//
//
// $sql = mysqli_query($con,$qry);
//
// if($sql)
// {
//
// $temp['result']=1;
//
// }
// else
// {
//
// $temp['result']=0;
//
// }
//
//
// echo json_encode($temp);
//
//
// ?>
//
//
//
// //View Api
//
//
// <?php
//
// // $con = mysqli_connect("hostname","username","password","databasename");
// $con = mysqli_connect("localhost","id18930413_devani","Prashant@1234","id18930413_priya");
//
// $temp= array();
//
// if($con)
// {
// $temp['connection']=1;
// }
// else
// {
// $temp['connection']=0;
//
// }
//
// $name= $_POST['name'];
// $email=$_POST['email'];
// $contact=$_POST['contact'];
// $password=$_POST['password'];
// $imagedata=$_POST['imagedata'];
//
// $realimg = base64_decode($imagedata);
//
// $imagname = "Userdp/".$name.rand(0,10000).rand(0,10000).".jpg";
//
// file_put_contents($imagname,$realimg);
//
//
// $checkqry="select * from Register where email='$email' or contact='$contact'";
//
// $checksql = mysqli_query($con,$checkqry);
//
// $cnt = mysqli_num_rows($checksql);
//
// if($cnt==0)
// {
//
//
// $qry="insert into Register (name,email,contact,password,imagename) values('$name','$email','$contact',
// '$password','$imagname')";
//
//
//
// $sql = mysqli_query($con,$qry);
//
// if($sql)
// {
// $temp['result']=1;
// }
// else
// {
// $temp['result']=0;
// }
//
// }
// else
// {
// $temp['result']=2;
// }
//
// echo json_encode($temp);
//
// ?>
//
//
// login api
//
// <?php
//
// // $con = mysqli_connect("hostname","username","password","databasename");
// $con = mysqli_connect("localhost","id18930413_devani","Prashant@1234","id18930413_priya");
//
//
// if($con)
// {
// $temp['connection'] = 1;
// }
// else
// {
// $temp['connection'] = 0;
// }
//
//
//
// $username= $_REQUEST['email'];
// $pass=$_REQUEST['passw'];
//
//
//
// $qry= "select * from Register where email='$username' or contact='$username'and password='$pass'";
// $sql=mysqli_query($con,$qry);
// $cnt=mysqli_num_rows($sql);
//
// if($cnt==1)
// {
//
// $temp['result']=1;
// $arr=mysqli_fetch_assoc($sql);
// $temp['userdata']=$arr;
//
//
// }
// else
// {
//
// $temp['result']=0;
// }
//
//
// echo json_encode($temp);
//
//
//
//
// ?>