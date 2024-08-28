<?php
include "configProductSales.php";

// Get data from POST request
$productName = $_POST['product_name'];
$totalPrice = $_POST['total_price'];
$addedDate = $_POST['added_date'];

//$productName = 'Apple';
//$totalPrice = '500';
//$addedDate = '2024-8-29 5:10:15';


try {
    // Prepare the SQL statement
    $stmt = $con->prepare("INSERT INTO product_sales (product_name, total_price, added_date) VALUES (?, ?, ?)");

    // Bind parameters to the SQL statement
    $stmt->bind_param("sds", $productName, $totalPrice, $addedDate); // "sds" means: string, double, string

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
