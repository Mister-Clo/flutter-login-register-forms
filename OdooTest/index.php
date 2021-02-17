<?php require_once("./ripcord-master/ripcord.php"); ?>


<!DOCTYPE html>
<html>
<head>
	<link rel="shortcut icon" href="bars.png" type="image/x-icon">
	<style type="text/css">
		#sales {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 90%;
  table-layout: fixed;
}


#sales td, #sales th {
  border: 1px solid #ddd;
  padding: 8px;
}

#sales tr:nth-child(even){background-color: #f2f2f2;}

#sales tr:hover {background-color: #ddd;}

#sales th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #4CAF50;
  color: white;
}
	</style>
	<title>Odoo sales</title>
</head>
<body> 

 <?php 
$url = "http://localhost:8069";
$db = "testodoo";
$username = "tchoupouclotaire@gmail.com";
$password = "odoo";

$common = ripcord::client("$url/xmlrpc/2/common");
$common->version();

$uid = $common->authenticate($db, $username, $password, array());
echo "<br/>";
//echo $uid;


$models = ripcord::client("$url/xmlrpc/2/object");
/**
* res.partner
*
$models->execute_kw($db, $uid, $password,
    'res.partner', 'check_access_rights',
    array('read'), array('raise_exception' => false));


$view= $models->execute_kw($db, $uid, $password,
    'res.partner', 'search', array(
        array(array('is_company', '=', true),
              array('customer', '=', true))));
*/

//Sales
$models->execute_kw($db, $uid, $password,
    'sale.order', 'check_access_rights',
    array('read'), array('raise_exception' => false));

/***
**Customer ids
**/
/*
$customer_ids = $models->execute_kw(
    $db, // DB name
    $uid, // User id, user login name won't work here
    $password, // User password
    'res.partner', // Model name
    'search', // Function name
    array( // Search domain
        array( // Search domain conditions
            array('is_company', '=', true), // Query condition
            array('customer', '=', true)) // Query condition
        )
 );
$customers = $models->execute_kw($db, $uid, $password, 'res.partner',
    'read',  // Function name
    array($customer_ids), // An array of record ids
    array('fields'=>array('name', 'businessid')) // Array of wanted fields
);

//echo json_encode($customers);

echo "<p><strong>Found customers :</strong><br/>";
	foreach($customers as $customer){
		echo $customer['name']." ".$customer['id']."<br/>";
	}
echo "</p>";	
*/

/**
**Sales
**/
$order = $models->execute_kw($db, $uid, $password, 'sale.order', 'search_read', array(array(array('is_expired', '=', false)/*, array('name', '=', $name)*/)), array(
                    'limit' => 200/*,
                    'fields' => array(
                        'name',
                        'state',
                        'date_order',
                        'user_id',
                        'partner_id',
                    	'amount_total')*/));


        echo json_encode($order);

/*
echo "<p><strong>Sales Order :</strong><br/>";
echo "<table id='sales'>
		<tr><th>Name</th><th>State</th><th>Date_order</th><th>SalesPerson</th><th>Amount $</th><th>Customer</th></tr>";

	foreach($order as $sale){
		echo "<tr>
				<td>".$sale['name']."</td>
				<td>".$sale['state']."</td>
				<td>".$sale['date_order']."</td>
				<td>".$sale['user_id'][1]."</td>
				<td>".$sale['amount_total']."</td>
				<td>".$sale['partner_id'][1]."</td>
			  </tr>";
	}
echo "</p>";
*/

 ?>
</body>
</html>