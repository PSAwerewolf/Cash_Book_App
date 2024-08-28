<?php
include "configProductSales.php";

// Get data from POST request
$productName = $_POST['expense_desc'];
$totalPrice = $_POST['total_price'];
$addedDate = $_POST['added_date'];
$userId = $_POST['user_id'];

/*$productName = 'Apple';
$totalPrice = '500';
$addedDate = '2024-8-29 5:10:15';
$userId = '1';*/


try {
    // Prepare the SQL statement
    $stmt = $con->prepare("INSERT INTO shop_expense (expense_desc, total_amount, added_date,user_id) VALUES (?, ?, ?,?)");

    // Bind parameters to the SQL statement
    $stmt->bind_param("sdss", $productName, $totalPrice, $addedDate,$userId); // "sds" means: string, double, string

    // Execute the statement
    if ($stmt->execute()) {
        echo json_encode(['status' => 'Success']);
    } else {
        echo json_encode(['status' => 'Error', 'message' => $stmt->error]);
    }

    // Close the statement
    $stmt->close();
} catch (Exception $e) {
    echo json_encode(['status' => 'Error', 'message' => 'Exception: ' . $e->getMessage()]);
}

// Close the database connection
$con->close();
?>
